# A hidden skill is reached as a file

ADR 0008 decided that a Note, a Hub or a Draft written on a plain instruction is
written under its skill's contract, and in the same breath recorded why Claude
cannot do that for the draft skill: `disable-model-invocation: true` keeps it
out of the skill list, so only a typed `/draft` reaches it. The decision and the
reachability were written down side by side and the gap between them was left
open. A rule that demands a contract the agent has no way to enter is not a rule
at all, and the case it fails on is the everyday one, "setz den Draft auf done".

The skill list is not the only door. Both skill directories are named in
`global.md`'s own table, both are symlinks this repo's `install.sh` puts there,
and a `SKILL.md` under them is an ordinary Markdown file that the agent's file
tools read like any other. Invocation was never what the contract needed; the
text was:

```sh
head -2 ~/.claude/skills/draft/SKILL.md ~/.agents/skills/draft/SKILL.md
```

Both print `name: draft`. `global.md`'s Operational ownership section therefore
says that a skill the flag hides is no less its contract and is read from its
directory. Only `draft` and `deep-search` carry the flag, and `deep-search`
writes nothing to the Vault, so `draft` is the whole of the practical case.

## Considered Options

**Dropping `disable-model-invocation` from the draft skill (rejected again).**
ADR 0008 already rejected it for this exact problem and nothing about it
changed: Codex ignores the flag, so the asymmetry removed would be Claude's
alone, and the flag exists to stop a Draft skill firing because a conversation
mentioned a sketch. Reachability and unbidden firing are different questions,
and this answers the wrong one.

**Asking me to type `/draft` instead (rejected).** The agent could report that
it cannot reach the contract and wait for the command. That is the trigger as
boundary, which ADR 0008 rejected, arriving through the back door: the same
request would behave differently depending on which words it came in, and the
status-only exception would stay unreachable for the case it was written for.

**Repeating the mechanics in `global.md` (rejected).** The frontmatter check,
the format step and the preview rules could stand in the file both agents load
everywhere, and then nothing would have to be read. It duplicates what the skill
owns, against the one-owner rule in `AGENTS.md`, and grows the file loaded in
every project by a procedure that almost no project runs.

## Consequences

- The path is the one already in `global.md`'s table, so nothing new is
  maintained. A skill that is not under that directory is not installed, which
  is what `install.sh` reports.
- Two repairs from the same review ride along in their own commits. The clause
  "on the triggers that skill names" left the rejected reading of ADR 0008
  standing in the first section of `global.md` and is gone. "Only what no skill
  covers, a deletion or the Index, falls to Writing to the Vault above"
  contradicted the bullet above it, which lists a correction outside a capture:
  the two owners ADR 0008 gave that case are now stated where the collision was.
- The skills are untouched. What changed is where the contract is entered from,
  not what it says.
