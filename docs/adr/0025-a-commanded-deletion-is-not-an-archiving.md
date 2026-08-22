# A commanded deletion is not an archiving

A review round of the five instruction files found `global.md` giving two
answers to "delete the note X". Its Writing to the Vault bullet listed a
deletion among the writes that happen on my command, and the paragraph three
lines below it said that nothing leaves the knowledge by being deleted. Both
readings survived: the agent could send the file to the bin, or refuse and offer
an archiving instead.

ADR 0020 had settled the route out of the knowledge and rejected deleting in
place of archiving, but only for a file that no longer belongs there. It never
said what a bare deletion command means, and that is the half the review found
open.

The reason decides, not the word. What no longer belongs in the knowledge is
archived, and the note skill owns how. Deleting is the rare act on my explicit
command and reaches any file I name, a Note included.

## Considered Options

**Reading every deletion command on a note as an archiving (rejected).** It
keeps ADR 0020's sentence absolute and needs no new wording at all. It was
rejected because it turns my own command into something the agent reinterprets,
and because a duplicate or a note written by mistake would then sit in
`archive/` for good. ADR 0020's reason for keeping a rejection on disk, that "we
considered this and rejected it" cannot be reconstructed later, says nothing
about a file that never held a consideration.

**Dropping the deletion permission from `global.md` (rejected).** With archiving
as the only exit the collision disappears by subtraction. It was rejected
because the bin exists for exactly this act and the draft skill needs it by
name: a `dropped` draft is deleted on command and never archived, since
`archive/` holds what left the knowledge and a draft was never knowledge.

**A hub variant of the archiving check (rejected).** The review also found that
a childless hub has no way out: the archiving check demands `updated` and
`type: note`, and the hub contract gives a hub neither. A second check would let
a hub leave the same way a note does. It was rejected because it dissolves under
this decision. A commanded deletion reaches a hub like any other file, the note
skill already leaves the last-child case to me in one line, and a hub holds no
knowledge to take out of it.

## Consequences

- The two acts are now told apart by their trigger and not by their target. A
  judgement that something no longer belongs archives; a command deletes.
- A hub has no archiving route and needs none.
- The note skill is untouched. Archiving is still its fourth mode and still
  happens only on my command.
