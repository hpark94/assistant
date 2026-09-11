# The archiving stops before it writes

ADR 0032 turned the archiving into write, format, move, and accepted the half
state a blocked `mv -n` leaves: a note sitting in `notes/` with an unbracketed
`hub`, out of its hub's list and out of Obsidian's backlinks while still looking
like knowledge. It weighed two orders against each other and took the worse half
state over a permanent exception in a prohibition. It did not consider that the
collision is knowable before anything is written. Step 1 now looks, and where
`archive/` already holds the name, the operation stops with nothing written and
no preview built.

A second thing came out of the demonstration. `mv -n` refuses silently and exits
0, so step 5's "Where it stopped the move, say so" named a stop that nothing
reported. The stop is now read off the source still being there.

## Considered Options

**Reporting the half state instead of preventing it (rejected).** One sentence
in the report naming what happened would have cost nothing and changed no order.
It was rejected because the report arrives after the write, and the vault has no
version control, so the note stays half archived until I repair it by hand.

**A rollback after a blocked move (rejected).** Write the old frontmatter back
and the note is whole again. It was rejected because the rollback is itself a
write that can fail, and that second failure leaves the same state with one more
command standing in front of it.

**Turning the order around, again (rejected).** Moving first and writing the
frontmatter in `archive/` needs no check at all. It was rejected by ADR 0032
because it writes inside `archive/`, which `global.md` forbids, and nothing
about that has changed.

## Consequences

- The half state is now reachable only where a sync from another device lands
  that name between step 1 and step 5. Step 5 says how it is seen and what is
  said about it.
- ADR 0032 is not edited. Its reasoning about the two orders stands and this
  record narrows when the half state it accepted can occur.
- The note frontmatter check now rejects `archived` on a note in `notes/`, so a
  half archived note also fails its own contract the next time anything reads
  it.
