---
description: Distill the last topic of the conversation into a vault note
---

Turn the last self contained topic of this conversation into a note in
`~/projects/claudevault/notes/`, following the note contract in `AGENTS.md`.

Arguments, if any, name the topic to capture: $ARGUMENTS

## Procedure

1. **Scope.** Identify the last self contained topic we discussed, not the whole
   session. If arguments were given, they name the topic instead. One note is
   one topic; if two unrelated things are worth keeping, write two notes.
2. **Search first.** Grep `~/projects/claudevault/notes/` for the topic, its
   tags, and likely synonyms. Read any candidate before deciding.
3. **Write.**
   - On a hit: extend that note, correct what is now wrong, bump `updated`.
     Never delete existing content silently.
   - On no hit: create `notes/<title-slug>.md` with the full frontmatter
     (`title`, `type`, `tags`, `created`, `updated`, `session`), body as
     `# Title`, a one or two sentence core, then only the sections that have
     content.
   - If the note states something we actually checked, add `verified: <today>`
     and a `## Verified` section holding the command that proves it.
   - Link related notes as `[[slug]]` under `## Related`.
   - Write through the Obsidian MCP. If its tools are not available in this
     session, write the file on disk and say so in the report.
4. **Format.** `prettier -w` on every file you touched, no flags, and only once
   the file sits in the vault. Prettier reads the `.prettierrc` next to the
   file, so formatting a draft elsewhere silently loses `proseWrap: always`.
5. **Index.** Add or update the note's line in
   `~/projects/claudevault/index.md`, under the heading matching its `type`, as
   `- [[slug]]: half a sentence`.
6. **Commit.** `git -C ~/projects/claudevault add -A` and commit with subject
   `note(<slug>): what changed`, no `Co-Authored-By` line.
7. **Report.** One or two sentences: which file, created or extended, and what
   changed if it was an extension.

## Notes

- The session id for the `session` field is the current session's id.
- Titles and note bodies are English, even though we speak German.
- No em dashes.
