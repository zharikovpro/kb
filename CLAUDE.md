# kb — LLM Wiki Schema

This repository is an **LLM wiki** following the pattern described in
[Karpathy's gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f):
an LLM incrementally builds and maintains a persistent wiki on top of an
immutable corpus of raw sources, so knowledge compounds across sources instead
of being re-derived at every query.

## Three Layers

1. **`sources/`** — the raw input layer. Reference notes pointing at or
   excerpting external material (articles, books, talks, tools, etc.). The
   LLM **reads** this layer but **never modifies** it. Files here are the
   ground truth. New entries are added by the human owner (or by the LLM
   under explicit instruction to *add a source*, not to rewrite one).
2. **`wiki/`** — the LLM-maintained output layer. Synthesized pages the LLM
   creates and updates while ingesting sources, answering queries, and
   linting. This is where knowledge accumulates.
3. **`CLAUDE.md`** (this file) — the schema. It tells the LLM how the
   sources and wiki layers are structured and what operations it may
   perform on them.

## Folder Taxonomy

`wiki/` mirrors `sources/`. The same 18 categories exist in both trees:

```
articles/      frameworks/    newsletters/    practices/    software/
books/         guides/        organizations/  principles/   standards/
experts/       languages/     philosophies/   quotes/       videos/
formats/       methodologies/ reports/
```

A wiki page lives in the category that matches its primary source's folder.
A TDD page sourced from `sources/practices/TDD Test Driven Development.md`
goes in `wiki/practices/tdd.md`. When a topic is cross-cutting (e.g. Kent
Beck is an expert but is cited from many practices and books), it gets
**one** primary page in its natural category (`wiki/experts/kent-beck.md`)
and is reached from other categories via `related` links.

## Page Naming

- Format: `wiki/<category>/<slug>.md`
- `<slug>` is kebab-case derived from the canonical title.
  - `TDD` → `tdd`
  - `DRY Don't Repeat Yourself` → `dry`
  - `Clean Code: A Handbook...` → `clean-code`
  - `Kent Beck` → `kent-beck`
- Prefer the shortest unambiguous slug. Ambiguity is resolved by the
  category, not by lengthening the slug.

## Page Frontmatter

Every wiki page begins with a YAML frontmatter block. No `updated` field —
`git log` is the modification history.

```yaml
---
aliases: []          # alternative names, abbreviations
sources: []          # repo-relative paths into sources/ that back this page
related: []          # Obsidian-style [[wiki-links]] to other wiki pages
---
```

- `sources` must list **real paths** under `sources/`. Every claim in the
  body should be traceable to at least one listed source.
- `related` uses Obsidian `[[link]]` syntax. Keep the display form stable —
  e.g. `[[experts/kent-beck]]` — so links are greppable.
- Cross-category links are expected and encouraged; a concept page usually
  links to the people, books, and practices that shaped it.

## Page Body

Short and scannable. A seed page is typically:

1. One-paragraph summary (what is it, why does it matter).
2. A few bullet points of key ideas, distinctions, or rules.
3. A **Sources** section listing the files in `sources`, with a one-line
   note about what each contributes.
4. Optionally, a **Related** section linking out to other wiki pages.

Pages grow over time as more sources are ingested. They should not try to
be exhaustive on day one.

## Operations

The LLM performs three operations on this repository. All of them read
`sources/` and write only to `wiki/`.

### Ingest

Given one or more source files:

1. Read each source.
2. For each distinct entity or concept extracted, determine its category
   (matching the primary source's folder) and slug.
3. Create the wiki page at `wiki/<category>/<slug>.md` if it does not
   exist, or update it if it does.
4. Add every source path to the page's `sources` frontmatter.
5. Add reciprocal `related` links wherever the page connects to another
   existing wiki page (both sides must be updated).
6. Commit the ingest as a discrete git commit. `git log` is the operation
   history — there is deliberately no `wiki/log.md`.

### Query

Given a question:

1. Search `wiki/` first. If a page answers the question, use it.
2. Fall back to `sources/` when the wiki is silent or thin.
3. If the answer involved non-trivial synthesis across sources, file the
   synthesis back as a new or updated wiki page so the next query can reuse
   it. Commit that as a separate git commit.

### Lint

Periodically, scan `wiki/` for:

- **Orphans** — pages not reachable from `wiki/index.md`.
- **Broken links** — `related` entries pointing at non-existent pages.
- **One-way links** — `A → B` without `B → A`.
- **Category drift** — a page whose primary source has moved to a
  different category, or whose natural category no longer matches.
- **Stale claims** — statements contradicted by a newer source.
- **Source drift** — `sources` entries that no longer exist under
  `sources/`.

Report findings and fix the fixable ones in discrete commits.

## Navigation

- **`wiki/index.md`** — the content catalog. Organized by the same 18
  categories as `sources/`. Every non-index page under `wiki/` must be
  linked from here. Empty categories are listed with a `(no pages yet)`
  placeholder so the index is always a complete map of the taxonomy.
- There is no `wiki/log.md`. Use `git log -- wiki/` for history.

## Invariants

- The LLM must **never** modify files under `sources/`. Typo fixes,
  re-wordings, and reformatting all belong in `wiki/`, not in `sources/`.
- `wiki/` must never contain a page that lacks a `sources` entry. If a
  claim has no source, it does not belong in the wiki yet.
- Every file under `wiki/` (except `index.md` itself) is reachable from
  `wiki/index.md`.
