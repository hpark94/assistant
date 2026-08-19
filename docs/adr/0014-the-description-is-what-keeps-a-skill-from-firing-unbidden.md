# The description is what keeps a skill from firing unbidden

ADR 0007 recorded that Codex ignores `disable-model-invocation`, ADR 0008
rejected dropping the flag from the draft skill, and ADR 0012 then had to build
a second way into a contract the flag had closed: Claude hides such a skill, so
only a typed `/draft` reached it, and the everyday "setz den Draft auf done"
needed the `SKILL.md` read as an ordinary file. Two decisions and a
construction, for a flag that works on one of the two agents.

```sh
SCRATCH=$(mktemp -d); mkdir -p "${SCRATCH}/proj"; cd "${SCRATCH}/proj" && git init -q .
codex debug prompt-input | grep -oE '(draft|deep-search|note): [^(]{0,60}' | sort -u
```

Codex 0.147.0 lists all three with their full description, `draft` and
`deep-search` among them while both still carried the flag. On Claude's side the
flag did work: both were absent from the skill list until it was removed and
appeared with their description in the same session once it was. That half is an
observation from a running session, not a command that can be re-run.

What the flag protects is narrower than it looks. It keeps a skill out of the
list the model chooses from, which is a bar against loading and not against
writing. The permission to write sits in Writing to the Vault: a skill writes on
my command or on a trigger it names and never on its own reading of the
conversation, and that holds whether the skill was loaded or not. What the flag
buys on top is that an unbidden skill does not enter the context at all, and the
`description` of both skills already forbids exactly that, in the words both
agents read: "Triggers, and nothing else", followed by "Never invoke this
because the conversation mentions". The note skill, the only one that writes
knowledge into the Vault, has stood on that sentence alone from the start.

The flag therefore comes out of `draft` and `deep-search`, and with it the two
bullets in `global.md` that explained it and the sentence that sent the agent to
read a hidden skill as a file.

## Considered Options

**Keeping it, as ADR 0008 decided (rejected now).** Nothing about Codex changed,
and that was the argument then: the asymmetry removed would be Claude's alone.
What changed is the price. ADR 0012 had to add a second entrance to the draft
contract because the flag closed the first, and that construction was carried in
the file both agents load in every project.

**Removing it from `deep-search` only (rejected).** Deep Search writes nothing
to the Vault, so it looks like the safe half. It buys the least: `draft` is
where the everyday commands land and where ADR 0012's construction was needed,
and the two agents would still see different lists.

**Moving the reason the note skill carries no flag into `AGENTS.md`
(rejected).** It was the plan while the flag stayed, and it put repo knowledge
into the file that governs work on the repo. With no skill carrying the flag the
sentence has no subject left.

## Consequences

- `global.md` loses sixteen lines: the two bullets under the setup facts and the
  sentence in Operational ownership about reading a hidden skill from its
  directory.
- Both agents see the same three skills. What keeps one from firing unbidden is
  its own `description`, one mechanism instead of two, and it is the part Codex
  reads.
- The bar is softer than the flag was. A model that ignores the description
  loads the skill; it still may not write, because that permission never sat in
  the frontmatter.
- ADR 0007, 0008 and 0012 stay as they are. They record what was decided when it
  was decided, and this file is where the flag went.
