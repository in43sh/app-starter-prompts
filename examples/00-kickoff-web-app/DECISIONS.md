# DECISIONS.md

## ADR-001: Use Next.js App Router and Supabase

| Option | Pros | Cons | Complexity/Cost |
| --- | --- | --- | --- |
| Next.js + Supabase | fast setup, built-in auth patterns, good Vercel fit | some vendor coupling | low |
| Remix + Postgres | explicit data loading, flexible hosting | more setup work | medium |
| Rails | batteries included | heavier stack than needed | medium |

- Decision: Use Next.js App Router with Supabase on 2026-03-12.
- Why this choice:
  - Small team can ship faster with managed auth and storage.
  - SSR pages and server actions fit the product shape.
  - Vercel deployment is straightforward for a city-level MVP.
- When to reconsider:
  - If moderation workflows require heavy background processing.
  - If vendor lock-in becomes a pricing issue.

## ADR-002: Radius-based discovery by ZIP and coordinates

| Option | Pros | Cons | Complexity/Cost |
| --- | --- | --- | --- |
| ZIP + lat/lng | easy initial search, enough for local discovery | not true route distance | low |
| Full geospatial polygons | accurate | overkill for MVP | high |
| City-only browsing | simplest | poor relevance in dense cities | low |

- Decision: Store ZIP and coordinates for radius search.
- Why this choice:
  - Gives better relevance than city-level browsing.
  - Keeps schema simple.
  - Leaves room for PostGIS later.
- When to reconsider:
  - If users complain about distance accuracy.

## Summary

| ADR | Choice |
| --- | --- |
| 001 | Next.js App Router + Supabase |
| 002 | ZIP + coordinate radius search |

Build the smallest trustworthy local marketplace that can be safely moderated.
