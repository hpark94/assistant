---
name: note
description:
  "Distill one topic into a note in Hyeong-Gyu's Obsidian vault at
  ~/projects/claudevault. Triggers, and nothing else: the command /note, or the
  German phrases 'merk dir das', 'mach eine Notiz draus', 'das ist wichtig',
  'halt das fest'. Also handles /note --from <hint>, which builds the note from
  an earlier session's transcript instead of the current conversation."
---

# /note

Turn one self contained topic into a note in `~/projects/claudevault/notes/`.
Writing to the vault happens only on command, never on your own initiative. This
file is the complete contract: it must work in projects whose `AGENTS.md` you
have never seen.

Arguments, if any, name the topic to capture: $ARGUMENTS

## Two modes

| Invocation                    | Source                          |
| ----------------------------- | ------------------------------- |
| `/note [topic]`               | This conversation               |
| `/note --from <hint> [topic]` | An earlier session's transcript |

`<hint>` is free text: a session id, a date, a project name, or a keyword.

Everything below applies to both modes. The backfill section adds what differs.

## Procedure

1. **Scope.** Identify the last self contained topic discussed, not the whole
   session. If arguments name a topic, they win. One note is one topic; if two
   unrelated things are worth keeping, write two notes.
2. **Search first, never write a duplicate.** Grep
   `~/projects/claudevault/notes/` for the topic, its tags, and likely synonyms.
   Read any candidate before deciding.
   - **On a hit**: extend that note, correct what is now wrong, bump `updated`.
     Never delete existing content silently, and say afterwards what changed.
   - **On no hit**: create `notes/<title-slug>.md`.
3. **Write.** Through the Obsidian MCP (`mcp__obsidian__vault_write`), so paths
   stay vault relative and Obsidian sees the write. Those tools are bound at
   session start; if they are absent here, write the file on disk and say so
   instead of implying the write went through the vault API.
4. **Format.** `prettier -w` on every file you touched, no flags, and only once
   the file sits in the vault. Prettier reads the `.prettierrc` next to the
   file, so formatting a draft elsewhere silently loses `proseWrap: always`.
5. **Index.** Add or update the note's line in
   `~/projects/claudevault/index.md`, under the heading matching its `type`, as
   `- [[slug]]: half a sentence`.
6. **Report.** One or two sentences: which file, created or extended, and what
   changed if it was an extension.

## Note contract

The filename is the title as an ASCII slug (`obsidian-mcp-setup.md`), because
marksman resolves wiki links by title slug and reports broken ones as errors.

```markdown
---
title: Obsidian MCP Setup
type: tool
tags: [obsidian, mcp, claude-code]
created: 2026-08-11
updated: 2026-08-11
session: 30eca1dd-79a9-4984-8938-382c3715b51f
verified: 2026-08-11
---

# Obsidian MCP Setup

One or two sentences: what this is about and what the insight was.

## Details

The substance. Commands in code blocks, paths as `code`.

## Verified

`curl -sk https://127.0.0.1:27124/vault/` lists the vault root.

## Related

- [[claude-code-hooks]]
```

- `type` is one of `project`, `tool`, `topic`.
- `session` is the id of the session the note came from. The transcript gets its
  filename only at SessionEnd, so a wiki link to it cannot resolve at write
  time; the id is the durable handle, and the notes under `chats/` carry it in
  their own frontmatter.
- `verified` and the `## Verified` section appear only on notes that make a
  checked claim. A feasibility claim goes stale when a tool updates, and
  `updated` only says when the file was last touched.
- A note may embed an image the hook extracted as `![[filename.png]]` when the
  image carries the point.
- A web source belongs in the body with its URL, never in the frontmatter.
- Write only the sections that have content.

## Backfill: `/note --from <hint> [topic]`

The chat files under `chats/` are the cheap search index, about 3 KB each. The
raw transcript is the content, because the SessionEnd hook keeps only `text` and
`image` blocks: every command the session ran is missing from `chats/`.

1. **Find.** Grep `~/projects/claudevault/chats/*.md` for the hint. Each hit's
   frontmatter carries `session_id` and `project`.
2. **Resolve.** `find ~/.claude/projects -name '<session_id>.jsonl'`. Never
   build that path from `project:`: it is the `cwd` at SessionEnd, not the
   directory the session started in, so it points at the wrong slug whenever the
   session changed directory.
3. **Read.** Parse the jsonl and keep `text`, `tool_use` and `tool_result`
   blocks. Transcripts run to hundreds of KB; filter, do not pull the file into
   context whole.
4. **Ask when anything is open.** If more than one session matches, or the topic
   is not one you named, put the candidates up and wait. `chats/` holds dead
   ends and things we later rejected, so choosing the topic is not yours to do.
   When both session and topic are pinned, write without asking.
5. **`session`** is the **source** session's id, not the current one. `created`
   and `updated` are today.
6. **`verified`.** Re-run the transcript's command in the scratchpad. If it
   passes, `verified: <today>` with exactly that command under `## Verified`. If
   it fails, is not safely repeatable, or depends on state from back then, leave
   `verified` out entirely and put one sentence in the body: the command comes
   from the session of `<date>` and was not re-checked today.

## Style

- Notes are English, even though we speak German.
- No em dashes. Use commas, periods, semicolons, colons.
- Minimal diffs when extending a note: touch only what the topic requires, no
  rewording in passing, no reformatting of untouched sections.
- YAGNI: the simplest note that carries the point. No empty sections, no
  placeholders.
