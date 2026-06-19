# Deep Read Records

This folder stores one traceable record per forum thread once the source can be read.

Use:

```powershell
.\tools\new-deep-read-note.ps1 -CategoryId 3 -ThreadId 2781 -Title "optional title"
```

Verify:

```powershell
.\tools\verify-deep-read-records.ps1
```

Rules:

- One file per thread.
- Do not mark a thread as `specialized` until the source, replies, safety review, topic writeback, and verification are complete.
- Do not paste full unauthorized source code.
- Do not paste real tokens, keys, cookies, card/license algorithms, admin URLs, or abuse/bypass steps.
- Keep raw forum dumps under `sources/raw/`, which is ignored by Git.
- Run the verifier before counting a record as learned.
