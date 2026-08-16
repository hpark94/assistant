# The Vault holds no transcripts

A `SessionEnd` hook, `~/.claude/hooks/save_to_obsidian.py`, wrote every Claude
session to `~/projects/vault/chats/` and decoded pasted images into
`attachments/`. Both directories are gone, the hook is unregistered and deleted,
and the Vault is now `notes/`, `drafts/` and `index.md`. A Note no longer
carries `session` or `agent`, and the note skill has lost its `--from <hint>`
backfill, which existed only to read those transcripts.

The capture never paid for itself. It produced 29 chat files against 13 Notes
and none of them were ever read: scanning them costs the time the Vault was
supposed to save. Worse, it was replicated. `session` pointed at
`~/.claude/projects/<slug>/<id>.jsonl`, which lives on exactly one of four
devices, so a Note carried a machine local pointer through a Vault whose whole
point is that it is the same everywhere. And it only ever worked for Claude:
Codex writes its rollouts elsewhere and had no reader, so half the sessions left
nothing behind anyway.

## Considered Options

**Keep the hook and thin it out (rejected).** Store only sessions above some
length, or prune `chats/` on a schedule. It attacks the volume and leaves the
two real problems standing: the transcripts still would not be read, and the
pointer into them would still resolve on one device only. It also keeps the open
work in `drafts/dots-vault-hook.md` alive, a Codex reader plus image
deduplication, for an index nobody queries.

**Keep `chats/` but exclude it from Syncthing (rejected).** The Vault would look
portable while quietly holding a directory that means something different on
every device. A file that exists here and not there is worse than no file: the
same `session` id then resolves on the desktop and fails on the laptop, with
nothing saying why.

**Point `--from` at `~/.claude/projects/*.jsonl` instead (rejected).** The raw
transcripts are still there and still greppable, so the mode could have
survived. But they are large and noisy, tool calls and base64 images included,
they are machine local by nature, and Codex would need a second path. It would
have bought back a feature that was never used, at the cost of the portability
this change is for.

**Delete `drafts/dots-vault-hook.md` rather than mark it `dropped` (chosen).**
`CONTEXT.md` says a `dropped` Draft stays on disk, because a rejected option is
what cannot be reconstructed. That rule is untouched and does not apply here:
nothing about the Draft was rejected, its subject was removed. There is no
decision left to preserve, and what there is to say is in this file.

## Consequences

- A session that produced neither a Note nor a Draft leaves nothing in the
  Vault. Claude prunes transcripts after 30 days by default and
  `cleanupPeriodDays` stays unset, so the window for a late capture is a month
  and then the session is gone on every device. That is the accepted price: the
  alternative was 29 files nobody read.
- A pasted image never becomes a file. It exists as base64 inside the transcript
  and nothing extracts it, so only an image passed by path can be worked with,
  and only such a path-backed image can be embedded in a Note.
- A Note has no provenance field any more. When one turns out wrong it is
  corrected on its own evidence, or its Proof is re-run; there is nothing to
  trace back to.
- `.obsidian/` stays excluded from Syncthing by `~/projects/.stignore`, a
  deliberate choice against conflicts in `workspace.json`. The Notes are
  portable, the machinery is not: a new machine needs `dataview` and
  `obsidian-vimrc-support` installed by hand.
- `~/dots` is unaffected. It never knew the hook: `bootstrap.sh` does not create
  the Vault or touch `~/.claude`, and `.stow-local-ignore` excludes `^/\.claude`
  outright. What ends here is the plan to adopt the hook there, not any existing
  step.
