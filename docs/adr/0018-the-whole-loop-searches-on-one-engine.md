# The whole loop searches on one engine

Two sentences pointed different ways. `global.md` says "Find with the native
search capability, then read the source itself in full", and ADR 0009 kept the
vendor out of that file on purpose, leaving the depth to the skill that calls
the tools. `deep-search` keeps the searching with the orchestrator, "the
searching stays with you, so the ceiling below stays countable", and then names
`web_search_advanced_exa` with `startPublishedDate` for the currency case. Which
engine step 1 of the loop uses was never said.

A review found the practical half of the same gap. The paragraph that carries
the load line is written about readers: "Every reader works with", and "a reader
that assumes them present reports them missing and reads nothing", followed by
the `ToolSearch` line the assignment carries. On Claude the three exa tools are
deferred, arriving as names with no schema until they are selected, and the
orchestrator is the one agent in the loop that no assignment reaches. It was
required to search, told to use a specific exa tool for currency, and never told
to load anything. That is the failure the paragraph was written to prevent,
happening one level up from where it was prevented.

The whole loop therefore runs on one engine, the orchestrator included, and the
paragraph that carries the load line says so for both roles. `global.md` makes
native search the default only where an active operation names no capability of
its own; the skill owns both this engine and the depth of its loop.

## Considered Options

**Native for the orchestrator, exa for the readers and the currency case
(rejected).** It is the reading closest to `global.md`'s wording and it needs no
new sentence in the skill. It was rejected by the loop's own shape. Step 5 asks
whether the next source would still change the answer, and the ceiling counts
what was read; both become unanswerable across two engines, because a source
that never turned up could be one nobody has or one that sat in the other
engine's half. It also does not solve the problem it was raised against: the
orchestrator still needs the exa tools for currency, so it still has to load
them.

**A pointer in step 1 instead of widening the paragraph (rejected).** It puts
the instruction where the first search happens, which is where an agent working
the loop actually stands. It was rejected because it names the same three tools
in two places for one rule, and the paragraph cannot move down to meet it: the
reader section refers back to "the `ToolSearch` line above", so the block stays
where it is either way.

**Naming the engine in `global.md` (rejected).** It would settle the two
sentences at the source. It was rejected by ADR 0009, which put the vendor in
the skill that calls it and kept it out of the file loaded in every project. A
global default with an explicit operation seam and a skill that owns its engine
settle the scope without putting the vendor there.

## Consequences

- `global.md` still governs every search outside this skill, but native search
  is now explicitly its default where an active operation names no capability of
  its own.
- The skill's ownership summary names its engine as well as its depth, so the
  engine rule and the global default each have one owner.
- The load line covers the orchestrator. The tool names still appear exactly
  once in the file.
- On Claude the choice costs no extra step. In the session this was decided in,
  `WebSearch` and the three exa tools were both deferred, so "native" was never
  a saved load, only a different name in the `select:`. That is an observation
  from a running session and not a command that can be re-run.
