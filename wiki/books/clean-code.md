---
aliases:
  - Clean Code
sources:
  - sources/books/Clean Code A Handbook Of Agile Software Craftsmanship.md
related:
  - "[[practices/tdd]]"
  - "[[principles/dry]]"
  - "[[experts/kent-beck]]"
---

***Clean Code: A Handbook of Agile Software Craftsmanship*** (Robert C.
Martin, 2008) is a rule-driven catalog of what, in the author's view, makes
code readable and maintainable: small functions, meaningful names, few
arguments, clear boundaries, and tests as a first-class artifact. It is
opinionated and often cited, and the conventions it codifies — TDD, DRY,
SRP, boy-scout rule — have become baseline vocabulary on many teams.

## Key ideas

- Functions should be small, do one thing, and operate at a single level
  of abstraction.
- Names should reveal intent. Bad names are technical debt.
- **Boy-scout rule**: leave the code cleaner than you found it.
- Tests (specifically TDD) are not optional; they are part of the code
  that ships.
- Duplication (DRY) is a primary code smell.
- Comments that restate the code are a failure of naming; comments that
  explain *why* are sometimes necessary.

## Sources

- `sources/books/Clean Code A Handbook Of Agile Software Craftsmanship.md`
  — the book stub with a link to the canonical edition.

## Related

- [[practices/tdd]] — Clean Code treats TDD as a core discipline.
- [[principles/dry]] — duplication is called out as a top code smell.
- [[experts/kent-beck]] — Beck's ideas (test-first, refactoring,
  simple-design rules) are woven through the book.
