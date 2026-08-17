# Assistant

Vocabulary and structural invariants for the curated knowledge in the Obsidian
vault and for the two agents that work with it.

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
read and write the Notes and carries none of their content.\
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
Where a Draft stands. `todo` is recorded but not begun, `wip` is being worked
on, `done` was carried out or became knowledge, `superseded` was replaced, and
`dropped` records a rejected idea instead of deleting it.\
_Avoid_: state, phase, progress

### Working in it

**Capture**:\
Turning one Topic into a Note, a new one or an extension of the one that already
holds it, optionally together with the first Hub for that subject. The Topic is
one the session settled or one established for the Capture.\
_Avoid_: save, log, dump

**Project**:\
A directory I work in, named by its directory: `routing-lab`, `dots`, `fuseki`.
A Draft names the one it belongs to, and the name is the directory's, so that
the same string finds it in the Vault and on disk. It is `[a-z0-9-]+`.\
_Avoid_: repo, workspace, codebase

**Notizwuerdig**:\
The marker `notizwuerdig: <topic>` for an answer whose result may be worth a
future Capture. A suggestion, not a Capture.\
_Avoid_: reminder, nudge, follow up

**Entwurfswuerdig**:\
The marker `entwurfswuerdig: <topic>` for settled thinking about a Project that
is not carried out yet and may be worth a Draft. The sibling of Notizwuerdig,
pointing at `drafts/` instead of `notes/`, and a suggestion just the same.\
_Avoid_: todo, action item, next step

**Proof**:\
A claim settled by an executed demonstration whose result and exact command are
recorded. A Note without a Proof may still be right, it just does not claim to
have been checked.\
_Avoid_: test, validation, evidence

**Agent**:\
Claude or Codex. Both load `global.md` in every Project and use the same Note
and Draft skills; only paths and invocation differ.\
_Avoid_: model, assistant, bot
