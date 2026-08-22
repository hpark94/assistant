# Load time owns where a rule lives

Adding one feature to this repo cost five review rounds, and each round found
another contradiction between the instruction files rather than a fault in the
feature. The suspicion was the ADR pile: eighteen records, twelve of them later
edited, two of those corrected three times within hours of being written. The
measurements said otherwise. No recorded contradiction was ADR against ADR. All
five ran between `global.md`, `CONTEXT.md` and a `SKILL.md`.

What the numbers pointed at instead was surface count and sentence shape. 137
commits touched an instruction file and 100 touched exactly one; the 37 that
touched two or more carry names like "resolve vault contract contradictions" and
"assign each contract rule one owner", so the multi-file commit is the signature
of the disease and it was 27% of the work. Of 213 lines in `global.md`, roughly
60 were rule and roughly 130 were justification, fact and example, and every
measured contradiction came out of a restatement inside a justification. 12 of
16 `CONTEXT.md` terms carried content that also stood in an operative file, 14
of its 22 changes rode along with another file, and the two terms doing the most
normative work in the repo, `preview` at 29 occurrences and `approval unit`,
were not in it at all.

The rule that came out of it is a question about load time. `global.md` holds
what must hold when no skill is loaded: permissions, prohibitions, boundaries. A
skill holds procedure, mechanics and its contract. Ask of any sentence whether
the agent needs it when I say "delete the note X" without typing `/note`. The
same question settles precedence, so there is one test and not two rules: on a
permission, a prohibition or a boundary `global.md` wins and the skill is wrong;
on procedure, mechanics or a contract the skill wins and `global.md` is
corrected. Neither is an escalation, both are a patch.

A sentence now carries a rule and at most one clause naming the failure it
prevents, and that clause may not restate the rule. A fact about the world is
not a rule and goes to the vault as a Note.

## Considered Options

**Consolidating or rewriting the ADRs (rejected).** It was the first suspicion
and the pile is genuinely untidy. It was rejected because the measurements
cleared it: not one contradiction ran between two ADRs, and 0006, 0010 and 0014
each say in their own text that the records they cite stay as they are.
Rewriting them from memory would lose the rejected alternatives, which is the
half `git log` does not carry. What the pile did show is that an edited ADR is a
fourth normative surface rather than a record, so an ADR is now never edited and
a wrong one gets a successor.

**Repairing `CONTEXT.md` instead of deleting it (rejected).** Fix the twelve
duplicated terms, add `preview` and `approval unit`, and the glossary earns its
place. It was rejected because the surface itself is the cost. It is never
loaded outside this repo, so no agent ever reads it while working; under the
rule that a skill stands on itself and `global.md`, every meaning it holds has
to stand in the operative file anyway; and a term defined twice is what two of
the five contradictions grew out of. Every one of its 17 terms was checked
against an operative file before it went, and none had to move.

**A shared file or a script for the mechanics two skills both need (rejected).**
The ASCII slug definition, the frontmatter check, the format step: all of it is
duplicated between the note and the draft skill on purpose now. It was rejected
because a rule in a file the reader never loaded is a rule that does not hold. A
skill is loaded alone, so a fourth file would be exactly the surface this
decision removes.

**Keeping the examples and the setup facts in `global.md` (rejected).** They
were the friendly half of the file. It was rejected on evidence: lines 79 to 88
duplicated `neovim-config-isolation.md`, which is more complete and was verified
later, so the instruction file was carrying a stale copy of something the vault
already owned. The vault duty widened in the same breath, from "any question" to
any question and any proof, and the lookup is now a listing of `notes/` rather
than a guessed search term, because `fd nvim` misses that very note.

**An unbounded review, or none (rejected).** Five rounds is what started this.
No review at all is the other extreme and loses the one thing rounds are good
for. It was rejected in favour of a cap: one instruction file touched means no
round, two or more means one round with five fixed questions, then exactly one
second round. A third is forbidden, because what round two still finds is a
construction fault rather than a wording fault, and the answer is to reopen
where the rule belongs.

## Consequences

- `CONTEXT.md` is deleted and none is created again, the one the
  `domain-modeling` skill writes on its own included. The prohibition stands in
  `AGENTS.md`, which had to carry it before the file could go.
- `AGENTS.md` carries the constitution: where a rule lives, who wins, what a
  sentence may carry, the ADR rule and the five review questions.
- `global.md` was rewritten against a written inventory of every permission,
  prohibition and boundary it held, taken at commit `02c17dc`. There were 45,
  not the roughly 20 the plan estimated, and each maps to a line of the new
  file. It is 187 lines from 213.
- The ASCII slug definition now stands in the note skill and in the draft skill,
  in each case where the file name is built.
- No `[[note]]` pointer stands in an instruction file any more, an example
  included: a rename in Obsidian breaks one silently and nothing here is
  versioned.
- Changes to `global.md` and to the three skills happen only in
  `~/repos/assistant`. They are symlinked into place, so an edit made from
  another project would land in the repo with none of its rules loaded.
- The skill directories, invocation forms, MCP configuration paths and memory
  paths of both agents left `global.md` as facts and are carried nowhere. They
  owe a Note in the vault.
