# A new file takes no name the vault already holds

ADR 0041 stopped an image copy only on a collision inside `notes/assets/`. A
review found the same collision one level up: a topic that was archived comes
back with the same title, so the new note takes the archived note's slug, the
vault holds two `<name>.md`, a `[[<name>]]` link resolves to either, and the new
note can never be archived. A draft can meet a note's name the same way.

A new file, a note, a hub, an image copy or a draft, now never takes a name that
stands anywhere in the vault outside `.trash/`. The skill says so and stops
before the preview, with another title in one line for a note or a hub. An image
with the same bytes already in `notes/assets/` is embedded as it is.

The same review settled what the image rule of ADR 0041 leaves to a draft:
`global.md` now says only a Note embeds one, and the draft skill writes an image
I pass as text on what it shows.

## Considered Options

**A `-v2` suffix on the new note (rejected).** It keeps the capture going. It
was rejected because a note's file name is its title's slug, and a suffix breaks
that agreement on a file nobody renamed.

**Reusing the name and accepting two files (rejected).** It was rejected because
Obsidian resolves a link by name, and the archived note would answer for the
live one.

**Checking only the target folder (rejected).** It is the rule ADR 0041 had. It
was rejected because the link resolves across the whole vault, not the folder.

**Embedding images in drafts as well (rejected).** It was rejected because a
draft is unfinished thinking, and an asset copied for it would outlive the draft
in `notes/`, which is the knowledge.

## Consequences

- The `-v2` chain of drafts needs no exception: its counter is the next free
  name.
- `.trash/` is left out because its names carry a timestamp and are never
  linked.
