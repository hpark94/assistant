# Assistant

Vocabulary for this repo: how the curated knowledge in the Obsidian vault is
organised, what may be written there and on whose command, and what the two
agents that read `AGENTS.md` have in common.

## Language

### The vault

**Vault**:\
`~/projects/claudevault`, an Obsidian vault replicated by Syncthing to four
devices and deliberately outside version control. Holds the curated knowledge,
the raw transcripts it came from, and nothing else.\
_Avoid_: notes folder, knowledge base, wiki

**Note**:\
One self contained topic, one file in `notes/`. May be three lines long. Stands
on its own: a reader who never saw the session it came from can use it.\
_Avoid_: entry, article, doc, page

**Hub**:\
The Note that names a subject area and lists the Notes belonging to it. Carries
no knowledge of its own, only its own Summary and a generated list.\
_Avoid_: MOC, index note, category, folder

**Topic**:\
The single Hub a Note belongs to, declared by the Note and never by the Hub. A
Note has exactly one, a Hub has none. Subjects that cut across Hubs are tags,
not a second Topic.\
_Avoid_: parent, category, section, folder

**Summary**:\
The one line a Note says about itself, written to be read in a list next to nine
others rather than inside the Note.\
_Avoid_: description, abstract, excerpt

**Index**:\
`index.md`, the entry point. Derived entirely from what Notes and Hubs declare
about themselves, and therefore never edited by hand.\
_Avoid_: home, table of contents, dashboard

**Transcript**:\
A raw session record under `chats/`. Deliberately not knowledge: it holds dead
ends and things we later rejected, and is read only when a Note is being built
from an earlier session.\
_Avoid_: history, log, archive

### Working in it

**Capture**:\
Turning a finished topic into a Note. Happens only on command, never on the
agent's initiative, and is the only thing that writes to the Vault.\
_Avoid_: save, log, dump

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
