# A Codex reader is spawned with no turns

`global.md` defines a fresh agent as one that inherits no turn of this session.
The three skills that hand work to a reader, deep-search, pdf-read and the draft
skill's cold read, named Codex's `spawn_agent` without saying how much of the
session it passes on. Codex 0.152.0 describes its default in its own tool text:
"Full-history forks (`fork_turns` omitted or `"all"`)". An isolated `codex exec`
run in a scratch `CODEX_HOME` spawned two agents with a secret word in the
parent's prompt: the one with `fork_turns: "none"` answered `NONE`, the one
without `fork_turns` answered the word.

Each skill now names `fork_turns: "none"` where it spawns a reader in Codex.

## Considered Options

**Codex's default (rejected).** It needs no parameter. It was rejected because
the reader then carries the whole session, and a cold read that knows what the
writer meant finds nothing.

**Naming the parameter once in `global.md` (rejected).** One line would reach
every skill and every proof. It was rejected for the reason ADR 0038 gave for
the vendor's name there: a parameter of one agent's tool goes stale with that
tool, and the skills already carry the spawn mechanics per agent.

## Consequences

- The definition "inherits no turn of this session" stays in `global.md`, and
  each skill carries how its agent meets it.
- The run and its command are in the vault as a note on Codex sub-agent context.
