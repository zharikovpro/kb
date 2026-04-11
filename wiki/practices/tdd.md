---
aliases:
  - TDD
  - Test Driven Development
  - Test-First
sources:
  - sources/practices/TDD Test Driven Development.md
  - sources/practices/Test Driven Development.md
  - sources/practices/Test desiderata.md
  - sources/articles/Canon TDD.md
  - sources/articles/The Three Laws Of TDD.md
  - sources/articles/Test First.md
related:
  - "[[experts/kent-beck]]"
  - "[[books/clean-code]]"
  - "[[principles/dry]]"
---

**Test-Driven Development (TDD)** is a practice in which production code is
written in response to a failing test, one small step at a time. The rhythm
is *red → green → refactor*: write a test that fails, make it pass with the
minimum change, then clean up. TDD is primarily a design discipline — the
tests shape the code — and only secondarily a verification technique.

## Key ideas

- **The three laws** (Robert C. Martin): you may not write production code
  until you have a failing unit test; you may not write more of a unit test
  than is sufficient to fail; you may not write more production code than is
  sufficient to pass the current failing test.
- **Canon TDD** (Kent Beck): the loop is test, behavior-change, structure-change,
  integrate — each step small enough that the diff is obvious.
- TDD is an act of *design under pressure*: if a test is hard to write, the
  design is probably wrong.
- **Test desiderata** enumerates the properties tests should have
  (isolated, composable, fast, inspiring, writable, readable, behavioral,
  structure-insensitive, automated, specific, deterministic, predictive).
  They often trade off against each other — TDD is the act of balancing
  them deliberately.

## Sources

- `sources/practices/TDD Test Driven Development.md` — the Wikipedia entry.
- `sources/practices/Test Driven Development.md` — Martin Fowler's bliki
  definition.
- `sources/practices/Test desiderata.md` — Kent Beck's list of desirable
  test properties.
- `sources/articles/Canon TDD.md` — Kent Beck's "Canon TDD" essay.
- `sources/articles/The Three Laws Of TDD.md` — Robert C. Martin's three
  laws.
- `sources/articles/Test First.md` — Martin's defense of writing tests
  first.

## Related

- [[experts/kent-beck]] — the originator of TDD in its modern form.
- [[books/clean-code]] — TDD is a core discipline throughout.
- [[principles/dry]] — refactoring under green keeps duplication out.
