---
name: note
description:
  "Distill one topic into a note in the Obsidian vault at ~/projects/vault.
  Triggers, and nothing else: the command /note or $note, or the German phrases
  'merk dir das', 'mach eine Notiz draus', 'das ist wichtig', 'halt das fest'."
---

# note

Turn one self contained topic into a note in `~/projects/vault/notes/`. This
file owns the whole Note and Hub operation and assumes `global.md`, which is
loaded in every project, and nothing else.

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
nothing unless it was checked. Prove it the way `global.md` prescribes, then put
**both the result and the exact command** into the note, under `## Verified`
with a `verified` date. The command has to rebuild its own environment, because
the note is read on a day when nothing of this session is left.

An unverified claim goes into a `## Not verified` section: what was not shown,
and what stood in the way. It is the only other section the contract names,
because an unverified claim that says nothing about its own gap reads like a
checked one.

Both sections are about claims and not about the note, so one that proved one
thing and could not prove another carries both. `verified` is then the date of
the proof it does hold: without it the note keeps no date for the claim that can
go stale, which is the only thing the field is for. Several proofs make it the
oldest of them: the index asks for proofs older than six months, and a fresh
check on one claim must not hide a stale one beside it.

## Procedure

1. **Scope.** Identify the last self contained topic, not the whole session. If
   arguments name a topic, they win. One note is one topic; if two unrelated
   things are worth keeping, write two notes, each with its own preview and yes.
2. **Search first, never write a duplicate.** Grep `~/projects/vault/notes/` for
   the topic, its tags, its likely hub and likely synonyms. Read any candidate
   before deciding. More than one that fits: put them up with their `summary`
   and wait, because picking one silently is how a vault grows two notes on one
   topic.
   - **On a hit**: extend that note, correct what is now wrong, bump `updated`.
     Never delete existing content silently, and say afterwards what changed.
     Its hub is the one thing you never correct: if the content you are adding
     would have gone under a different hub as a new note, say so in one line,
     name that hub, and leave the move to me in Obsidian. It is one line and not
     a question, and it may fall again in a later session, because nothing
     records that it was already said. The title you do correct, in `title` and
     in the `# H1` together, and the file name then no longer is its slug: say
     in one line what the file should be called, and leave the rename to me.
     Never offer and never run `mv` on a note: renaming in Obsidian carries the
     incoming wiki links along, `mv` leaves them pointing nowhere on four
     devices.
   - **On no hit**: create a new note.
3. **Pick the hub.** Every note belongs to exactly one hub, named in `hub`. If
   an existing hub fits, use it. If none fits, pick a name and let the preview
   carry it: it shows the same name in the file name, in the title and in `hub`,
   which is more than a question would. A hub name is expensive, it is a prefix
   of every child's file name, so renaming it later renames files. Say in one
   line that the hub is new, so it is not mistaken for an existing one.
4. **Name the file.** `<hub-slug>-<short-name>.md`, the title as an ASCII slug:
   `disk-management-memory-usage.md` with the title
   `Disk Management: Memory Usage`. The hub carries the context, so keep the
   title itself short and the file name follows:
   `Virtualization: Docker libvirt NAT`, not
   `Virtualization: Docker Breaks libvirt VM NAT`. `ffd` matches paths and file
   names, never frontmatter, which is why the two agree. A title corrected on an
   existing note suspends that agreement until I do the rename from step 2: `mv`
   is what would break the incoming links, so the mismatch is the cheaper of the
   two and it is stated rather than repaired.
