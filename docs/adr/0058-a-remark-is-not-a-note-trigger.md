# A remark is not a note trigger

The note skill fired on "das ist wichtig", among other phrases. `global.md` says
the skill writes when I ask for it, and no longer carries the clause ADR 0014
quoted, that a named trigger counts as asking. The same review found the phrase
able to split agents: said in passing about a fact, one agent can start a
capture and another read no request in it.

The phrase is gone from the triggers. The remaining ones, "merk dir das", "mach
eine Notiz draus" and "halt das fest", each ask for the capture.

## Considered Options

**Saying in `global.md` that a named trigger is asking (rejected).** It keeps
the phrase. It was rejected because the phrase is ordinary speech and asks for
nothing, so the rule would make the agent write on a remark.
