# What holds in every project

These rules travel into every project, on top of what the project itself says.
Your role there, and how work gets done there, are the project's to define and
never this file's: where the two seem to disagree about that, the project wins.
The Vault is the exception, because it is one and the same from everywhere.

## The bright line

- **Answering and looking things up**: just do it.
- **Notes, Hubs and Drafts**: use the responsible skill under Commands, on the
  triggers that skill names. Each skill owns the complete authorization,
  preview, validation, write, format and reporting contract for its operation.
- **Every other write to the Vault**, a correction to an existing Note outside a
  capture, a deletion, the Index: only on my command, as its own change. Show
  the proposed change and wait for my OK before writing it. Nothing is deleted
  before I have seen what would go: the Vault has no version control to undo it
  with.

If an answer produced something durable, you may append at most one line:
`notizwuerdig: <topic>`. If a conversation settled thinking about a project that
is not carried out yet, the line is `entwurfswuerdig: <topic>` instead, which is
how a grilling ordinarily ends. Either one is one line, once. No follow-up, no
second nudge on the same topic. I decide what gets written.

## Proving claims

When I ask whether something is possible, whether something behaves a certain
way, or why something does not work, prove it. Do not answer from memory.

- Build the smallest demonstration that settles it, then give me the result
  **and the command you ran**.
- If no cheap or safe test exists, say so and mark the answer as unverified. A
  guess in the tone of a fact is the one failure mode I cannot catch.

### Where tests run

In a scratch directory, never in my live setup. Every proof that runs a tool or
creates a file opens with `SCRATCH=$(mktemp -d)`, so the commands you hand me
rebuild their own environment from nothing. Copy configs, redirect paths, use
minimal fixtures:

```sh
SCRATCH=$(mktemp -d)
printf 'vim.cmd.colorscheme("habamax")\n' > "${SCRATCH}/init.lua"
nvim --headless --clean -u "${SCRATCH}/init.lua" +'lua print(vim.g.colors_name)' +qa
XDG_CONFIG_HOME="${SCRATCH}/config" XDG_DATA_HOME="${SCRATCH}/data" some-tool
```

A fixture the proof needs is part of the proof: a command that reads
`${SCRATCH}/init.lua` without a line that writes it does not run when you hand
it to me.

`~/dots` and `~/.config` are read, never written. The proof is still real
because the tool actually runs, and it stays repeatable because I have the
command.

A proof that only reads needs no scratch directory. A `grep` over a config,
`git ls-files`, a parse of `config.toml`: there is nothing to isolate and
nothing that could be written. It is still a proof and still comes with its
command.

Verify the isolation itself before trusting a result. `nvim -u <file>` replaces
the init file but leaves `~/.config/nvim` on the `runtimepath`, so plugins and
`after/` from the live setup still load. Only `--clean -u <file>` or a
redirected `XDG_CONFIG_HOME` actually isolates:

```sh
nvim --headless --clean -u "${SCRATCH}/init.lua" \
  +'lua print(vim.o.runtimepath:find(vim.fn.expand("~/.config/nvim"), 1, true))' +qa
```

### Who runs it

One or two commands: inline, so I read along. If the proof needs a built
environment, plugin installs, or several variants, hand it to a fresh subagent
without this session's context, whatever your agent calls that. It reports back
the result and the commands instead of fifty tool outputs.

## The vault

`~/projects/vault`, an Obsidian vault replicated by Syncthing to four devices.
No version control: what is deleted there is gone on every device.

What sits in the directory besides the Vault, `.obsidian/`, `.obsidian.vimrc`,
`.prettierrc`, `.marksman.toml`, is Machinery. It configures the tools that read
and write the knowledge, and changing it is not a write to the Vault: it needs
no command of its own and no preview, it is ordinary work like any other change
to a config.

**Read, search and write on disk** with Grep, Glob, Read and the agent's file
editing tool. The Vault is plain Markdown at a known path and needs no API. That
is a tool choice and not a permission: what may be written is the bright line
above.

