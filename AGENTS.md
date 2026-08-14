# Content and style

- Use `/home/areo/Documents/Studium/Pico-OS/README.md` as the authority; check
  compiler/emulator READMEs only for referenced contracts.
- Keep information terse and lookup-oriented: syntax, limits, results, and
  state transitions over background prose.
- Preserve the three-column layout, one-page fit, existing color semantics, and
  typography. Keep unrelated manual edits.

# `UPDATE_CHEATSHEET`

1. Compare the PicoOS README with its recent Git changes.
2. Update matching cards in `cheatsheet.typ`; add/reorder only when useful.
3. Build with `make build-pdf` and fix overflow or warnings. Do not run PicoOS
   tests unless requested.
