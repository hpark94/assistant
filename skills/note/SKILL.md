---
name: note
description:
  "Distill one topic into a note in the Obsidian vault at ~/projects/vault.
  Triggers: the command /note or $note, or the German phrases 'merk dir das',
  'mach eine Notiz draus', 'das ist wichtig', 'halt das fest'. Never invoke this
  because the conversation produced something worth keeping."
---

# note

Turn one self contained topic into a note in `~/projects/vault/notes/`. This
file owns the whole Note and Hub operation, the archiving included, and assumes
`global.md`, which is loaded in every project, and nothing else.

Claude invokes this as `/note`, Codex as `$note`. Arguments, if any, name the
topic to capture.

## Four modes

On a topic this conversation already settled, capture what it produced. On one
it did not, find out first, then capture what you found. On a correction I
command to a note or a hub that already exists, correct it: there is nothing to
capture. On my command to archive a note, take it out of the knowledge.

The second is the ordinary one for a second brain: "what are the Linux commands
for the size of a directory, and make a note of it". Establish the answer to the
same standard you would give it in conversation, which means run the command
rather than recall it, and name every web source with its URL in the note. Never
write a note from memory alone. In this mode the preview from step 5 **is** the
answer: do not write the same thing twice, once as prose and once as a note.
Anything that does not belong in the note, an intermediate result or a source
that contradicts another, goes in one or two sentences next to the preview.

The third has no scope to find, because the note I name is the scope. Skip step
1, find it with step 2's search and enter its hit branch; where it does not
stand in `notes/`, say so and stop. The rest of the procedure stands as it is.
That branch also owns the answer where the command names a different hub or file
name, and its answer is the same whether I commanded the change or you noticed
it. A hub is found the same way, takes the Hub contract below and enters at
step 5.

The fourth writes no knowledge at all. Its procedure is Archiving at the end of
this file and not the one below.

## Checking a claim

Every claim a note makes is checked before its preview, under the Proof rules of
`global.md` whether or not I asked. What I have and can run is run, and a
command that already ran in this session counts where it is the command the note
records. Put **both the result and the exact command** into the note, under
`## Verified`. Where the Proof could write and can be isolated, the command has
to rebuild its own environment, because the note is read on a day when nothing
of this session is left. A Proof that only the live setup can answer carries the
exact command just the same and says that its result is recorded rather than
repeatable. A change to an existing note checks the claims it adds or rewords,
and names in one line the claims already there that carry no check.

An unverified claim goes into a `## Not verified` section: what was not shown,
and what stood in the way, because an unverified claim that says nothing about
its own gap reads like a checked one. The contract names three sections, this
one, `## Verified` and `## Related`, and nothing below the frontmatter besides
them is more than body.

A claim nothing I have can run, or what a standard or a specification defines,
is checked by a source read in full and cited on its sentence, and takes no
section. A standard or a specification needs no `verified`; a claim about the
state of the world takes the day its source was read as its check date. There is
no command to put in a section, and repeating the citation below the text would
be the collected list `global.md` rules out. A source attached to a claim that
can be run does not check it: where the command did not run, the claim stays in
`## Not verified`.

The two check sections are about claims and not about the note, so one that
proved one thing and could not prove another carries both. `verified` is the
oldest date of every claim in the note that can go stale, whether that date is
when a command ran or a source was read. The index asks for checks older than
six months, and a fresh one must not hide a stale one beside it.

## Procedure

1. **Scope.** The topic the arguments name, otherwise the last self contained
   topic, not the whole session. One note is one topic: arguments naming several
   get the split named and the one I confirm captured, and another topic this
   session produced and not yet named is named in one line.
2. **Search first, never write a duplicate.** Grep `~/projects/vault/notes/` for
   the topic, its tags, its likely hub and likely synonyms. Read any candidate
   before deciding. Grep `~/projects/vault/archive/` for the same terms: a hit
   there is not a hit, so say in one line that the topic was archived and go on
   with the new note. More than one that fits: put them up with their `summary`
   and wait, because picking one silently is how a vault grows two notes on one
   topic.
   - **On a hit**: extend that note and bump `updated`. A correction of what
     already stands, noticed or commanded beside a capture, goes up as its own
     approval unit. Never delete existing content silently, and say afterwards
     what changed. Its hub is the one thing you never correct: if the note
     belongs under a different one, say so in one line, name that hub, and leave
     the move to me in Obsidian. It is one line and not a question, and it may
     fall again in a later session, because nothing records that it was already
     said. The title you do correct, in `title` and in the `# H1` together. If
     the file name then no longer is its slug, or my command named another file
     name, say in one line what it should be called and leave the rename to me.
     Archiving moves a note with `mv` and keeps its name, which is another act
     and stands under Archiving below.
   - **On no hit**: create a new note.
