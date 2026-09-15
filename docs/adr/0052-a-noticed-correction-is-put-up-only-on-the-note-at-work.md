# A noticed correction is put up only on the note at work

ADR 0049 let a correction the agent noticed be put up on a Note or Hub, never on
a Draft and never on a child's title after its hub's title was corrected. The
review of that change found three splits. "May" let one agent put the correction
up, another name it, and a third stay silent. The permission named no moment, so
an agent reading a note to answer a question could put up a full correction
preview. And "after its hub's" also read as the part of a title behind the hub's
prefix.

A noticed correction is now put up only on the Note the note skill is extending
or correcting, and there it always goes up as its own approval unit. Anywhere
else, a hub, a draft, a note read to answer a question, a child after a hub
title correction, it is named in one line. The two exceptions of ADR 0049 follow
from that and are gone.

## Considered Options

**Keeping "may" on the note at work (rejected).** It lets the agent skip a small
fix. It was rejected because it is the split the review found.

**Including the hub of the note at work (rejected).** Step 3 reads the hub, and
a stale `summary` there is noticed in the same pass. It was rejected because the
hub is context to the extension, and a hub correction stays a command of its
own.

**Allowing it wherever a note is read (rejected).** It was rejected because a
correction preview while answering a question is a write nobody asked for, and
`global.md` keeps unasked nudges to one line.

## Consequences

- ADR 0049 is not edited. This record replaces its scope.
- Archiving is not extending or correcting, so a wrong claim in a note being
  archived is named in one line and its body stays untouched.
