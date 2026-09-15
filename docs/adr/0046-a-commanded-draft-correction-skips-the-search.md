# A commanded draft correction skips the search

The note skill has had a mode for a correction on command since ADR 0016. The
draft skill had none, so "correct the summary of draft X" on a `done` draft sent
one agent to step 2, which files new thinking on a closed subject as `X-v2`,
another to a direct edit, and a third to a refusal.

A correction I command now names its draft, which is its scope. It skips step 2,
with its subject search, its dependency lookup and its successor name, and
enters at the preview. On a `done`, `superseded` or `dropped` draft it reaches
the frontmatter and the `# Title` and nothing of the body.

The cold read of ADR 0027 now also needs the change to reach the body below the
`# Title`, so a corrected summary costs no subagent run.

## Considered Options

**No correction on a closed draft at all (rejected).** It keeps a closed record
untouched. It was rejected because a typo in a closed draft's summary could then
only be fixed by a successor, and the body, which records its own time, stays
protected either way.

**Keeping the cold read on every previewed change (rejected).** It was the rule
of ADR 0027. It was rejected because the cold reader answers which open steps it
cannot carry out, and a frontmatter or title change leaves the steps as they
were.

## Consequences

- ADR 0027 is not edited. This record adds the third condition to its trigger.
