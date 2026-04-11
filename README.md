# kb

A personal knowledge base on software development, structured as an
**LLM wiki** — an LLM incrementally builds and maintains synthesized
pages on top of an immutable corpus of raw sources. Based on
[Karpathy's gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f).

## Layout

- **`sources/`** — raw reference notes (articles, books, experts,
  practices, quotes, …). Immutable input; the LLM reads but never
  modifies this layer.
- **`wiki/`** — LLM-maintained output. Mirrors the `sources/` taxonomy
  (same 18 categories). Start at [`wiki/index.md`](wiki/index.md).
- **`CLAUDE.md`** — the schema: page conventions, frontmatter, and the
  ingest / query / lint workflows the LLM follows.
