# App Starter Prompts

A collection of structured AI prompts for kicking off new software projects. Use these as starting points when working with an AI coding assistant to produce a complete, implementation-ready spec.

## How to use

Copy the relevant prompt into your AI assistant, answer the staged questions, and receive a full project specification document ready for vibecoding.

## Prompts

| File | Purpose |
|------|---------|
| [docs/00-kickoff-web-app.md](docs/00-kickoff-web-app.md) | Web / frontend project kickoff — produces `MVP_DOCUMENT.md`, `DECISIONS.md`, `OPEN_QUESTIONS.md` |
| [docs/00-kickoff-api.md](docs/00-kickoff-api.md) | API / backend project kickoff — produces `API_DOCUMENT.md`, `DECISIONS.md`, `OPEN_QUESTIONS.md` |

## Output documents

Each prompt guides the AI through 5 stages of questions, then generates:

- **MVP_DOCUMENT / API_DOCUMENT** — complete implementation spec (pages, schema, endpoints, security, project structure, env vars, build order)
- **DECISIONS.md** — architectural decision records (ADRs) with alternatives and rationale
- **OPEN_QUESTIONS.md** — unresolved questions, edge cases, and post-v1 ideas
