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

**Kickoff prompts** (`00-kickoff-*.md`) produce:

- **MVP_DOCUMENT.md / API_DOCUMENT.md** — complete implementation spec (pages, schema, endpoints, security, project structure, env vars, build order)
- **DECISIONS.md** — architectural decision records (ADRs) with alternatives and rationale
- **OPEN_QUESTIONS.md** — unresolved questions, edge cases, and post-v1 ideas

**Feature spec** (`01-feature-spec.md`) produces:

- **FEATURE_SPEC.md** — complete feature spec (flows, UI, API/data changes, permissions, edge cases, observability, rollout)
- **IMPLEMENTATION_PLAN.md** — task breakdown with acceptance criteria, dependencies, and risk table

**CLAUDE.md generator** (`02-claude-md.md`) produces:

- **CLAUDE.md** — AI quick-reference: stack, commands, structure, conventions, env vars, do-nots
