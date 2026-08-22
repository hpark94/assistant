# assistant

This repo holds `global.md`, the instruction file both agents load in every
project, the note, draft and deep-search skills under `skills/`, and the
decisions in `docs/adr/`. How to work with the Vault is in `global.md` and in
the skills; this file is only about changing them.

## Where a rule lives

The load time test settles it. `global.md` holds what must hold when no skill is
loaded: permissions, prohibitions, boundaries. A skill holds procedure,
mechanics and its contract. Ask it of any sentence: I say "delete the note X"
without typing `/note`, does the agent need this sentence? Yes puts it in
`global.md`, no puts it in the skill.

A skill stands on itself and `global.md`, nothing else. Where two skills need
the same mechanics, both carry it, and neither a shared script nor a fourth file
relieves that: a rule in a file the reader never loaded is a rule that does not
hold.

There is no glossary file and none is created, the one the `domain-modeling`
skill writes on its own included. Every meaning stands in the file whose
operation needs it.

## Who wins

The same test settles precedence. On a permission, a prohibition or a boundary
`global.md` wins and the skill is wrong. On procedure, mechanics or a contract
the skill wins and `global.md` is corrected. Neither is a decision to escalate,
both are a patch.

## What a sentence may carry

A rule, and at most one clause naming the failure it prevents. That clause may
not restate the rule. A fact about the world is not a rule and goes to the vault
as a Note.

## ADRs

An ADR is written where a rejected alternative would otherwise be reopened
later, and nowhere else. It is written after the change and never before it. It
is **never edited**: one that turns out wrong gets a successor, the way a
superseded draft does, because a record that gets corrected is a fourth
normative surface and no longer a record.

Before you change a subject an ADR covers, read it. It carries the alternatives
that were rejected, which is the half `git log` does not.

## Review

One instruction file touched means no review round. Two or more means one
review, with these five questions and no others:

1. Does every added normative sentence pass the load time test?
2. Does a justification restate a rule that stands elsewhere?
3. Is a fact carried in an instruction file that belongs in the vault?
4. Does a skill disagree with `global.md`? Resolve it under Who wins.
5. Would a rejected alternative be reopened later without an ADR?

An instruction file is `global.md`, one of the three `SKILL.md`, or this file.
An ADR is not one: a record is never reviewed against current policy, so it does
not raise the count.

After the patch, exactly one second round. A third is forbidden: what round two
still finds is a construction fault rather than a wording fault, and the answer
is to reopen where the rule belongs.

## Commands

- `./install.sh`: symlink `global.md` and the three skills into place.
  Idempotent, and it reports the missing command line tools instead of
  installing them. The MCP tools `deep-search` needs are not among them, and the
  script says why.
- `git -C ~/repos/assistant commit`: after every change in this repo, subject
  `docs(agents): what changed`. No trailing `Co-Authored-By` lines.
