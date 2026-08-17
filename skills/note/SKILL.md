---
name: note
description:
  "Distill one topic into a note in Hyeong-Gyu's Obsidian vault at
  ~/projects/vault. Triggers, and nothing else: the command /note or $note, or
  the German phrases 'merk dir das', 'mach eine Notiz draus', 'das ist wichtig',
  'halt das fest'."
---

# note

Turn one self contained topic into a note in `~/projects/vault/notes/`. Writing
to the vault happens only on command, never on your own initiative, and nothing
goes into the vault before he has seen it. This file is the complete contract:
it must work in projects whose `AGENTS.md` you have never seen.

Claude invokes this as `/note`, Codex as `$note`. Arguments, if any, name the
topic to capture.

## Two modes

On a topic this conversation already settled, capture what it produced. On one
it did not, find out first, then capture what you found.

The second is the ordinary one for a second brain: "what are the Linux commands
for the size of a directory, and make a note of it". Establish the answer to the
same standard you would give it in conversation, which means run the command
rather than recall it, and name every web source with its URL in the note. Never
write a note from memory alone. In this mode the preview from step 5 **is** the
answer: do not write the same thing twice, once as prose and once as a note.
Anything that does not belong in the note, an intermediate result or a source
that contradicts another, goes in one or two sentences next to the preview.

## Proving a claim

A note that says something is possible, or behaves a certain way, is worth
nothing unless it was checked. Build the smallest demonstration that settles it
and put **both the result and the exact command** into the note, under
`## Verified` with a `verified` date.

A proof that runs a tool or creates a file runs in a scratch directory, never in
his live setup, so it opens with `SCRATCH=$(mktemp -d)` and the command in the
note rebuilds its own environment from nothing. Copy configs, redirect paths,
use minimal fixtures:

```sh
SCRATCH=$(mktemp -d)
XDG_CONFIG_HOME="${SCRATCH}/config" XDG_DATA_HOME="${SCRATCH}/data" some-tool
```

Verify the isolation itself before trusting the result: a tool that still reads
its live config proves nothing about a clean environment.

A proof that only reads needs no scratch directory. A `grep` over a config or a
parse of it isolates nothing and changes nothing, and it goes into the note with
its command like any other proof.

If no cheap or safe test exists, say so and write the claim down as unverified,
without `verified` and without a `## Verified` section. A guess in the tone of a
fact is the one failure mode he cannot catch.

## Procedure

1. **Scope.** Identify the last self contained topic, not the whole session. If
   arguments name a topic, they win. One note is one topic; if two unrelated
   things are worth keeping, write two notes.
2. **Search first, never write a duplicate.** Grep `~/projects/vault/notes/` for
   the topic, its tags, its likely hub and likely synonyms. Read any candidate
   before deciding.
   - **On a hit**: extend that note, correct what is now wrong, bump `updated`.
     Never delete existing content silently, and say afterwards what changed.
     Its hub is the one thing you never correct: if the content you are adding
     would have gone under a different hub as a new note, say so in one line,
     name that hub, and leave the move to him in Obsidian. It is one line and
     not a question, and it may fall again in a later session, because nothing
     records that it was already said. Never offer and never run `mv` on a note:
     renaming in Obsidian carries the incoming wiki links along, `mv` leaves
     them pointing nowhere on four devices.
   - **On no hit**: create a new note.
3. **Pick the hub.** Every note belongs to exactly one hub, named in `topic`. If
   an existing hub fits, use it. If none fits, pick a name and let the preview
   carry it: it shows the same name in the file name, in the title and in
   `topic`, which is more than a question would. A hub name is expensive, it is
   a prefix of every child's file name, so renaming it later renames files. Say
   in one line that the hub is new, so it is not mistaken for an existing one.
4. **Name the file.** `<hub-slug>-<short-name>.md`, the title as an ASCII slug:
   `disk-management-memory-usage.md` with the title
   `Disk Management: Memory Usage`. The hub carries the context, so keep the
   title itself short and the file name follows:
   `Virtualization: Docker libvirt NAT`, not
   `Virtualization: Docker Breaks libvirt VM NAT`. `ffd` matches paths and file
   names, never frontmatter, which is why the two agree.
