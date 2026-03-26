# Contributing

## Adding a new prompt

1. Create a file in `docs/` with the next available number prefix (e.g. `03-kickoff-mobile.md`)
2. Follow the existing structure: staged questions → output document specs
3. Update the table in [README.md](README.md)

## Improving an existing prompt

- Keep questions stage-by-stage — don't collapse everything into one block
- Output document specs should be precise enough for an AI to implement without follow-up questions
- If you change required output sections, update the matching files in `examples/` in the same PR
- Run `./scripts/validate.sh` after changing `docs/` or `examples/`
- Test the prompt against a real project before submitting

## Naming convention

```text
docs/NN-<type>-<variant>.md
```

Examples: `00-kickoff-web-app.md`, `00-kickoff-api.md`, `01-feature-spec.md`, `03-kickoff-mobile.md`

## Submitting changes

Open a pull request with a short description of what the prompt covers and what output it produces.
