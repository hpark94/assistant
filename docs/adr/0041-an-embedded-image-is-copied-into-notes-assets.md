# An embedded image is copied into notes/assets

`global.md` has always said that an image passed by path can be embedded in a
note, and no file said where that image goes. The note skill wrote only the
note's own path and nothing else, so one agent copied the image next to the
note, one asked for a separate command, and one linked the original absolute
path, which is a hole on the three other devices.

An image passed by path is now copied into `~/projects/vault/notes/assets/`
under its own file name, the folder made where it is missing, and embedded as
`![[<file name>]]`. The copy belongs to the note's approval unit. Where a file
with other content already has that name, the operation stops before the
preview.

## Considered Options

**Linking the original path (rejected).** It writes nothing into the vault. It
was rejected because Syncthing replicates the vault and not the rest of the
disk, so the embed resolves on one device of four.

**Prefixing the copy with the note's name (rejected).** It makes a collision in
`assets/` almost impossible. It was rejected because the name I gave the file is
the one I recognise, and a stop on a real collision costs one word, while a
prefix renames every image.

**Overwriting or suffixing on a collision (rejected).** Either keeps the
operation going. Overwriting replaces an image another note embeds, and a suffix
picked by the agent is a name two agents pick differently.

## Consequences

- `![[<file name>]]` resolves by name anywhere in the vault, so an archived note
  keeps its image, and the deletion grep in `global.md` finds its embeds.
- The copy uses `cp --update=none`: GNU coreutils 9.7 warns that `-n` may
  change.
