---
aliases:
  - Kent Beck
sources:
  - sources/experts/Kent Beck.md
  - sources/practices/Test desiderata.md
  - sources/articles/Canon TDD.md
  - sources/quotes/Kent Beck Design Rules.md
related:
  - "[[practices/tdd]]"
  - "[[books/clean-code]]"
---

**Kent Beck** is a software engineer best known for rediscovering
**Test-Driven Development**, co-creating **Extreme Programming (XP)**, and
authoring the **JUnit** testing framework. His work is a through-line
across the modern practices of iterative development, automated testing,
and evolutionary design.

## Key ideas

- **Canon TDD** — the disciplined TDD loop: test, behavior change,
  structure change, integrate.
- **Rules of Simple Design** — code is simple if it (1) passes all tests,
  (2) reveals intention, (3) has no duplication, and (4) minimizes
  elements — in that order of priority.
- **Test Desiderata** — tests should be isolated, composable, fast,
  inspiring, writable, readable, behavioral, structure-insensitive,
  automated, specific, deterministic, and predictive. These pull against
  each other, and the engineer's job is to balance them on purpose.
- **3X: Explore / Expand / Extract** — the needs of a software system
  change with its stage; a technique that is right during exploration is
  wrong during extraction.

## Sources

- `sources/experts/Kent Beck.md` — the Wikipedia entry.
- `sources/practices/Test desiderata.md` — Beck's desiderata list.
- `sources/articles/Canon TDD.md` — "Canon TDD" essay.
- `sources/quotes/Kent Beck Design Rules.md` — Martin Fowler's writeup of
  Beck's simple-design rules.

## Related

- [[practices/tdd]] — Beck's signature practice.
- [[books/clean-code]] — Clean Code leans heavily on Beck's test-first and
  simple-design ideas.
