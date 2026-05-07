---
name: gitlab-mr-review
description: Read a GitLab merge request and return a concise summary, risks, and standards compliance findings.
---

When asked to review a GitLab merge request:
1. Read the merge request reference from the prompt:
   - Full URL: `https://<gitlab-host>/<group>/<project>/-/merge_requests/<iid>`, or
   - Explicit project path and merge request IID.
2. Run shell snippets with `set -euo pipefail`.
3. Validate prerequisites before network calls:
   - Required tool: `glab` (GitLab CLI). Stop with a clear error if missing.
   - `glab` must already be authenticated (`glab auth status`). If not, instruct the user to run `glab auth login`.
   - If a full URL is provided, extract the host, project path (`<group>/<project>`), and MR IID from it.
     Set the host with `--hostname <gitlab-host>` on every `glab` call when it differs from the default.
4. Fetch merge request data using `glab`:
   - MR details:
     ```
     glab mr view <iid> --repo <group>/<project> --output json
     ```
   - MR diff (changed files and patch):
     ```
     glab mr diff <iid> --repo <group>/<project>
     ```
   - If the project lives on a non-default GitLab host, append `--hostname <gitlab-host>` to each command.
5. Read repository standards from the repo root:
   - Determine root using `git rev-parse --show-toplevel`.
   - Read `${repo_root}/.github/copilot-instructions.md`.
   - If missing, state that standards file is not present.
6. Analyze MR title/description and diff:
   - Summarize key changes.
   - Flag potential bugs, security issues, reliability risks, Terraform anti-patterns, and poor coding practices.
   - Cross-check findings against `.github/copilot-instructions.md` and cite relevant rules.
7. Return exactly these sections:
   - `Merge Request`
   - `Change Summary`
   - `Potential Problems`
   - `Standards Compliance (.github/copilot-instructions.md)`
   - `Recommended Follow-ups`
8. Extract the Jira ticket number from the MR title or description if present
   (e.g., `PROJ-1234`) and lookup the ticket summary using the Jira API.
   Include the ticket summary in the `Merge Request` section. If no ticket is
   found, state that explicitly. Ensure that the MR seems to accomplish the stated
   Jira ticket goals based on the description and diff.
9. Output rules:
   - Be evidence-based and concise.
   - For each issue include severity (`High`, `Medium`, `Low`) and file path.
   - If nothing significant is found, write `No significant problems identified`.

Security requirements:
- Never print or persist authentication tokens.
- Do not hardcode credentials; rely entirely on `glab`'s stored auth context.
