#!/usr/bin/env node

import { mkdir, writeFile } from "node:fs/promises";
import path from "node:path";

const args = new Map();
for (let i = 2; i < process.argv.length; i += 1) {
  const key = process.argv[i];
  if (!key.startsWith("--")) continue;
  const next = process.argv[i + 1];
  if (!next || next.startsWith("--")) {
    args.set(key.slice(2), "true");
  } else {
    args.set(key.slice(2), next);
    i += 1;
  }
}

const outputDir = args.get("output-dir") || "sources/raw-browser";
const skipCategories = args.has("skip-categories");
const categoryIds = (args.get("category-ids") || (skipCategories ? "" : "3"))
  .split(",")
  .map((value) => Number.parseInt(value.trim(), 10))
  .filter((value) => Number.isFinite(value));
const pageLimit = Number.parseInt(args.get("page-limit") || "100", 10);
const maxPages = Number.parseInt(args.get("max-pages") || "0", 10);
const fetchThreadDetails = args.has("fetch-thread-details");
const fetchPosts = args.has("fetch-posts");
const timeoutMs = Number.parseInt(args.get("timeout-ms") || "25000", 10);
const retries = Number.parseInt(args.get("retries") || "0", 10);
const retryDelayMs = Number.parseInt(args.get("retry-delay-ms") || "1000", 10);

const category3Batches = {
  "c3-04": [17723, 20880, 19820, 547, 18034, 7819, 20593, 16774, 13280, 19666, 21083, 17676, 17694, 11207, 20884, 996, 14729, 860, 4673, 17258],
  "c3-05": [9293, 235, 20139, 2216, 14471, 12405, 19519, 17274, 20012, 9428, 19987, 215, 14770, 19802, 6206, 14991, 19593, 959, 712, 18503],
  "c3-06": [11433, 11833, 813, 203, 6202, 17975, 2321, 18825, 18809, 17734, 7333, 18480, 17743, 18041, 13622, 10643, 17843, 13448, 17733, 17721],
  "c3-07": [17642, 17432, 14723, 13510, 924, 5945, 11861, 17114, 3425, 10637, 6208, 16233, 14908, 16151, 15574, 5942, 14820, 10330, 11360, 14496],
  "c3-08": [15246, 15143, 13519, 13703, 15001, 6882, 708, 13535, 9273, 11781, 14330, 14329, 13518, 13526, 14132, 4397, 1289, 13696, 13522, 133],
  "c3-09": [13611, 13540, 13548, 13541, 13539, 13536, 13529, 13520, 13523, 13478, 12535, 13251, 5316, 12529, 12564, 847, 7197, 9379, 1477, 2624],
  "c3-10": [1114, 10719, 10512, 10673, 4522, 5555, 3728, 3280, 1744, 1769, 1655, 856]
};

const c3Batch = args.get("c3-batch") || "";
if (c3Batch && !Object.prototype.hasOwnProperty.call(category3Batches, c3Batch)) {
  throw new Error(`Unknown --c3-batch ${c3Batch}; expected one of ${Object.keys(category3Batches).join(", ")}`);
}

const explicitThreadIds = (args.get("thread-ids") || "")
  .split(",")
  .map((value) => Number.parseInt(value.trim(), 10))
  .filter((value) => Number.isFinite(value));
const threadIds = [...new Set([...explicitThreadIds, ...(category3Batches[c3Batch] || [])])].sort((a, b) => a - b);

const headers = {
  "accept": "application/json,text/plain,*/*",
  "mbbs-domain": "zdjl.mbbs.cc",
  "referer": "https://bbs.zdjl.site/",
  "user-agent": "Mozilla/5.0 Chrome"
};

async function ensureDir(dir) {
  await mkdir(dir, { recursive: true });
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function fetchJsonOnce(url) {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), timeoutMs);
  let response;
  let text = "";
  try {
    response = await fetch(url, { headers, signal: controller.signal });
    text = await response.text();
  } finally {
    clearTimeout(timer);
  }
  if (!response.ok) {
    const contentType = response.headers.get("content-type") || "";
    throw new Error(`HTTP ${response.status} ${contentType}: ${text.slice(0, 200)}`);
  }
  try {
    return JSON.parse(text);
  } catch (error) {
    throw new Error(`Invalid JSON from ${url}: ${text.slice(0, 200)}`);
  }
}

async function fetchJson(url) {
  let lastError;
  for (let attempt = 0; attempt <= retries; attempt += 1) {
    try {
      return await fetchJsonOnce(url);
    } catch (error) {
      lastError = error;
      if (attempt < retries) {
        await sleep(retryDelayMs);
      }
    }
  }
  throw lastError;
}