3. **Pick the hub.** Every note belongs to exactly one hub, named in `hub`. If
   an existing hub fits, use it; where more than one does, put them up and wait.
   If none fits, pick a name and let the preview carry it: it shows the same
   name in the file name, in the title and in `hub`, which is more than a
   question would. A hub name is expensive, it is a prefix of every child's file
   name, so renaming it later renames files. Say in one line that the hub is
   new, so it is not mistaken for an existing one.
4. **Name the file.** An ASCII slug is the text lowercased, every run of
   characters outside `[a-z0-9]` collapsed into one hyphen, and leading and
   trailing hyphens dropped; an umlaut keeps its vowel, `ae oe ue ss`. A title
   begins with its hub's title and a colon, `Disk Management: Memory Usage`
   under the hub `Disk Management`, and the file is that title as such a slug,
   `disk-management-memory-usage.md`. The hub carries the context, so keep the
   rest of the title short: `Virtualization: Docker libvirt NAT`, not
   `Virtualization: Docker Breaks libvirt VM NAT`. `ffd` matches paths and file
   names, never frontmatter, which is why the two agree. A title corrected on an
   existing note suspends that agreement until I do the rename from step 2, so
   the mismatch is the cheaper of the two and it is stated rather than repaired.
   A new file, a note, a hub or an image copy, never takes a name that already
   stands in the vault,
   `find ~/projects/vault -path ~/projects/vault/.trash -prune -o -name '<file name>' -print`:
   say so and stop before the preview, for a note or a hub with another title in
   one line. A file with the same bytes already in `notes/assets/`, `cmp -s`, is
   embedded as it is.
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
   bad += [f"{k} is not allowed on a note" for k in ("status","project","superseded_by","depends_on","archived","session","agent") if k in f]
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

   **On a change to an existing file show only the changed passages**, never the
   whole file: the point of a minimal diff is that the change is visible. The
   check above still runs on the whole file as it will land, only the display is
   narrowed; `updated` moves on every such change to a note, so the frontmatter
   changes and wants checking. Run `prettier --check` on the target file before
   you build the change. If it fails, the `prettier -w` in step 7 will reformat
   passages your topic never touched, so put that formatting change up as a
   second passage of its own and let me approve it separately. That passage is
   its own approval unit, so a no to it stops the reformat and nothing else. A
   reformat never rides along unseen on a content change. Refused, the file
   keeps its old bytes and takes the approved passage as shown. There what lands
   is not byte for byte what the check ran on; its verdict still holds, because
   prettier folds lines and never changes a value, so the frontmatter it reads
   is the same either way.

6. **Write.** A Note, the new Hub it needs and the images it embeds are one
   approval unit: one preview and one yes. After the OK write the approved
   content directly to its absolute path under `~/projects/vault/notes/`, all in
   the same step. An image I passed by path is copied under its own file name
   with
   `mkdir -p ~/projects/vault/notes/assets && cp --update=none <path> ~/projects/vault/notes/assets/`
   and embedded as `![[<file name>]]`, and the preview names the path the copy
   gets. Never write anywhere else.
7. **Format.** `prettier -w` on every Markdown file you touched, no flags, once
   the file sits in the vault. Prettier reads the `.prettierrc` next to the
   file, so formatting a copy elsewhere silently loses `proseWrap: always`. A
   formatting passage I refused in step 5 is the one exception: that file is
   written and not reformatted, so what I kept stays as it was.
8. **Report.** One or two sentences: which file, created or extended, under
   which hub, and what changed if it was an extension. A corrected title puts
   the name the file should get here, as the one line from step 2.

**A capture never edits `index.md` and never edits a hub's list.** Both are
Dataview queries over what the notes declare about themselves.

## Note contract

```markdown
---
title: "Disk Management: Memory Usage"
type: note
hub: "[[disk-management]]"
summary: du and df, and why the two disagree.
tags: [linux, disk, cli]
created: 2026-08-13
updated: 2026-08-13
verified: 2026-08-13
---

# Disk Management: Memory Usage

`du -sh ~/repos` sizes the tree. `df -h ~/repos` measures the file system the
tree sits on and therefore disagrees.

## Verified

`du -sh ~/repos` gave `2.9G /home/hpark/repos`, `df -h ~/repos` gave
`/dev/nvme0n1p8 664G 156G 475G 25% /`.

## Related

- [[disk-management-inode-usage]]
```

- `title` needs quotes because of the colon. This holds for **every** value: an
  unquoted scalar containing `: ` is read as a mapping and breaks the whole
  frontmatter, which Obsidian then reports as invalid properties. Either quote
  the value or write the line without a colon.
- `type` is `note`, nothing else. A Hub is a distinct file type with its own
  contract below. What a Note is about is carried by its Hub and its tags, not
  by a category. A tag is a handle the hub and the title do not already give,
  and a note that has none carries no `tags`.
- `hub` names the one hub, written as a quoted link. Obsidian indexes links in
  properties as real links, which is what makes the hub's list and its backlinks
  work. Exactly one, never a list.
