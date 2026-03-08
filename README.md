# App Starter Prompts

A collection of structured AI prompts for kicking off new software projects. Use these as starting points when working with an AI coding assistant to produce a complete, implementation-ready spec.

## How to use

1. Pick the prompt that matches your situation (see table below)
2. Copy the entire file contents
3. Paste it into your AI assistant as your first message
4. Answer the staged questions — the AI guides you through them one stage at a time
5. At the end, the AI generates the output documents
6. Save those files into your project's `/docs` folder and start building

## Prompts

| File | Purpose |
| --- | --- |
| [docs/00-kickoff-web-app.md](docs/00-kickoff-web-app.md) | Web / frontend project kickoff — produces `MVP_DOCUMENT.md`, `DECISIONS.md`, `OPEN_QUESTIONS.md` |
| [docs/00-kickoff-api.md](docs/00-kickoff-api.md) | API / backend project kickoff — produces `API_DOCUMENT.md`, `DECISIONS.md`, `OPEN_QUESTIONS.md` |
| [docs/01-feature-spec.md](docs/01-feature-spec.md) | Plan a new feature in an existing project — produces `FEATURE_SPEC.md`, `IMPLEMENTATION_PLAN.md` |
| [docs/02-claude-md.md](docs/02-claude-md.md) | Generate a `CLAUDE.md` quick-reference for an existing codebase |

## Output documents

Each prompt guides the AI through 5 stages of questions, then generates:

- **MVP_DOCUMENT / API_DOCUMENT** — complete implementation spec (pages, schema, endpoints, security, project structure, env vars, build order)
- **DECISIONS.md** — architectural decision records (ADRs) with alternatives and rationale
- **OPEN_QUESTIONS.md** — unresolved questions, edge cases, and post-v1 ideas
