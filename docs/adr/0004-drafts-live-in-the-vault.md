# Drafts live in the Vault, not in the project

Thinking about a project starts in a session here and has to be readable later
in a session in that project. We keep that thinking in the Vault, in
`~/projects/vault/drafts/`, a sibling of `notes/`. A Draft is
`<project>-<topic>.md`, declares its Project and a Status, and is invisible to
every Hub and knowledge query, because those are scoped `FROM "notes"`. The
Index alone has a dedicated block over `drafts/` that lists the Drafts with
status `todo` or `wip`.

The reason is one place for everything he thinks: the Vault is where he already
looks, it replicates to all four devices through Syncthing, and a Draft written
on the desktop is on the laptop in the evening without a push. A Project session
reads and writes it as plain Markdown at a known path, which needs no API.

## Considered Options

**The Draft lives in the project it is about (rejected).** It would sit next to
the code it describes, need no path convention across repositories, and, in a
project with git, share the history of the thing it describes, so it could be
deleted in the same commit that carries it out. It was rejected because it
scatters the thinking across a dozen directories and behaves differently in
each: `~/repos/*` has git but no replication, `~/projects/*` replicates but has
no git, and half of the interesting projects are not repositories at all.

**A folder inside `notes/` (rejected).** Every Hub query and the Index would
have to exclude it explicitly, and one forgotten `WHERE` would let unfinished
thinking appear as knowledge. A sibling folder needs no exclusion anywhere.

**Deleting a Draft that was rejected (rejected).** The Vault has no version
control, so a deleted file is gone on four devices at once. "We considered this
and decided against it" is exactly the thing that cannot be reconstructed later,
which is why `dropped` is a Status and not a deletion.

## Consequences

- A Draft has no history. Iterating on it overwrites what was there, and only
  the Status trail says what became of it. `superseded_by` links the successor
  so the path is at least visible.
- A Draft may name the Drafts that must be carried out before it, in
  `depends_on`, a list of links. A session that produces several Drafts at once
  writes the order there, because otherwise it lives only in that conversation.
  `/draft --open` reports a Draft as blocked while a dependency is still `todo`
  or `wip`; the Index does not, its block queries `status` alone.
- No Agent pulls a Draft into a session on its own. He points at it, or invokes
  `/draft --open` in the Project. The Index may list open Drafts, but automatic
  session discovery would also pull up a Draft from three months ago that has
  long been decided otherwise.
- `status` only stays true while he says so. A forgotten status leaves a Draft
  listed as open, which errs towards too much work rather than too little; the
  opposite error, a `done` that is not, would be the expensive one.
- Drafts and Notes now share one rule: nothing enters the Vault before he has
  seen it.
