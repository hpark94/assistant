# Archiving is a mode of the note skill

ADR 0020 settled that the vault gets rid of things by moving them, and that what
leaves the knowledge goes to `archive/`. It did not settle where that operation
lives or what it does to a note's dates. Both were decided while the note skill
was rewritten, and both are the kind of question that gets reopened by whoever
next reads the file and finds it long.

Archiving is the fourth mode of the note skill. It moves the file with `mv`,
unlinks the `hub` value, adds `archived`, and leaves `type`, `tags`, `created`
and `updated` alone.

## Considered Options

**An `archive` skill of its own (rejected).** The note skill is the longest file
in the repo and archiving writes no knowledge at all, so a separate file with a
separate trigger reads like the tidier split. It was rejected by the rule that a
skill stands on itself and `global.md` and nothing else. An archive skill would
have to carry the whole Note frontmatter contract, the prettier step, the
preview rules and the hub vocabulary a second time, and the operation is defined
entirely as edits to that contract: `hub` unlinked, `archived` added, `type` and
`tags` untouched. That is a fourth normative surface, which is what ADR 0019
removed.

**Bumping `updated` on an archiving (rejected).** Every other write in the vault
moves it, and a file whose frontmatter changed without it looks stale. It was
rejected because `updated` answers when the content last changed, and archiving
changes no content. `archived` carries the day it left. Nothing would read the
bumped value either: `index.md` sorts recently changed notes by `updated` and
asks for stale checks by `verified`, and both queries are scoped `FROM "notes"`,
which the file has just left.

**Deleting the `hub` property instead of unlinking it (rejected).** It takes the
note out of the hub's backlinks just as surely and leaves no half-value behind,
and the frontmatter would be shorter. It was rejected because the file has to
record how it was filed. A note restored to `notes/` without its `hub` lands in
the index's orphan query, `WHERE type = "note" AND !hub`, and nothing else would
say where it belonged. Unlinking keeps the answer and drops only the link.

**Moving through Obsidian rather than with `mv` (rejected).** The note skill
already forbids `mv` on a note, because renaming in Obsidian carries the
incoming wiki links along and `mv` leaves them pointing nowhere on four devices.
Keeping one rule would have been simpler than two. It was rejected because the
two acts differ in the thing that matters: a rename changes the file name and a
move does not, so no incoming link has to be rewritten, which the scratch vault
in `notes/second-brain-folder-moves-and-links.md` confirmed in both directions.
Requiring the GUI would also put the one step of archiving that an agent can do
safely out of its reach.

## Consequences

- The note skill has four modes, and the fourth has its own frontmatter check,
  because the archived form takes a `hub` the ordinary check rejects.
- `updated` does not move on an archiving. A reader who wants to know when a
  note left the knowledge reads `archived`.
- An archived note still says which hub it belonged to, so restoring it is a
  move back plus the brackets.
- `mv` is permitted for the move and stays forbidden for a rename. The note
  skill says which is which at both places.
