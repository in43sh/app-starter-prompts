# Design System Prompt

I want to create a reusable design prompt for my project that I can feed to AI design tools like v0.dev, Bolt, Lovable, Stitch, or Galileo to generate pages and components that are visually consistent.

Ask me questions in stages — don't dump everything at once. Start with brand personality and colors, then typography, then layout and components, then pages. Wait for my answers before moving to the next stage.

If I don't know a detail, help me choose by presenting concrete options with a clear recommendation. For anything unresolved, use a clearly labeled placeholder rather than inventing a value.

Output quality bar:

- Use exact hex values for every color — no vague descriptions like "dark blue."
- Typography must include specific pixel sizes and font-weight values, not ranges.
- Component specs must be precise enough that two different design tools produce visually similar results from the same prompt.
- Every page spec must list all UI elements, their layout position, and their visual treatment — not just the overall layout.

## Stage 1 — Brand & Colors

- What is the brand personality in 2–3 words? (e.g. "bold and direct", "calm and minimal", "playful and approachable")
- What is the primary brand color? (or should I suggest one based on personality?)
- Is there an accent or highlight color used for calls-to-action and emphasis?
- What are the text colors? (headings, body, captions, disabled)
- What are the background colors? (primary surface, secondary/alternate sections)
- What are the status colors? (success, error, warning, info)
- Are there any colors, styles, or aesthetics to actively avoid?

## Stage 2 — Typography

- What font family? (Google Font, system font stack, or custom — if unsure, I'll suggest one)
- What font weights are needed? (e.g. 400 body, 700 headings, 900 hero)
- What are the key text sizes for: hero headline, section headings (H2/H3), body copy, small labels, and captions?
- Any special text treatments? (e.g. tabular numbers for financial or data values, tight letter-spacing for uppercase labels, wide tracking for badges)

## Stage 3 — Layout & Components

- What is the maximum content width? (e.g. 1280px, 1440px)
- How should the layout feel — tight and dense, or spacious and airy?
- What border radius style? (sharp/0px, slightly rounded/4–8px, rounded/12–16px, pill/9999px)
- What is the card style? (border, shadow, background color, hover state)
- What do primary and secondary buttons look like? (background, text color, font weight, padding, border)
- What do form inputs look like? (border color, focus ring, background)
- Are there any recurring component patterns specific to this project? (e.g. section label above headings, stat tiles, trust pills, status badges, step indicators)
- What is the navigation pattern? (top navbar, sidebar, bottom tabs — and on mobile: hamburger drawer, bottom bar, or tabs)
- What icon library? (e.g. Heroicons, Lucide, FontAwesome — if unsure, I'll suggest one)
- How are images and media displayed? (aspect ratio for cards, gradient overlays, placeholder/fallback strategy)
- Does this need a dark mode or alternate theme?
- What should be explicitly avoided at the component level? (e.g. no gradients on primary surfaces, no heavy borders, no drop shadows on text)
- Mobile-first or desktop-first?

## Stage 4 — Pages & Screens

List every page or screen that needs to be designed. For each one, answer:

- What is the page's purpose in one sentence?
- What is the main layout? (columns, sidebar, full-width, centered card, etc.)
- What is the primary user action on this page?
- What are all the key UI elements? (be exhaustive — headers, forms, cards, tables, CTAs, etc.)
- Are there any modals, drawers, or overlays triggered from this page?
- What states must be shown? (empty, loading, error, success, logged-in vs. logged-out, role-specific variants)

After I answer, produce the following document:

---

### `DESIGN_PROMPT.md`

A complete design generation prompt for use with AI design tools. Include every section below:

**Master Prompt** — a single self-contained block (inside a fenced code block) that can be pasted into any AI design tool to generate any page in this project. Structure it as:

- Brand intro — name, personality, what to avoid, the overall feel
- Brand & Colors — every color with its name, exact hex value, and usage rule (what it is used for, what it is not used for)
- Typography — font family, every weight in use, every size with its usage context
- Layout Rules — max content width, spacing rhythm, border radius, card style, shadow style, responsive behavior
- Component Style — precise visual spec for every recurring element: exact colors, font weights, padding, border treatment, hover/active states, and any special variants. Be specific enough that no clarification is needed.
- What to avoid — an explicit list of patterns, styles, and aesthetics this design must never use (e.g. "no gradients on primary surfaces", "no heavy drop shadows", "no centered hero text"). This prevents design tools from defaulting to generic patterns.

**Page Specs** — one section per page or screen, each containing:

- A one-sentence description of the page's purpose
- Layout description — column structure, sticky elements, mobile behavior
- A complete list of all UI elements on the page, their position, and their visual treatment
- States to show — any empty, loading, error, or role-based variants
- A self-contained variant prompt (inside a fenced code block) — a shorter, focused version of the master prompt that generates just this page. Should include enough brand context to work standalone.

**Component Variant Prompts** — short, focused prompts (each inside its own fenced code block) for generating individual components in isolation (e.g. a card, a modal, a form step, a navigation bar). Include one for every component that appears across multiple pages.

---

> **Goal:** The master prompt should produce a visually consistent result when pasted into v0.dev, Bolt, Lovable, or Stitch — with no further clarification needed. Page variant prompts should work standalone for generating individual screens.