5. **Show it, then wait.** Build the whole Note and, if its Hub is new, the
   whole Hub. Run every file through prettier and its matching frontmatter
   check, then put every result up with the path it would get. The command
   formats and checks, it does not show: its output is a tool result that stays
   folded up in the transcript, so a preview I have to unfold is no preview.
   Copy that output into the answer itself, one fenced block per file under the
   path it would get. Nothing is on disk at this point, and nothing is written
   until I say so.

   For a Note:

   ```sh
   prettier --stdin-filepath ~/projects/vault/notes/<name>.md <<'EOF' \
     | python3 -c '
   import sys, yaml, re, datetime
   t = sys.stdin.read(); sys.stdout.write(t)
   m = re.match(r"---\n(.*?)\n---\n", t, re.S) or sys.exit("no frontmatter")
   try: f = yaml.safe_load(m.group(1))
   except (yaml.YAMLError, ValueError) as e: sys.exit(f"frontmatter: {e}")
   isinstance(f, dict) or sys.exit("frontmatter: not a mapping")
   d = lambda k: type(f.get(k)) is datetime.date
   bad  = [f"missing {k}" for k in ("title","type","hub","summary","created","updated") if k not in f]
   bad += ["type must be note"] * (f.get("type") != "note")
   bad += [f"{k} must be a string" for k in ("title","summary") if not isinstance(f.get(k), str)]
   bad += ["hub must be a quoted \"[[hub]]\", the hub's slug and nothing else"] * (not isinstance(f.get("hub"), str) or not re.fullmatch(r"\[\[[a-z0-9-]+\]\]", str(f.get("hub"))))
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
   except (yaml.YAMLError, ValueError) as e: sys.exit(f"frontmatter: {e}")
   isinstance(f, dict) or sys.exit("frontmatter: not a mapping")
   bad  = [f"missing {k}" for k in ("title","type","summary","created") if k not in f]
   bad += ["type must be hub"] * (f.get("type") != "hub")
   bad += [f"{k} must be a string" for k in ("title","summary") if not isinstance(f.get(k), str)]
   bad += [f"{k} is not allowed on a hub" for k in ("hub","tags","updated") if k in f]
   bad += ["created must be YYYY-MM-DD"] * (type(f.get("created")) is not datetime.date)
   sys.exit("frontmatter: " + "; ".join(bad) if bad else 0)
   '
   <the whole hub, frontmatter and dataview block>
   EOF
   ```

   `--stdin-filepath` resolves the vault's `.prettierrc` from that path even
   though the file does not exist yet, so what I read is byte for byte what
   lands. The check passes prettier's output through unchanged, so what gets
   validated is exactly the text you show and later write. The content rides in
   the heredoc, so nothing of it reaches the vault: nothing is on disk there
   before the OK. The delimiter must not occur in the content: a note that
   itself contains a line `EOF` needs `<<'NOTE'` or any other word that does
   not.

   A frontmatter that merely parses is not enough: `hub: [[disk-management]]`
   without quotes parses silently into a list and is no link in Obsidian, which
   is why the values are checked too. On a failure repair the frontmatter and
   run it again; never show a preview that did not pass.

   The date check is `type(...) is datetime.date` and not `isinstance`: PyYAML
   reads `2026-08-16 10:00:00` as a `datetime.datetime`, which is a subclass of
   `date` and would pass an `isinstance` check despite not being `YYYY-MM-DD`.

   **On an extension show only the changed passages**, never the whole file: the
   point of a minimal diff is that the change is visible. The check above still
   runs on the whole file as it will land, only the display is narrowed;
   `updated` moves on every extension, so the frontmatter changes and wants
   checking. Run `prettier --check` on the target file before you build the
   extension. If it fails, the `prettier -w` in step 7 will reformat passages
   your topic never touched, so put that formatting change up as a second
   passage of its own and let me approve it separately. A reformat never rides
   along unseen on a content change. Refused, the file keeps its old bytes and
   takes the approved passage as shown. That is the one place where what lands
   is not byte for byte what the check ran on; its verdict still holds, because
   prettier folds lines and never changes a value, so the frontmatter it reads
   is the same either way.

6. **Write.** A Note and the new Hub it needs are one approval unit: two files,
   one preview and one yes. After the OK write the approved content directly to
   its absolute path under `~/projects/vault/notes/`, both files in the same
   step. Never write anywhere else.
7. **Format.** `prettier -w` on every file you touched, no flags, once the file
   sits in the vault. Prettier reads the `.prettierrc` next to the file, so
   formatting a copy elsewhere silently loses `proseWrap: always`. A formatting
   passage I refused in step 5 is the one exception: that file is written and
   not reformatted, so what I kept stays as it was.
8. **Report.** One or two sentences: which file, created or extended, under
   which hub, and what changed if it was an extension. A corrected title puts
   the name the file should get here, as the one line from step 2.

**A capture never edits `index.md` and never edits a hub's list.** Both are
Dataview queries over what the notes declare about themselves. Adding a line by
hand there creates a second truth that immediately drifts.

## Note contract

```markdown
---
title: "Disk Management: Memory Usage"
type: note
hub: "[[disk-management]]"
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
- `hub` names the one hub, written as a quoted link. Obsidian indexes links in
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
`second-brain.md` for `Second Brain`. That slug is what `hub` links to and what
every child's file name starts with.

Hubs have no `hub`, no tags and no prose, and their `summary` is one line under
about 70 characters like a note's. Create one only together with its first
child, so that no `hub` link ever points at a file that does not exist.

A hub has no `updated` either. No capture ever edits an existing hub, and a
correction on my command is rare enough that the field would repeat `created`
for months at a time. A date that cannot move is worse than no date: it looks
like an answer to "when did this subject last change", which the children's
`updated` in the hub's own list already gives. Such a correction runs the hub
check above like any other write, shows the changed passages the way step 5
prescribes, and never adds the field.
