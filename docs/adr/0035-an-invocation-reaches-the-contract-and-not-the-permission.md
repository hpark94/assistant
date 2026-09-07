# An invocation reaches the contract and not the permission

Three reviewers read the seven instruction files against one question: where do
two agents, both careful, do different things? The answers fell into two halves
of the same confusion about what typing `/note` or `$pdf-read` buys.

One half was reachability. `global.md` says a trigger never narrows what an
explicit command means, while every `description` said "Triggers, and nothing
else". On "benenn die Notiz um" or "setz den Draft auf wip" one agent entered
the skill's contract and the other stayed outside it, wrote by hand, and ran
neither the frontmatter check nor `prettier`. ADR 0008 decided this and ADR 0014
left the description as the only bar, so the words that carry the bar had to
stop carrying a second claim. "Triggers" now names what fires the skill on its
own, and the note skill, which had stood on "and nothing else" alone, says what
the other three already said about not firing unbidden.

The other half was the permission. `pdf-read` writes its map beside the PDF, and
where the PDF sits in the vault, the skill said it "has none" of the command
`global.md` requires. One agent read the typed invocation as that command and
offered the write, the other refused. An invocation reaches a contract; it is
not the separate, previewed command a vault write outside the note and draft
skills needs.

Two prohibitions moved with the same test. `mv` on a rename and a ticked `- [x]`
step were absolutes that only a loaded skill carried, and both are needed
exactly when no skill is loaded: "benenn die Notiz um" reaches an agent that has
never read the note skill, and destroys every incoming link on four devices with
no version control behind them.

## Considered Options

**Leaving both prohibitions where they were (rejected).** ADR 0032 recorded the
ticked step as an absolute of the draft skill and nothing about the vault
changed since. It was rejected by the load time test ADR 0019 settled: an agent
that never loads the skill is the agent that runs the destructive command, and a
rule it cannot read is not a rule. The reasons moved with the rules, so neither
is stranded from the failure it names.

**Restating them in both files (rejected).** It keeps each skill readable on its
own, which is what the one-owner rule normally buys. It was rejected because a
prohibition stated twice is what two of the five contradictions in ADR 0019 grew
out of, and a second copy is the one that goes stale. The draft skill points at
`global.md` instead and keeps only what is procedure there: what replaces an
overtaken step, and why `prettier -w` is no exception.

**Letting the invocation authorise the vault write (rejected).** `/pdf-read` on
a PDF in the vault is a command I typed, and reading it as the command
`global.md` asks for would remove a refusal that looks pedantic. It was rejected
because the write it would authorise is one I never saw described: the map path
is derived, not named, and "as its own change, shown and approved" is the whole
of what the vault rules buy. The same reading would make every skill invocation
a blanket vault permission.

**Cutting "and nothing else" and leaving the note skill without a bar
(rejected).** It is the smallest diff and three of the four descriptions already
carry a "Never invoke this because" sentence. It was rejected because the note
skill is the only one that writes knowledge into the vault, so it is the one
that must not fire on a conversation that merely produced something.

## Consequences

- `global.md` carries the rename ban and the ticked step, next to the archive
  and bin rule that has the same shape. ADR 0032's line about the ticked step
  living in the draft skill is a record of where it was.
- The archiving moves with `mv -n`. A file of that name already in `archive/` is
  one the rule two paragraphs up never lets it overwrite, which a plain `mv` did
  silently.
- `~/dots` and `~/.config` are read and never written **by a proof**. The
  sentence sat under `### Where tests run` and read as a standing ban on two
  directories, one of which is a project I work in.
- A check that ran carries its command in `## Verified` whether `global.md`
  required the Proof or not. The contract's own example had been doing this
  against the rule above it since ADR 0017.
- "More than one that fits, put them up and wait" now also covers the hub pick
  and the draft write path, where only the note search and `--open` had it.
