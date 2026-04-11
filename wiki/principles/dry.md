---
aliases:
  - DRY
  - Don't Repeat Yourself
sources:
  - sources/principles/DRY Don T Repeat Yourself.md
related:
  - "[[practices/tdd]]"
  - "[[books/clean-code]]"
---

**Don't Repeat Yourself (DRY)** — every piece of knowledge must have a
single, unambiguous, authoritative representation within a system (Hunt &
Thomas, *The Pragmatic Programmer*). DRY is about *knowledge*, not
*syntax*: two fragments that happen to look alike but encode different
decisions are not duplication, and two fragments that look different but
encode the same decision are.

## Key ideas

- Duplication is expensive because every copy must change in lockstep when
  the underlying decision changes. Missed copies become bugs.
- DRY applies to code, tests, data, documentation, and build rules — any
  place a decision can live.
- The cost of premature abstraction is worse than the cost of a little
  repetition. Three similar lines beat the wrong shared abstraction.
- The *refactor* step of TDD is when most DRY violations get cleaned up,
  which is why DRY lives next to TDD in practice.

## Sources

- `sources/principles/DRY Don T Repeat Yourself.md` — the Wikipedia entry.

## Related

- [[practices/tdd]] — refactoring under a green bar is where DRY is
  enforced.
- [[books/clean-code]] — treats duplication as a primary code smell.
