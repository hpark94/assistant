# The second review round is reported, not patched

`AGENTS.md` allowed exactly one second review round and forbade a third, and
said the answer to what round two finds is "to reopen where the rule belongs".
It did not say who reopens. In a session that changed five instruction files the
agent patched round two's findings itself, which left the last patch reviewed by
nobody.

What round two finds is now reported and not patched.

## Considered Options

**Patching wording faults, reporting construction faults (rejected).** It keeps
small fixes cheap. It was rejected because telling a wording fault from a
construction fault is the judgement two agents make differently, and a wrong
call lands unreviewed.

**Starting a new change with two rounds on its own (rejected).** It keeps every
patch reviewed. It was rejected because it can loop without end, and whether a
rule needs reopening is a decision about the design, not about the wording.
