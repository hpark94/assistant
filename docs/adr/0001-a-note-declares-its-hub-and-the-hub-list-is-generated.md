# A Note declares its Hub, and the Hub's list is generated

The vault grows into a second brain, so Notes need a home without folders and
without a taxonomy designed up front. We give it exactly two levels: a Note
declares its single Hub in its own frontmatter as a link property,
`topic: "[[disk-management]]"`, and the Hub renders its children with a Dataview
block that is byte for byte identical in every Hub:

````markdown
```dataview
TABLE summary AS "Content", updated
FROM [[]] and "notes"
WHERE type = "note"
SORT file.name ASC
```
````

The link therefore exists once, written by the same skill in the same step that
creates the Note. A capture never edits an existing Hub or the Index; when its
Hub does not exist yet, the approved write creates both the Hub and its first
Note. Since Obsidian 1.4 a link in a property is a real link, so backlinks and
the graph keep working, while `FROM [[]]` selects the pages linking to the
current file and needs no per Hub editing.

## Considered Options

**The Hub links down to its children by hand (rejected).** The only variant in
which the child list is readable outside Obsidian, in `rg` or in nvim. It pays
for that with a second write per Note into a file the Note does not own, which
is the classic place for drift, and it makes every capture two edits instead of
one.

**The child links up, the Hub shows only backlinks (rejected).** Free of drift
as well, but the child list then lives in a sidebar pane rather than in the Hub,
so the Hub as a document says nothing.

**More than two levels, or more than one Hub per Note (rejected).** Both turn
"where does this go" into a real decision at capture time, and that decision is
what kills second brains. Retrieval runs through `ffd` and `frg` anyway, so the
hierarchy only has to show what is already known about a subject, not make it
findable.

## Consequences

- Dataview output is not part of Obsidian's link index, so the rendered list
  adds no graph edges. This costs nothing here because the child's property
  already provides the real edge.
- Outside Obsidian a Hub shows query text, not its children. The terminal
  equivalent is `rg -N '^topic:' ~/projects/vault/notes/`.
- Allowing several Hubs per Note later means rewriting the frontmatter of the
  affected Notes and changing one line per Hub query. Minutes at vault scale,
  but not free.
