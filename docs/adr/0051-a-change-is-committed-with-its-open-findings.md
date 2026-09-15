# A change is committed with its open findings

ADR 0048 made round two's findings a report and not a patch, and left open
whether the change is committed before I decide on them. `AGENTS.md` asks for a
commit after every change.

The change is now committed as it stands, and the findings are reported beside
the commit.

## Considered Options

**Holding the commit until I decide (rejected).** No commit then carries a known
fault. It was rejected because the reviewed state would sit uncommitted in the
working tree, where the next session's edit mixes with it, and a finding fixed
later is a commit of its own either way.
