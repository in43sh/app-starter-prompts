# API / Backend Kickoff

I want to start a new backend project. Help me think through it from scratch — the goal is to produce a complete, AI-ready spec that I can hand to an AI coding assistant to build from.

Ask me questions in stages — don't dump everything at once. Start with vision and goals, then dig into consumers and contracts, then requirements, then tech stack, then structure. Wait for my answers before moving to the next stage.

If I do not know a materially important detail, help me choose by presenting a small set of sensible options and recommending one with brief reasoning. Do not present a recommendation as a confirmed requirement unless I explicitly accept it. If an important detail remains unresolved, mark it as an explicit assumption or include it in `OPEN_QUESTIONS.md` instead of inventing it.

Output quality bar:

- Use concrete defaults and explicit values wherever possible.
- Do not use vague phrases like "as needed", "etc.", "TBD" in final specs unless the item is truly unresolved and is clearly labeled as an assumption or open question.
- Use tables, bullet lists, and numbered flows whenever they make the spec easier to implement unambiguously.

## Stage 1 — Vision

- What problem does this solve?
- Who or what consumes this? (web frontend, mobile app, third-party integrations, internal services, CLI users, etc.)
- What does success look like at launch?
- Is there an existing API or service I'm replacing or extending?
- Is there an OpenAPI spec, Postman collection, or any existing contract to start from?

## Stage 2 — Consumers & Contracts

- Who are the primary API consumers? (developers, services, automated scripts, etc.)
- What are the core operations the API must support? (what does a consumer actually *do*?)
- What are the non-negotiable requirements vs. nice-to-haves?
- Does the API need to be public, internal-only, or partner-facing?
- Synchronous (request/response) or asynchronous (queues, webhooks, events)?

## Stage 3 — Scope & Constraints

- What is explicitly out of scope for v1?
- Does this need to integrate with anything existing? (databases, external APIs, message queues, etc.)
- Any compliance, security, or privacy requirements? (GDPR, HIPAA, SOC 2, data residency, etc.)
- SLA requirements? (uptime, response time, throughput targets)
- API versioning strategy? (URI versioning `/v1/`, headers, none for now)

## Stage 4 — Tech Stack

- Language and runtime? (Node.js, Python, Go, etc.)
- Framework preferences? (Express, Fastify, FastAPI, etc.)
- What kind of data storage is needed? (relational, document, key-value, search, time-series)
- Auth strategy? (API keys, JWT, OAuth 2.0, session cookies, none)
- Does this need background jobs, scheduled tasks, or event processing?
- File uploads or binary data handling?
- Caching strategy? (in-memory, Redis, CDN, none)
- Hosting preferences? (self-hosted, Vercel, Railway, Fly.io, AWS, etc.)
- Contract-first (design OpenAPI spec first) or code-first?

## Stage 5 — Project Structure & Testing

- Monorepo or separate repo?
- What's the testing strategy? (unit, integration, e2e, contract tests)

After I answer, produce the following three documents:

---

### 1. `API_DOCUMENT.md`

A complete, self-contained implementation spec. Include every section below:

- **Project Overview** — one-paragraph brief and tech stack table
- **API Design** — style (REST/GraphQL/RPC), base URL, versioning strategy, content types, pagination/filtering/sorting conventions, and deprecation/backward-compatibility rules
- **Authentication & Authorization** — auth method, token format, how consumers obtain credentials, protected vs. public endpoints
- **Endpoints** — for every endpoint: method, path, description, path/query params, request body (with types), response shape (with types), error cases, and idempotency expectations where applicable. Use a consistent format throughout.
- **Error Handling** — standard error response format, HTTP status code conventions, error code catalogue
- **Data Architecture** — full database schema (table/collection, field name, type, constraints, notes for every field), indexes worth noting
- **Background Jobs / Events / Webhooks** — for each: name, trigger, what it does, retry/failure handling. Include outbound webhooks (event, payload shape, delivery guarantees). Omit section if none.
- **Upstream Integrations** — for each external dependency: purpose, timeout expectations, retry policy, circuit-breaking/fallback behavior, and what happens when the upstream service is degraded or unavailable. Omit if none.
- **Rate Limiting** — limits per consumer type, headers returned, behavior when exceeded (omit if none)
- **Security** — secret management, input validation, injection prevention, sensitive data handling, CORS policy
- **Project Structure** — full folder/file tree with inline comments explaining each file's role
- **Environment Variables** — all vars, which are secret vs. safe to commit, `.env.example` contents
- **Testing Strategy** — what to test at each level (unit, integration, e2e), key test cases to write first
- **Implementation Order** — numbered build steps in the correct sequence

### 2. `DECISIONS.md`

An architectural decisions record (ADR) for every major technical choice (runtime, framework, database, auth, hosting, async vs. sync, etc.). For each decision:

- **Decision:** What was chosen and when
- **Alternatives considered:** Comparison table (option, pros, cons, complexity/cost)
- **Why this choice:** 3–5 specific bullet reasons
- **When to reconsider:** Concrete triggers for revisiting (e.g. "if throughput exceeds X" or "if we add multi-tenancy")

End with a summary table of all decisions.

### 3. `OPEN_QUESTIONS.md`

- Unresolved decisions that must be answered before build starts (placeholders, unknowns, TBDs)
- Edge cases and spec gaps that weren't covered
- Conflicts between requirements or between callers' expectations
- Post-v1 improvement ideas to revisit later

---

> **Goal:** The documents should be precise enough for an AI coding assistant to implement the entire project from scratch without asking clarifying questions.