async function saveJson(filePath, data) {
  await ensureDir(path.dirname(filePath));
  await writeFile(filePath, `${JSON.stringify(data, null, 2)}\n`, "utf8");
}

function firstArray(object, paths) {
  for (const pathText of paths) {
    const parts = pathText.split(".");
    let current = object;
    for (const part of parts) {
      current = current?.[part];
      if (current == null) break;
    }
    if (Array.isArray(current)) return current;
  }
  return [];
}

const startedAt = new Date().toISOString();
const errors = [];
const categorySummaries = [];
const allThreadIds = new Set();

await ensureDir(outputDir);
await ensureDir(path.join(outputDir, "categories"));
await ensureDir(path.join(outputDir, "threads"));
await ensureDir(path.join(outputDir, "posts"));

for (const categoryId of categoryIds) {
  const categoryDir = path.join(outputDir, "categories", `category-${categoryId}`);
  await ensureDir(categoryDir);

  const ids = new Set();
  let offset = 0;
  let pageIndex = 0;

  while (true) {
    if (maxPages > 0 && pageIndex >= maxPages) break;
    const url = `https://bbs.zdjl.site/bbs/threads/list?category_id=${categoryId}&page_offset=${offset}&page_limit=${pageLimit}&sort=-posted_at`;

    try {
      const data = await fetchJson(url);
      await saveJson(path.join(categoryDir, `page-${String(pageIndex).padStart(4, "0")}.json`), data);
      const pageItems = firstArray(data, ["data", "data.list", "data.threads", "data.items", "list", "threads", "items"]);
      for (const item of pageItems) {
        if (Number.isFinite(Number(item?.id))) {
          ids.add(Number(item.id));
          allThreadIds.add(Number(item.id));
        }
      }
      pageIndex += 1;
      offset += pageLimit;
      if (pageItems.length < pageLimit) break;
    } catch (error) {
      errors.push({
        scope: "category",
        category_id: categoryId,
        page_index: pageIndex,
        url,
        error: String(error?.message || error)
      });
      break;
    }
  }

  const threadIdList = [...ids].sort((a, b) => a - b);
  const manifest = {
    category_id: categoryId,
    fetched_at: new Date().toISOString(),
    page_limit: pageLimit,
    pages_fetched: pageIndex,
    unique_threads: threadIdList.length,
    thread_ids: threadIdList
  };
  await saveJson(path.join(categoryDir, "manifest.json"), manifest);
  categorySummaries.push(manifest);
}

let detailIds = [];
if (threadIds.length > 0) {
  detailIds = [...new Set(threadIds)].sort((a, b) => a - b);
} else if (fetchThreadDetails || fetchPosts) {
  detailIds = [...allThreadIds].sort((a, b) => a - b);
}

for (const threadId of detailIds) {
  if (fetchThreadDetails) {
    const url = `https://bbs.zdjl.site/bbs/threads/${threadId}`;
    try {
      const data = await fetchJson(url);
      await saveJson(path.join(outputDir, "threads", `${threadId}.json`), data);
    } catch (error) {
      errors.push({ scope: "thread", thread_id: threadId, url, error: String(error?.message || error) });
    }
  }

  if (fetchPosts) {
    let offset = 0;
    let pageIndex = 0;
    while (true) {
      if (maxPages > 0 && pageIndex >= maxPages) break;
      const url = `https://bbs.zdjl.site/bbs/posts/list?thread_id=${threadId}&page_offset=${offset}&page_limit=${pageLimit}&sort=created_at`;
      try {
        const data = await fetchJson(url);
        await saveJson(path.join(outputDir, "posts", `${threadId}-page-${String(pageIndex).padStart(4, "0")}.json`), data);
        const pageItems = firstArray(data, ["data", "data.list", "data.posts", "data.items", "list", "posts", "items"]);
        pageIndex += 1;
        offset += pageLimit;
        if (pageItems.length < pageLimit) break;
      } catch (error) {
        errors.push({ scope: "posts", thread_id: threadId, page_index: pageIndex, url, error: String(error?.message || error) });
        break;
      }
    }
  }
}

const summary = {
  checked_at: new Date().toISOString(),
  started_at: startedAt,
  output_dir: path.resolve(outputDir),
  timeout_ms: timeoutMs,
  retries,
  retry_delay_ms: retryDelayMs,
  skipped_categories: skipCategories,
  c3_batch: c3Batch || null,
  categories: categorySummaries,
  requested_thread_details: fetchThreadDetails,
  requested_posts: fetchPosts,
  detail_thread_count: detailIds.length,
  error_count: errors.length,
  errors
};

await saveJson(path.join(outputDir, "sync-summary.json"), summary);
console.log(JSON.stringify(summary, null, 2));

if (errors.length > 0) {
  process.exitCode = 1;
}