## Answering from the vault

For any question about my projects or my tools, search `notes/` first and tell
me what you are relying on. The vault holds only what I captured on command:
nothing records a session by itself, so a session that produced neither a note
nor a draft left nothing in the vault.

## Operational ownership

The note skill owns every Note and Hub operation. The draft skill owns every
Draft operation and its lifecycle. Each assumes this file and nothing else. This
section routes to them and does not repeat their procedures.

## Images and the web

An image I paste never becomes a file, so only the ones I pass by path can be
worked with or embedded in a note.

Search and fetch the web freely where a fact cannot be checked locally, and
always name the source with its URL.

## Memory vs. vault

What changes how you work goes into your own memory, wherever the agent you are
keeps it. What I want to look up later goes into the vault. Rule of thumb:
behaviour in memory, subject matter in the vault.

## Commands

- The note skill: distill the last topic into a note. Claude invokes it as
  `/note`, Codex as `$note`. These phrases do the same as a bare invocation:
  "merk dir das", "mach eine Notiz draus", "das ist wichtig", "halt das fest".
- The draft skill: `/draft` writes this conversation down as a draft for the
  project it is about, `/draft --open` lists the open drafts of the project I am
  working in, reads the one I pick, and asks how to proceed. It never fires on
  its own reading of the conversation, only when I invoke it. I point at a draft
  when I want it; nothing searches for drafts unasked. It never grills: an
  interview happens before it, on its own trigger, and ends with the
  `entwurfswuerdig` line above.

## Which agent you are

Both Claude and Codex read this file, Claude as `~/.claude/CLAUDE.md`, Codex as
`~/.codex/AGENTS.md`, both symlinks to `~/repos/assistant/global.md`. A
project's own file is added to this one and never replaces it, but the two
agents pick different files, so a repo meant for both carries both. The contract
is the same for both agents; only these facts differ.

| What              | Claude                                            | Codex                                                |
| ----------------- | ------------------------------------------------- | ---------------------------------------------------- |
| Project file      | `CLAUDE.md`; an `AGENTS.md` only via `@AGENTS.md` | `AGENTS.md`; a `CLAUDE.md` is ignored                |
| Skill directory   | `~/.claude/skills/`                               | `~/.agents/skills/`, plus `.agents/skills` in a repo |
| Invoking a skill  | `/note`, `/draft`                                 | `$note`, `$draft`, or pick it from `/skills`         |
| MCP configuration | `~/.claude.json`                                  | `~/.codex/config.toml`                               |
| Memory            | `~/.claude/projects/<slug>/memory/`               | Codex's own memories                                 |

Facts about the setup, not commands to run:

- `~/repos/assistant` holds this file and the note and draft skills. Its
  `install.sh` symlinks all of them into place, relatively, so the links survive
  a different user name or a moved home. Nothing else about the setup is
  versioned: neither `~/.claude` nor `~/.agents/skills`, where the other skills
  live.
- `disable-model-invocation: true` in a skill's frontmatter keeps it out of the
  list the model chooses from. Claude honours it, Codex does not: it lists such
  a skill with its full description in `<skills_instructions>` anyway, checked
  with `codex debug prompt-input`. A skill that must not fire by itself
  therefore says so in its own `description`, which is the only part Codex
  reads.
- The draft skill carries that flag, the note skill deliberately does not: only
  the model matches "merk dir das", so the flag would leave `/note` as the sole
  trigger. What keeps a Capture from firing unbidden is the skill's
  `description`, not the frontmatter.
- Neither Agent configures the Vault as an MCP server. Both work with its
  Markdown files directly.

## Style

- Speak German with me. Everything written down is English: notes, this file,
  `CONTEXT.md`, the ADRs, code, identifiers and commit messages.
- No em dashes. Use commas, periods, semicolons, colons.
- Minimal diffs: touch only what the subject requires. No rewording or
  reformatting in passing.
- YAGNI: the simplest change that carries the point. No empty sections,
  placeholders or scaffolding for work that does not exist yet.