- `summary` is one line, written to be read in a list next to nine others. It
  appears in the hub, in the index and in the fzf preview, and exists only here.
  Keep it under about 70 characters: `prettier` folds a longer value onto a
  second line, which is valid YAML but noise in the preview.
- `verified` appears only on notes with a claim that can go stale, and carries
  the oldest check as defined above. A feasibility claim goes stale when a tool
  updates, and `updated` only says when its content last changed. `## Verified`
  appears only where a command ran; the field stands without the section where a
  source was read instead.
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
prescribes, and never adds the field. Its report names the hub and what changed,
because step 8 is written for a note and a corrected hub is neither created nor
extended under one. A corrected hub title changes the hub alone and breaks the
agreement above: say in one line what the hub file and every child's title and
file should be called. Each child is its own correction, and the renames are
mine.

## Archiving

Archiving takes a note that no longer belongs in the knowledge out of `notes/`.
`global.md` settles that it happens only on my command; the whole of it is one
approval unit, one preview and one yes.

1. **Find the note** with the Procedure's step 2 search, **read it whole** and
   run `prettier --check` on it. The body is not touched. Where
   `~/projects/vault/archive/<name>.md` already exists, stop here and say so,
   because the `mv -n` of step 5 would otherwise block on a note whose `hub`
   step 4 has already unbracketed.
2. **Change the frontmatter.** `hub` loses its brackets and becomes the hub's
   slug as a plain string, and `archived` is added with today's date. `type`
   stays `note` and `tags` stay as they are, because the file records what it
   was and how it was filed. `updated` does not move: the content did not
   change, and `archived` carries the day it left.
3. **Check it** on the whole file as it will land, then put up the path it moves
   to and the frontmatter lines that change:

   ```sh
   prettier --stdin-filepath ~/projects/vault/archive/<name>.md <<'EOF' \
     | python3 -c '
   import sys, yaml, re, datetime
   t = sys.stdin.read(); sys.stdout.write(t)
   m = re.match(r"---\n(.*?)\n---\n", t, re.S) or sys.exit("no frontmatter")
   try: f = yaml.safe_load(m.group(1))
   except (yaml.YAMLError, ValueError) as e: sys.exit(f"frontmatter: {e}")
   isinstance(f, dict) or sys.exit("frontmatter: not a mapping")
   d = lambda k: type(f.get(k)) is datetime.date
   bad  = [f"missing {k}" for k in ("title","type","hub","summary","created","updated","archived") if k not in f]
   bad += ["type must be note"] * (f.get("type") != "note")
   bad += [f"{k} must be a string" for k in ("title","summary") if not isinstance(f.get(k), str)]
   bad += ["hub must be the hub slug unlinked, [a-z0-9-]+ and no brackets"] * (not isinstance(f.get("hub"), str) or not re.fullmatch(r"[a-z0-9-]+", str(f.get("hub"))))
   bad += ["tags must be a list"] * (not isinstance(f.get("tags", []), list))
   bad += [f"{k} is not allowed on a note" for k in ("status","project","superseded_by","depends_on","session","agent") if k in f]
   bad += [f"{k} must be YYYY-MM-DD" for k in ("created","updated","archived") if not d(k)]
   bad += ["verified must be YYYY-MM-DD"] * ("verified" in f and not d("verified"))
   sys.exit("frontmatter: " + "; ".join(bad) if bad else 0)
   '
   <the whole note, frontmatter and body>
   EOF
   ```

   A bracketed `hub` would keep raising its hub's inlink count in the index and
   keep the note in Obsidian's own backlinks panel, which no query scoping
   reaches.

4. **Write.** After the OK, write the changed frontmatter at the note's own path
   in `notes/`.
5. **Format, then move.** `prettier -w` at that path, unless the
   `prettier --check` of step 1 failed: then the file is not reformatted and the
   report says it is still unformatted, because a reformat here would rewrite a
   body this operation never touched. Then
   `mv -n ~/projects/vault/notes/<name>.md ~/projects/vault/archive/`. The file
   name never changes, so no incoming link has to be rewritten. `-n` because a
   sync from another device can still put that name in `archive/` after step 1
   looked. `mv -n` refuses silently and exits 0, so the stop is seen by the
   source still being there: where it is, say that the note is half archived
   with its `hub` already unbracketed, and leave it where it is.
6. **Report.** One or two sentences: which note, out of which hub, on which
   date. Name every note that still links to it,
   `rg -l '\[\[<name>(\]\]|\|)' ~/projects/vault/notes/`, because a reader
   following one lands in the archive without being told the note left the
   knowledge. Where it was its hub's last child, say so in one line and leave
   the hub to me.

**Archiving never edits `index.md` and never edits the hub's list.** The move
alone takes the note out of both, which are queries scoped `FROM "notes"`.
