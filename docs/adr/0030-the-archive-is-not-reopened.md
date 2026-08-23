# The archive is not reopened

The note skill's duplicate search read `notes/` and nothing else, so a topic
that had already been archived was written again as a new note, with the old
file never surfacing. Two things sat behind that. ADR 0021 assumed a restore,
"restoring it is a move back plus the brackets", that no mode ever defined. And
an archived note keeps `type: note` while its `hub` is unbracketed, so mode
three, which enters step 2's hit branch and writes under `notes/`, would fail
its own check on the file it was pointed at.

Two rules now stand. Step 2 greps `archive/` for the same terms, and a hit there
is not a hit: it is one line beside the preview and the decision is mine.
`global.md` says that a file in `archive/` takes no correction, because the
archive records what a note was on the day it left.

## Considered Options

**A fifth mode, Restore (rejected).** Move the file back, put the brackets
around `hub`, drop `archived`, and the note is knowledge again. It was rejected
because `archive/` has been empty for as long as it has existed and the case has
never come up, while the damage the gap actually does is the duplicate, which
the grep closes for free. A restore stays what a deletion is: an act I command,
with no skill behind it.

**Correcting a note in the archive (rejected).** The Archiving section already
carries a check for exactly that frontmatter shape, so a correction path could
have written there. It was rejected because a record that gets corrected is no
longer a record, which is the reason `AGENTS.md` gives for never editing an ADR
and the draft skill gives for appending an `## Outcome` rather than weaving it
in. Wanting the correction is the signal that the note belongs back in the
knowledge, not that the archive is wrong.

**Leaving the search at `notes/` (rejected).** The duplicate rule only ever
promised not to write two notes on one topic, and an archived note is not a
second note in the knowledge. It was rejected because the writer cannot tell the
two cases apart: without the grep, "no note exists on this" and "one existed and
was taken out" read the same, and the second is the one where I would have
answered differently.

## Consequences

- Every note now costs one more grep, against a folder that is empty today.
- A restore has no mechanics anywhere, and `global.md`'s unit sentence does not
  name it. Where I command one, that session decides how.
- The prohibition sits in `global.md` and not in the note skill: "correct the
  archived note X" has to be answerable when no skill is loaded.
