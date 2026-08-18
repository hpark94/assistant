# A Topic is the subject, and the Hub has its own property

`CONTEXT.md` defined **Topic** as "the single Hub a Note belongs to", while
`skills/note/SKILL.md` step 1 asked for "the last self contained topic",
`skills/draft/SKILL.md` built a file name from "`<topic>`, a short ASCII slug of
the subject", and `global.md` offered `notizwuerdig: <topic>`. Three of the four
sites meant the subject. Read under its own vocabulary, the definition of
Capture said a Capture turns a Hub into a Note.

Two reviews found it independently, which is what settled it. A term used in one
sense by the file that owns meanings and in another by every file that acts on
it is not a wording problem: an agent reading step 1 as "identify the hub" has
no instruction left for choosing what the note is about, and `notizwuerdig:`
takes a hub name in one reading and a subject in the other.

**Topic** now names the one self contained subject a Note, a Draft or a marker
is about. What was true of the Hub, that a Note declares it and the Hub never
declares its Notes, and that cross-cutting subjects are tags, moved into the
**Hub** entry where it belongs.

The frontmatter property followed the term. `topic: "[[disk-management]]"` is
now `hub: "[[disk-management]]"`. Leaving it would have kept the collision alive
at the one place it costs most, in the file an agent writes.

## Considered Options

**Redefine Topic as the Hub and change the three usages (rejected).** The other
direction: keep the definition and rewrite `note` step 1, the draft file name
rule and the marker to say "subject". It touches three files instead of the
vault. It was rejected because the majority usage is not an accident: a Note is
about a subject and files under a Hub, and the word for the first one is what
every sentence describing the work needs. The property would then still be
called `topic` and mean the Hub, which is the collision itself.

**Keep the property name (rejected).** Redefine the term, leave `topic:` alone
and note in `CONTEXT.md` that the key is a legacy name. It writes nothing to the
Vault and needs no migration. It was rejected after the migration turned out to
be cheap and safe: Obsidian renames a property across all notes in one step, and
a property rename touches no link target, unlike a file rename. A legacy name
that contradicts the vocabulary is a permanent tax on every reader of the
contract.

## Consequences

- Obsidian renamed the property in 15 Notes. The Hub Dataview blocks were not
  touched and did not need to be: `FROM [[]]` follows any link property to the
  current file, whatever it is called.
- `index.md` line 33, the orphan query from ADR 0003, is
  `WHERE type = "note" AND !hub`. Obsidian's property rename does not reach
  query text in a body.
- The note skill's frontmatter check, its Note contract and its Hub check, and
  the draft skill's `("tags","hub")` rejection list carry the new name. The
  draft list lost a duplicate: it named both `topic` and `hub` before.
- Four files described the property in prose rather than using it, and were
  corrected as their own change: `notes/second-brain-note-reclassification.md`,
  whose `## Verified` block carried a `rg -o -N '^topic: ...'` command that now
  finds nothing and was re-run, `notes/second-brain-vault-setup.md`,
  `drafts/assistant-note-reclassification.md` and `drafts/dots-hub-reader.md`.
- ADR 0001, 0002 and 0008 name the property `topic`. They stay as they are. They
  record what was decided when it was decided, and this file is where the name
  changed.
