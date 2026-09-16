# Settling a draft question carries what it makes wrong

ADR 0063 had the draft skill put the correction of every open step and passage
of prose a settled question makes wrong into the settling's own unit. Its second
review found that `global.md`, under ADR 0052, lets a noticed correction go up
only on the Note the note skill is at work on and names it in one line anywhere
else, a draft included. On a boundary `global.md` wins, so the skill's rule did
not hold.

`global.md` now names settling an open question in a Draft as the one other
place: what the settling makes wrong in that Draft goes up inside its unit.

## Considered Options

**Cutting the skill back to one line (rejected).** It keeps ADR 0052 whole. It
was rejected because a named line that nobody acts on is how
`routing-lab-verifier-flags` came to say "still open above" about decided
things, and the settling and its consequences are one decision.

**Its own approval unit, as the note skill does (rejected).** It was rejected
because a no to the corrections while the settling lands leaves exactly the
stale references this exists to prevent.

## Consequences

- ADR 0052 is not edited. This record narrows its "anywhere else" by one case.
- The reach is the Draft being settled. A stale reference in another draft is
  still named in one line.
