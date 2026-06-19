# Security Policy

This repository is meant to be safe for public GitHub publishing. It may discuss automation architecture, OCR, UI scripting, backend setup, and update flows, but it must not expose secrets or abuse-enabling implementation details.

## Do Not Commit

- Real API keys, tokens, cookies, passwords, session IDs, or private certificates.
- Private backend URLs, admin panels, internal dashboards, or non-public endpoints.
- Card/license generation or validation algorithms.
- Bypass steps for captcha, ads, payments, identity checks, or access controls.
- Full copied source code from forum posts or paid/private tutorials.
- Raw forum dumps, downloaded attachments, screenshots, videos, or logs that have not been reviewed.

## Safe Examples

Use fake values:

```text
API_TOKEN: example_token_replace_me
BACKEND_URL: https://example.invalid/api
LICENSE_ID: demo-license-id
```

Use pseudo-code when a source explains a sensitive workflow:

```text
validate input -> check local state -> call safe endpoint -> handle failure -> log sanitized result
```

## Reporting Problems

If a file appears to contain a secret or unsafe implementation detail:

1. Remove or redact the sensitive value.
2. Replace it with a fake example value if the structure is useful.
3. Add a short note explaining the safe public pattern.
4. Run `tools/verify-learning-library.ps1`.

If the sensitive value may have been published, rotate the real secret outside this repository. Deleting it from a later commit is not enough.

## Review Before Publishing

Run these checks before pushing to GitHub:

```powershell
.\tools\verify-deep-read-records.ps1
.\tools\verify-learning-library.ps1
```

The verifier may warn on security-related words because this library intentionally documents what must not be published. Treat warnings as a review queue, not as automatic approval.
