# A draft becoming a note is two commands

The draft contract has always said that `done` means "carried out, or what
mattered became a note", and it justified `type: draft` with the file one day
moving into `notes/`. Neither half was reachable. No skill defined the
transition: the note skill greps `notes/` and `archive/` and never `drafts/`,
nothing sets the source draft's status when a note distils it, and a draft file
literally moved into `notes/` fails the note check on `type`, on the missing
`hub` and on `status`.

The transition is now two commands, said so in the contract: `/note` writes the
note, and the close is its own preview and its own yes. The move that could
never work left the file, and `type: draft` is justified by the check and the
queries reading the field instead.

## Considered Options

**Building it into the note skill (rejected).** The note skill would grep
`drafts/` alongside `notes/`, and where a note distils a draft it would close
that draft in the same pass. It was rejected because one approval unit would
then span two skills' files, and a no to the note would leave the close
undecided while a no to the close would leave a note that claims a draft is
finished. The two decisions are separately refusable, so they are separately
previewed.

**Striking the promise instead (rejected).** Drop "or what mattered became a
note" from `done` and say nothing about the transition at all. It was rejected
because the transition really is how a draft ends most of the time, and a status
table that cannot describe the ordinary ending sends the next session looking
for a status that is not there.

**A third status for it (rejected).** Something like `noted`, distinct from
`done`, so the table records which way a draft ended. It was rejected because
the `## Outcome` of a close already says what carried it out, and a fifth value
would have to be added to the write check, the `--open` lookup and every query
to record what one sentence already records.

## Consequences

- The note skill is untouched by this and still never reads `drafts/`, which is
  what `global.md` now requires of any answer as well.
- A draft closed after its note carries the note's name in its `## Outcome`,
  under the contract's existing rule, and that is the only link between the two
  files.
- `type: draft` now stands on the check and the queries. Nothing in the vault
  moves a file between `drafts/` and `notes/` any more, so the field records
  what the file is rather than what it once was.
