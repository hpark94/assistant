# The vault gets rid of things by moving them

The vault had no undo. No `.git`, no `trashOption` in `.obsidian/app.json`, no
`.trash`, and the Syncthing folder `projects` running with versioning disabled.
The one irreversible risk in the whole system was held by a sentence of prose in
`global.md`, "nothing is deleted before I have seen its path and the whole of
what it holds", in the file that was about to be halved. A predecessor draft had
named Syncthing `trashcan` versioning as the net. It cannot be one, and that is
what forced the question open again.

Two acts came out of it where there had been one. What no longer belongs in the
knowledge is archived: the file moves to `archive/`, a sibling of `notes/` and
`drafts/`, loses the brackets in its `hub` and gains an `archived` date, while
`type` and `tags` stay, because the file records what it was and how it was
filed. That is the ordinary way out and it is a mode of the note skill. Deleting
stays the rare act on my command: the file moves to `~/projects/vault/.trash/`
under a name carrying the timestamp and never through `rm`. Emptying that bin is
the only irreversible act left in the system, and the sentence about the path
and the whole content now guards it alone.

`~/projects/.stignore` belongs to the Syncthing folder `~/projects` and not to
the vault, and its `**/.trash/` covers every project's bin, so the vault's own
bin replicates only through a negation ahead of it, the form its first lines
already used. The same file excludes `**/.obsidian/`, which makes every Obsidian
setting a per-device setting and is why one part of this cannot be automated.

## Considered Options

**Syncthing `trashcan` versioning (rejected).** It was the predecessor draft's
answer and it needs no new folder at all. It was rejected because versioning is
configured per device and is not replicated. Whether a local `rm` is archived on
the receiving devices was never settled, so a `trashcan` on this machine alone
is no net, and an agent is meant to run on all four devices.

**`gio trash` (rejected).** It removes and restores with the content intact, and
that was proved on this machine. It was rejected because it is a desktop
convention: `ubuntu-server` need not even carry `gio`, and the rule has to hold
wherever the agent runs.

**Obsidian's Local REST API plugin (rejected).** It deletes through
`app.fileManager.trashFile()` and therefore follows the vault's own "Deleted
files" setting, which is exactly the right semantics, and it now carries an MCP
server of its own. It was rejected because it needs the desktop app running.

**Obsidian CLI (rejected).** Its `delete` trashes by default, which is the same
correct semantics from a shell. It was rejected for the same reason, in its own
words: "Obsidian CLI requires the Obsidian app to be running."

**Obsidian Headless (rejected).** It is the one that runs without the desktop
app. It was rejected because it serves only Obsidian Sync and Publish, and this
vault syncs with Syncthing.

**A bin that does not replicate (rejected).** Leaving `**/.trash/` alone is one
line less and keeps every project's bin local. It was rejected because a file
taken out on the laptop would then be recoverable on the laptop only, and the
device that deleted it is the one least likely to be the device that misses it.

**A visible replicated bin, `trash/` beside `notes/` (rejected).** It is easier
to find and needs no dot. It was rejected because Obsidian and Dataview would
index it, so deleted notes would keep turning up in search and in the graph. As
a dot folder neither ever looks.

**Scoping the index query instead of unlinking `hub` (rejected).** The index's
hub table counts with `length(file.inlinks)`, so a path filter there would stop
an archived note from raising its hub's count, and the note's frontmatter would
not have to change at all. It was rejected because no Dataview scoping reaches
Obsidian's own backlinks panel, which would go on listing the archived note
under its hub. Only unlinking the value does, and the test below confirmed it.

**Deleting instead of archiving (rejected).** It is what a `dropped` draft or a
superseded note invites. It was rejected because "we considered this and
rejected it" is exactly what cannot be reconstructed later, and the vault has no
version control to reconstruct it from.

## Consequences

- `archive/` and `.trash/` stand next to `notes/` and `drafts/`, and
  `~/projects/.stignore` carries `!/vault/.trash` and `!/vault/.trash/**` above
  its `**/.trash/`.
- Archiving is the fourth mode of the note skill, with its own frontmatter check
  for the unlinked `hub` and the `archived` date. `updated` does not move: the
  content did not change.
- A draft is never archived. `archive/` holds what left the knowledge, and a
  draft was never knowledge; a `dropped` draft records the rejection where it
  stands.
- Moving a note keeps every link, and the folder is not what takes it out of its
  hub. A scratch vault opened in Obsidian resolved `[[b]]` from `notes/a.md` to
  `archive/b.md` in both directions. Of three notes naming the hub `h`, its
  backlinks listed the one in `notes/` and the one in `archive/` that kept its
  bracketed `hub`, and not the one in `archive/` that gave the brackets up. The
  result is in `notes/second-brain-folder-moves-and-links.md`.
- The archiving report names every note that still links to the archived one,
  because a reader following such a link lands in the archive without being told
  the note left the knowledge.
- "Deleted files" has to be set to "Move to Obsidian trash" on each of the four
  devices by hand, since `.obsidian/` is not replicated. Until that is done, a
  deletion made inside Obsidian does not use the same bin the agent uses.
