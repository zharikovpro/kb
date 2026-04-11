---
aliases:
  - Sentry
sources:
  - sources/software/Sentry.md
related: []
---

**Sentry** is a hosted application monitoring and error-tracking service.
It captures exceptions, performance traces, and release metadata from
instrumented applications and surfaces them in a web UI for triage.

## Key ideas

- Errors are captured with full stack traces, breadcrumbs (recent events
  leading to the error), and environment metadata, which collapses the
  "can't reproduce" class of bug reports.
- Releases are a first-class concept: a given error is tied to the commit
  and deploy that introduced it, enabling regression detection.
- Performance monitoring (traces) and error monitoring share the same
  event model, so slow code paths and failing code paths can be
  investigated with the same tools.

## Sources

- `sources/software/Sentry.md` — the stub pointing at `sentry.io`.

## Related

- (no other wiki pages yet)
