# The shared rules live in one global file

Both skills promised to be complete contracts that "must work in projects whose
`AGENTS.md` you have never seen". That promise forced the duplication it was
meant to avoid: the proof rules, the style rules and the preview rule stood in
`AGENTS.md` and again in one or both skills. 19 of the 30 commits that touched a
`SKILL.md` had to touch `AGENTS.md`, `CONTEXT.md` or an ADR in the same breath.

```sh
git log --format='COMMIT %h %s' --name-only
```

The promise is now weaker and true: a skill assumes `global.md` and nothing
else. `global.md` is one versioned file in this repo, symlinked to
`~/.claude/CLAUDE.md` and `~/.codex/AGENTS.md` by `install.sh`, so it is loaded
in every project of either agent. What holds everywhere lives there once, a
skill owns only its own operation, and `AGENTS.md` shrank from 187 lines to 27
that concern this repo alone.

Two facts had to be checked before this was buildable, both against a scratch
`CODEX_HOME` and a scratch `CLAUDE_CONFIG_DIR`, on `codex-cli 0.147.0` and
Claude Code 2.1.233:

```sh
SCRATCH=$(mktemp -d); export CODEX_HOME="${SCRATCH}/codex"
mkdir -p "${CODEX_HOME}" "${SCRATCH}/repo" "${SCRATCH}/proj"
cp ~/.codex/auth.json "${CODEX_HOME}/"
printf 'model = "gpt-5.6-sol"\n[projects."%s"]\ntrust_level = "trusted"\n' \
  "${SCRATCH}/proj" > "${CODEX_HOME}/config.toml"
printf 'MARKER_AUS_DEM_REPO\n' > "${SCRATCH}/repo/global.md"
ln -s ../repo/global.md "${CODEX_HOME}/AGENTS.md"
printf 'MARKER_PROJEKT\n' > "${SCRATCH}/proj/AGENTS.md"
cd "${SCRATCH}/proj" && git init -q .
codex debug prompt-input | grep -o '# AGENTS.md instructions[^"]*'
```

Codex reads `$CODEX_HOME/AGENTS.md` as a global instruction and **appends** a
project's own file to it rather than replacing it, which is what lets this repo
keep an `AGENTS.md` of its own. It follows a symlink for both. The same holds
for Claude: with `~/.claude/CLAUDE.md` a symlink into a scratch repo, a code
word placed in the target came back in the answer and vanished when the symlink
was removed.

## Considered Options

**A second repository for the skills (rejected).** It was the obvious answer to
"a skill change turns the whole repo upside down" and it treats the wrong cause.
The coupling is two files that have to contain the same sentence, not a
directory boundary. Splitting them puts the two copies in two histories, where a
single diff can no longer show that they drifted apart, and turns one thought
into two commits with no common point.

**Keep the duplication and mark it (rejected).** Every duplicated passage would
carry a line naming its owner, "restated from `skills/note/SKILL.md`, keep in
sync". Honest, and it makes the second site visible while editing, but it
changes nothing about the work: two files per change, forever, with the drift
merely annotated instead of prevented.

**A shared file that both sides include (rejected).** It removes the duplication
properly, but a skill that must stand on its own can only reference a file
inside its own directory. That leaves a copy per skill, or `draft` depending on
`note`, which trades a duplication for a dependency between two skills that have
nothing else to do with each other.

**Making the skills portable to other people (rejected as the goal).** It was
the original ambition, and it is what forced the self-contained promise. Priced
out, it costs the German triggers in the `description`, the Vault structure that
ADRs 0001 to 0004 decided, the frontmatter checks that encode exactly this
schema, and the assumption that `prettier`, `rg`, `python3` with `yaml` and
`ffd` are present. The skills are good because they encode decisions; every
configurable point hands a decision back. Portability across machines was the
real need, and `~`-relative paths plus relative symlinks already deliver it.

## Consequences

- `install.sh` is the first executable file in this repo, so "nothing in this
  directory ships" is gone from `AGENTS.md`. It sets six relative symlinks, is
  idempotent, refuses to overwrite anything that is not already a symlink, and
  reports missing tools without installing them.
- The symlinks are relative. The four that existed before were absolute with
  `/home/hpark` baked in, unlike all 23 third-party skills next to them, and
  they would have broken on a machine with a different user name.
- `~/.claude/CLAUDE.md` was a real file of 627 bytes; its three rules are all
  covered by `global.md` and it was moved to `~/.claude/CLAUDE.md.vorher` rather
  than deleted. Codex had no global instruction file at all, so it did not see
  the Vault rules outside a project that carried them.
- The skills stop repeating what `global.md` owns, and the user is `I` in them
  now instead of a name. `note` went from 275 lines to 249, `draft` keeps its
  length because it gained the rule that it never grills.
- Grilling stays outside this repo. Rather than fork a third-party skill or
  depend on one that `install.sh` cannot place, a grilling ends with the same
  one-line offer that `notizwuerdig` already established,
  `entwurfswuerdig: <topic>`, defined in `global.md` and in `CONTEXT.md`.
  `/draft` never opens an interview of its own.
- The 23 third-party skills in `~/.agents/skills/` remain unversioned and absent
  on a second machine. That is untouched by this decision.
