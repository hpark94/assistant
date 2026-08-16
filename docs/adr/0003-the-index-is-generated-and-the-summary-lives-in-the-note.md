# The index is generated, and the summary lives in the Note

`index.md` used to hold one hand written line per Note, and the note skill kept
it current. That is a second file edited on every capture, so it is the same
drift source the Hub model just removed. The half sentence moves into the Note
as a `summary` property, and `index.md` becomes queries only: the Hubs as the
entry point, plus maintenance queries for orphans without a Hub, Syncthing
conflict copies, the ten most recently touched Notes, and Proofs older than six
months.

The description is then written once and read in three places, because a
property is also the first thing `fzf-preview` shows while scrolling through
`ffd` hits.

## Consequences

- `index.md` in nvim is query text, not a list. The terminal equivalent is
  `rg -N '^summary:' ~/projects/vault/notes/`.
- The maintenance queries are the only thing that ever sees a
  `*.sync-conflict-*.md` file. Without them such a copy silently joins every
  other query.
