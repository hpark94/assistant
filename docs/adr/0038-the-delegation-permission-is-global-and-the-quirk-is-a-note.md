# The delegation permission is global and the quirk is a note

The deep-search and pdf-read skills each carried a sentence naming Codex's
`<multi_agent_mode>` section and declaring themselves the instruction that lifts
it. The draft skill's cold read and the proof rule in `global.md` both hand work
to a fresh agent and carried no such sentence, so the same delegation fired in
two places and not in the other two. Claude turned out to gate the same way, so
the gap was never the one-sided thing it looked like.

The permission now stands once in `global.md`, which both agents read as their
global file, and the fact about the vendor's prompt went to the vault as a note.

Reading the gate's own wording moved the sentence. It lifts where the user or an
AGENTS.md or skill instruction asks for sub-agents, delegation, or parallel
agent work, so the rule has to carry those words rather than only name a fresh
agent.

## Considered Options

**Copying the sentence into the draft skill and the proof rule (rejected).**
Four copies, each of them true, and the stand-alone rule would be satisfied
everywhere. It was rejected because the sentence carries a fact about one
vendor's prompt, and four copies of a fact drift on the day that prompt changes,
which this one already has: the feature it is named after is gone while the
section still ships.

**Leaving it in the two skills that fan out (rejected).** Both skills that
actually spawn readers had it, and no cold read had visibly failed for want of
it. It was rejected because the proof rule loads no skill, so nothing would ever
lift the gate there, and a proof that needs a built environment is exactly where
the delegation was prescribed first.

**Naming the vendor in `global.md` (rejected).** One copy and still explicit
about why the sentence exists. It was rejected because both agents read that
file, so a rule written against one of them is read by the other as noise, and
because the fact would then sit in the file whose review round is the most
expensive to spend.

## Consequences

- Both fan-out skills keep "the delegation is required rather than optional",
  which already carries the words the gate asks for, so neither depends on the
  global sentence alone.
- The cold read and the proof rule lift the gate through `global.md` instead of
  through nothing.
- Whether the spawning tool is offered at all is settled by none of this. The
  note records that as unverified, because the prompt dump carries no tool
  definitions.
