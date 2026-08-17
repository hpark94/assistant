# A trigger decides when a skill fires, not what its contract covers

Three questions from a review of the contract turned out to be one. "Setz den
Draft auf done" without `/draft`, a typo fixed in an existing Note, a wrong Hub
summary: each of them is an operation a skill has a contract for, requested in a
way that does not name the skill. Read strictly, `description` settled all
three, "Triggers, and nothing else: the command `/draft` or `$draft`", and
settled them badly.

A trigger governs whether a skill fires on its own. It does not narrow what an
explicit command means. From here on, a Note, a Hub or a Draft written on a
plain instruction is written under its skill's contract: the frontmatter check,
`prettier -w` at its place in the Vault, the preview rules and the exceptions
those rules argue for. `global.md` keeps authorization, the skill keeps
mechanics, and only what no skill covers, a deletion or the Index, is a write
under Writing to the Vault.

The reachability that forced this is asymmetric between the two agents and was
checked against a scratch `CODEX_HOME` on `codex-cli 0.147.0`:

```sh
SCRATCH=$(mktemp -d); export CODEX_HOME="${SCRATCH}/codex"
mkdir -p "${CODEX_HOME}/skills" "${SCRATCH}/proj"
cp ~/.codex/auth.json "${CODEX_HOME}/"
printf 'model = "gpt-5.6-sol"\n[projects."%s"]\ntrust_level = "trusted"\n' \
  "${SCRATCH}/proj" > "${CODEX_HOME}/config.toml"
cp -r ~/repos/assistant/skills/draft "${CODEX_HOME}/skills/draft"
cd "${SCRATCH}/proj" && git init -q .
codex debug prompt-input | grep -o 'draft' | sort -u
```

Codex lists `draft` despite `disable-model-invocation: true`, as ADR 0007
already recorded. Claude honours the flag, so `draft` is absent from its skill
list entirely and only a typed `/draft` reaches it. Under the strict reading the
skill's own status-only exception was therefore unreachable for Claude by
construction: the only way to use the rule that waives the preview was to invoke
the skill that the rule sits in.

## Considered Options

**The trigger is the boundary (rejected).** No trigger, no skill; everything
else falls under "every other write to the Vault", on command and previewed. It
is the literal reading of `description` and the shortest rule. It was rejected
because it lets a file enter the Vault that never passed the frontmatter check.
A hand-edited correction is exactly what the check exists to catch:
`topic: [[hub]]` without quotes parses into a list and is no link in Obsidian,
and nothing about a typo fix makes that failure less likely. It also leaves the
status-only exception as dead letter.

**Mechanics always, exceptions only at the trigger (rejected).** The check and
`prettier -w` run on every write, but a preview is never waived unless the skill
was invoked by name. It protects the files just as well and keeps "nothing
enters the Vault before I have seen it" absolute. It was rejected because the
exception is argued in place and the argument does not depend on how the command
arrived: "set the draft to done" already names the whole change, so a preview
returns the same sentence and costs a second yes. Splitting mechanics from
exceptions also means the same request behaves differently depending on which
words were typed, which is the surprise this decision is meant to remove.

**Dropping `disable-model-invocation` from the draft skill (rejected as a
fix).** It would make the skill reachable for Claude without a typed command and
appears to solve the reachability half. It solves nothing: Codex ignores the
flag anyway, so the asymmetry it removes is Claude's alone, and it reintroduces
what the flag is for, a Draft skill firing because a conversation mentioned a
sketch. The flag is about unbidden firing, which is the very distinction this
file draws.

## Consequences

- `global.md`'s Operational ownership section states the rule. The commit
  `docs(agents): a correction outside a capture is not the skill's`, made hours
  earlier in the same review, scoped that section to the skills' triggers and is
  reversed here.
- A correction to an existing Note keeps its two owners on purpose, and they no
  longer collide: `global.md` says it needs a command and a preview, the note
  skill says the preview is the changed passages only, run through the check,
  and that `prettier -w` follows the write.
- "Nothing ever edits an existing hub" in the note skill was a prohibition by
  accident. A Hub correction on command is a normal write with the hub check.
  The Hub keeps no `updated`: a correction is rare enough that the field would
  repeat `created` for months, which is the same reason as before, only stated
  honestly.
- The `description` of both skills is unchanged. It is what keeps a Capture from
  firing unbidden and, for Codex, the only part read at all, so it keeps saying
  what it says. What it means is now written down where the ambiguity was.
