# A noticed correction to a note may be put up

ADR 0042 checks every claim a note makes, so extending a note turns up old
claims that are now wrong. The note skill put such a correction up as its own
approval unit, while `global.md` allowed a correction to a Note or Hub only on
my command. A review found one agent putting the correction up and the other
only naming it.

`global.md` now allows it: a correction the agent noticed to a Note or Hub may
be put up as its own change, and my yes to its preview is the command. It never
reaches a Draft, and never a child's title after its hub's title was corrected;
those are named in one line.

## Considered Options

**Only naming a noticed correction on a note as well (rejected).** It keeps
`global.md` as it was. It was rejected because every note extension would then
end in a line the next command has to repeat as a correction, for an error the
agent already checked.

**Putting up noticed corrections on drafts too (rejected).** It was rejected
because a draft records the thinking of its time, and what it got wrong is
content; a real contradiction already goes through the supersede.

**Offering each child's title after a hub title correction (rejected).** It was
rejected for the reason ADR 0045 gives against the same children in one preview:
a hub with twenty children would put up twenty units on one noticed cause.

## Consequences

- The offer is the preview itself, checked and formatted, so one yes writes it.
