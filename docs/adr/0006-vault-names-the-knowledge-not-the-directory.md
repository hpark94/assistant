# Vault names the knowledge, not the directory

`CONTEXT.md` said the Vault holds the curated knowledge, the unfinished thinking
"and nothing else", and ADR 0005 said the Vault is now `notes/`, `drafts/` and
`index.md`. The directory holds more than that: `.obsidian/`, `.obsidian.vimrc`,
`.prettierrc` and `.marksman.toml` sit next to them and have to. From here on
**Vault** names the knowledge, the Notes, Hubs, Drafts and the generated Index,
and the directory `~/projects/vault` is where that knowledge lives together with
the machinery that makes it editable.

Machinery is the second word this buys: Obsidian's configuration, the vim
bindings, the prettier and marksman settings. It configures the tools that read
and write the knowledge and carries none of it. The rules about writing to the
Vault, only on command and never before he has seen it, are rules about
knowledge; Obsidian rewriting `workspace.json` when a pane moves is not a Vault
write and never needed an OK.

## Considered Options

**Vault names the directory (rejected).** It is the shorter definition, one
string, one path, nothing to explain. But then "the Vault holds knowledge and
nothing else" is simply false, and worse, every rule that governs writes to the
Vault would nominally govern `.obsidian/workspace.json`, which Obsidian rewrites
whenever a pane moves. A contract that the editor violates a hundred times a day
is not a contract.

**Move the machinery somewhere else (rejected).** It would make the directory
and the knowledge the same thing again, which is the clean version of this
decision. It is not available: Obsidian defines a vault by the `.obsidian/` at
its root, and `.prettierrc` and `.marksman.toml` are resolved upward from the
file being formatted, so they have to sit at or above `notes/`. The machinery
lives there or the tools stop working.

**Rewrite the sentence in ADR 0005 (rejected).** ADR 0005 is the record of a
decision that was made on its own day, and its subject was transcripts, not this
boundary. Editing its scope sentence now would make the record claim something
that was never decided in it, and its Consequences already name `.obsidian/` as
excluded machinery, so the file is not even wrong, only imprecise about a word
this file now defines. It stays as written and is read together with this one.

## Consequences

- `CONTEXT.md` loses "and nothing else" from the **Vault** entry and gains
  **Machinery** as a term of its own. `AGENTS.md` names the machinery below the
  path table, so the three knowledge paths stay the answer to "what is in the
  Vault".
- Replication is a separate axis from this boundary and does not follow it.
  `~/projects/.stignore` excludes `**/.obsidian/` and `**/.trash/` and nothing
  else, so `.obsidian.vimrc`, `.prettierrc` and `.marksman.toml` replicate to
  all four devices along with the Notes. Only the part that conflicts,
  Obsidian's own state, stays local, and a new machine still needs `dataview`
  and `obsidian-vimrc-support` installed by hand.

  ```sh
  grep -nE 'obsidian|prettier|marksman|trash' ~/projects/.stignore
  # 4:**/.obsidian/
  # 5:**/.trash/
  # 285:.trash
  ```

- The curated Note `second-brain-vault-setup` describes the same directory and
  is not touched by this decision. It is knowledge in the Vault, so it changes
  only through a Note capture with its own preview and OK, never as a side
  effect of a repository change.
