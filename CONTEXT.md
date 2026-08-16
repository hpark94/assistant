# Assistant

Vocabulary for this repo: how the curated knowledge in the Obsidian vault is
organised, what may be written there and on whose command, and what the two
agents that read `AGENTS.md` have in common.

## Language

### The vault

**Vault**:\
The curated knowledge and the unfinished thinking: Notes, Hubs, Drafts and the
generated Index. It lives in `~/projects/vault`, an Obsidian vault replicated by
Syncthing to four devices and deliberately outside version control, together
with the Machinery.\
_Avoid_: notes folder, knowledge base, wiki

**Machinery**:\
Everything in the Vault directory that is not knowledge: `.obsidian/`,
`.obsidian.vimrc`, `.prettierrc`, `.marksman.toml`. It configures the tools that
read and write the Notes and carries none of their content, so a tool changing
it is not a write to the Vault and needs no command and no preview.\
_Avoid_: config, dotfiles, plumbing

**Note**:\
One self contained topic, one file with `type: note` in `notes/`. May be three
lines long. Stands on its own: a reader who never saw the session it came from
can use it. Distinct from a Hub and a Draft.\
_Avoid_: entry, article, doc, page

**Hub**:\
One subject area, one file with `type: hub` in `notes/`. Lists the Notes that
belong to it and carries no knowledge of its own, only its own Summary and a
generated list. Distinct from a Note and a Draft.\
_Avoid_: MOC, index note, category, folder

**Topic**:\
The single Hub a Note belongs to, declared by the Note and never by the Hub. A
Note has exactly one, a Hub has none. Subjects that cut across Hubs are tags,
not a second Topic.\
_Avoid_: parent, category, section, folder

**Summary**:\
The one line a Note, Hub or Draft says about itself, written to be read in a
list next to nine others rather than inside the file.\
_Avoid_: description, abstract, excerpt

**Index**:\
`index.md`, the entry point. A derived view of the Vault, never a second source
of truth maintained by hand.\
_Avoid_: home, table of contents, dashboard

**Draft**:\
Unfinished thinking about one Project, one file in `drafts/`. Not knowledge and
not a Note: it may weigh options that were never decided. Belongs to a Project,
never to a Hub, and no query over `notes/` ever sees it.\
_Avoid_: note, spec, plan, scratch

**Status**:\
Where a Draft stands: `todo`, `wip`, `done`, `superseded` or `dropped`. Changed
on command, never by the agent's own judgement, and a `dropped` Draft stays on
disk because the rejected option is what cannot be reconstructed later.\
_Avoid_: state, phase, progress

### Working in it

**Capture**:\
Turning a finished topic into a Note. Happens only on command, never on the
agent's initiative. It writes the Note and may create its Hub, but never edits
an existing Hub or the Index. Together with writing a Draft it is the only thing
that writes to the Vault, and every file is shown before it is written.\
_Avoid_: save, log, dump

**Project**:\
A directory I work in, named by its directory: `routing-lab`, `dots`, `fuseki`.
A Draft names the one it belongs to, and the name is the directory's, so that
the same string finds it in the Vault and on disk.\
_Avoid_: repo, workspace, codebase

**Notizwuerdig**:\
The single line an answer may end with when it produced something durable. A
suggestion, not an action, and never repeated for the same topic.\
_Avoid_: reminder, nudge, follow up

**Proof**:\
A claim settled by actually running something, kept in the Note together with
the exact command. A Note without a Proof may still be right, it just does not
claim to have been checked.\
_Avoid_: test, validation, evidence

**Agent**:\
Claude or Codex. The contract in `AGENTS.md` and in the note skill is identical
for both, only paths and invocation differ.\
_Avoid_: model, assistant, bot