5. **Show it, then wait.** Build the whole Note and, if its Hub is new, the
   whole Hub. Run every file through prettier and its matching frontmatter
   check, then put every result up with the path it would get. Nothing is on
   disk at this point, and nothing is written until he says so.

   For a Note:

   ```sh
   prettier --stdin-filepath ~/projects/vault/notes/<name>.md <<'EOF' \
     | python3 -c '
   import sys, yaml, re, datetime
   t = sys.stdin.read(); sys.stdout.write(t)
   m = re.match(r"---\n(.*?)\n---\n", t, re.S) or sys.exit("no frontmatter")
   try: f = yaml.safe_load(m.group(1))
   except yaml.YAMLError as e: sys.exit(f"frontmatter: {e}")
   d = lambda k: type(f.get(k)) is datetime.date
   bad  = [f"missing {k}" for k in ("title","type","topic","summary","created","updated") if k not in f]
   bad += ["type must be note"] * (f.get("type") != "note")
   bad += [f"{k} must be a string" for k in ("title","summary") if not isinstance(f.get(k), str)]
   bad += ["topic must be a quoted \"[[hub]]\""] * (not isinstance(f.get("topic"), str) or not re.fullmatch(r"\[\[[^]]+\]\]", str(f.get("topic"))))
   bad += ["tags must be a list"] * (not isinstance(f.get("tags", []), list))
   bad += [f"{k} must be YYYY-MM-DD" for k in ("created","updated") if not d(k)]
   bad += ["verified must be YYYY-MM-DD"] * ("verified" in f and not d("verified"))
   sys.exit("frontmatter: " + "; ".join(bad) if bad else 0)
   '
   <the whole note, frontmatter and body>
   EOF
   ```

   For a Hub:

   ```sh
   prettier --stdin-filepath ~/projects/vault/notes/<hub>.md <<'EOF' \
     | python3 -c '
   import sys, yaml, re, datetime
   t = sys.stdin.read(); sys.stdout.write(t)
   m = re.match(r"---\n(.*?)\n---\n", t, re.S) or sys.exit("no frontmatter")
   try: f = yaml.safe_load(m.group(1))
   except yaml.YAMLError as e: sys.exit(f"frontmatter: {e}")
   bad  = [f"missing {k}" for k in ("title","type","summary","created","updated") if k not in f]
   bad += ["type must be hub"] * (f.get("type") != "hub")
   bad += [f"{k} must be a string" for k in ("title","summary") if not isinstance(f.get(k), str)]
   bad += [f"{k} is not allowed on a hub" for k in ("topic","tags") if k in f]
   bad += [f"{k} must be YYYY-MM-DD" for k in ("created","updated") if type(f.get(k)) is not datetime.date]
   sys.exit("frontmatter: " + "; ".join(bad) if bad else 0)
   '
   <the whole hub, frontmatter and dataview block>
   EOF
   ```

   `--stdin-filepath` resolves the vault's `.prettierrc` from that path even
   though the file does not exist yet, so what he reads is byte for byte what
   lands. The check passes prettier's output through unchanged, so what gets
   validated is exactly the text you show and later write. The content rides in
   the heredoc, so no temporary file exists either: nothing is on disk before
   the OK. The delimiter must not occur in the content: a note that itself
   contains a line `EOF` needs `<<'NOTE'` or any other word that does not.

   A frontmatter that merely parses is not enough: `topic: [[hub]]` without
   quotes parses silently into a list and is no link in Obsidian, which is why
   the values are checked too. On a failure repair the frontmatter and run it
   again; never show a preview that did not pass.

   The date check is `type(...) is datetime.date` and not `isinstance`: PyYAML
   reads `2026-08-16 10:00:00` as a `datetime.datetime`, which is a subclass of
   `date` and would pass an `isinstance` check despite not being `YYYY-MM-DD`.

   **On an extension show only the changed passages**, never the whole file: the
   point of a minimal diff is that the change is visible. Run `prettier --check`
   on the target file before you build the extension. If it fails, the
   `prettier -w` in step 7 will reformat passages your topic never touched, so
   put that formatting change up as a second passage of its own and let him
   approve it separately. A reformat never rides along unseen on a content
   change.

