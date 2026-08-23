# The archive and the bin are read only

Successor to ADR 0030, which left a restore out of `archive/` as "an act I
command, with no skill behind it" and said "where I command one, that session
decides how". That answer is withdrawn.

The patch before this one had made the emptying of `.trash/` an operation: it
went into the bullet that grants a commanded write and into the sentence that
fixes an approval unit. Two reviewers then found what that cost. No file said
how a file is actually removed, because `rm` is banned two lines above, so one
reader runs it on the bin and another cannot carry out the one act the file
permits. And "emptying" names the whole bin while the unit sentence names the
single file, so a no means two different things.

The rule now runs the other way. A file in `archive/` or in `.trash/` is read
and never changed, moved or removed, and no command lifts this. Bringing one
back and emptying the bin are done by hand. The archiving keeps its `mv` into
`archive/`, and the deletion its `mv` into `.trash/`, because neither touches a
file that is already there.

## Considered Options

**Giving the emptying its mechanics (rejected).** A clause scoping the `rm` ban
to the deletion, and a second one fixing whether a yes covers the bin or one
file. It was rejected because both clauses exist only to make an act possible
that has never been asked for: `.trash/` has been empty for as long as it has
existed. A rule that has to be repaired twice before it can be used the first
time is the wrong rule.

**Keeping the restore as a commanded act (rejected).** ADR 0030 left it open on
purpose, so that a session could decide how when the case came up. It was
rejected because "the session decides how" is not a rule an agent can be held
to, and because the vault has no version control: a wrong move out of the
archive is not recoverable, and the file manager does the same job with me
watching.

**Excepting the archiving from the prohibition (rejected).** The archiving wrote
the changed frontmatter after the `mv`, so it wrote inside `archive/`, and the
straightforward repair was a clause excepting it. It was rejected because the
order can be turned around instead: write and format at the note's own path,
then move. The exception would have stood in the rule for good and been read in
every later round, while the reordering costs nothing at the time it runs.

**Keeping the old order for its milder half state (rejected).** If the write
after the `mv` fails, the note sits in `archive/` with a bracketed `hub` and is
already out of every query. Under the new order a failed `mv` leaves it in
`notes/` with an unbracketed `hub`, so it shows in its hub's list with a dead
link. That is the worse half state, and it was accepted anyway: two local
commands in sequence, and the alternative is a permanent exception in a
prohibition.

## Consequences

- `global.md` lost a paragraph and two list entries and gained one rule.
- "No command lifts this" is the second absolute in these files, after the
  ticked step in the draft skill. Both exist because the vault has no version
  control.
- The note skill's duplicate search still reads `archive/`, which the rule
  allows in as many words.
- The archiving is now write, format, move. A reader who reverses it to the
  order ADR 0030 described is reopening this record.