6. **Write.** After the OK for every previewed file, write the approved content
   directly to its absolute path under `~/projects/vault/notes/`. If the Hub is
   new, write both approved files in the same step. Never write anywhere else.
7. **Format.** `prettier -w` on every file you touched, no flags, once the file
   sits in the vault. Prettier reads the `.prettierrc` next to the file, so
   formatting a copy elsewhere silently loses `proseWrap: always`.
8. **Report.** One or two sentences: which file, created or extended, under
   which hub, and what changed if it was an extension.

**A capture never edits `index.md` and never edits a hub's list.** Both are
Dataview queries over what the notes declare about themselves. Adding a line by
hand there creates a second truth that immediately drifts. `index.md` changes
only when he asks for that change itself, as its own preview and its own OK,
never on the way past a note.

## Note contract

```markdown
---
title: "Disk Management: Memory Usage"
type: note
topic: "[[disk-management]]"
summary: du, ncdu and df, and why the three disagree.
tags: [linux, disk, cli]
created: 2026-08-13
updated: 2026-08-13
verified: 2026-08-13
---

# Disk Management: Memory Usage

`du -sh ~/repos/*` sizes each subdirectory, `ncdu` does the same interactively.
`df -h` measures the file system rather than the tree and therefore disagrees.

## Verified

`du -sh /tmp` next to `df -h /tmp`, the difference is real.

## Related

- [[neovim-config-isolation]]
```

- `title` needs quotes because of the colon. This holds for **every** value: an
  unquoted scalar containing `: ` is read as a mapping and breaks the whole
  frontmatter, which Obsidian then reports as invalid properties. Either quote
  the value or write the line without a colon.
- `type` is `note`, nothing else. A Hub is a distinct file type with its own
  contract below. What a Note is about is carried by its Hub and its tags, not
  by a category.
- `topic` is the one hub, written as a quoted link. Obsidian indexes links in
  properties as real links, which is what makes the hub's list and its backlinks
  work. Exactly one, never a list.
- `summary` is one line, written to be read in a list next to nine others. It
  appears in the hub, in the index and in the fzf preview, and exists only here.
  Keep it under about 70 characters: `prettier` folds a longer value onto a
  second line, which is valid YAML but noise in the preview.
- `verified` and the `## Verified` section appear only on notes that make a
  checked claim. A feasibility claim goes stale when a tool updates, and
  `updated` only says when the file was last touched.
- A web source belongs in the body with its URL, never in the frontmatter.

Everything below the frontmatter is optional except the `# Title`. A three line
note is a good note: `summary` already says what it is about, so a short note
does not repeat that in prose. Write only the sections that have content.

## Hub contract

A hub holds no knowledge. It is frontmatter, a title, and a Dataview block that
is byte for byte identical in every hub, because `[[]]` refers to the current
file:

````markdown
---
title: Disk Management
type: hub
summary: Measuring disk usage, cleaning up, keeping file systems in view.
created: 2026-08-13
updated: 2026-08-13
---

# Disk Management

```dataview
TABLE summary AS "Content", updated
FROM [[]] and "notes"
WHERE type = "note"
SORT file.name ASC
```
````

A hub's file name is its title as an ASCII slug and nothing else,
`second-brain.md` for `Second Brain`. That slug is what `topic` links to and
what every child's file name starts with.

Hubs have no `topic`, no tags and no prose. Create one only together with its
first child, so that no `topic` link ever points at a file that does not exist.

## Style

- Notes are English, even though we speak German.
- No em dashes. Use commas, periods, semicolons, colons.
- Minimal diffs when extending a note: touch only what the topic requires, no
  rewording in passing, no reformatting of untouched sections.
- YAGNI: the simplest note that carries the point. No empty sections, no
  placeholders.
