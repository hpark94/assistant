---
name: draft
description:
  "Capture a brainstorm about a project as a draft in Hyeong-Gyu's Obsidian
  vault at ~/projects/vault/drafts/, and pick up the open drafts of the project
  you are working in with --open. Triggers, and nothing else: the command /draft
  or $draft. Never invoke this because the conversation mentions a draft, an
  outline, a sketch or a brainstorm."
disable-model-invocation: true
---

# draft

A draft is thinking about one project, written down while it is still
unfinished. It lives in `~/projects/vault/drafts/`, it is not knowledge, and it
is not a note. This file is the complete contract: it must work in projects
whose `AGENTS.md` you have never seen.

Writing to the vault happens only on command, never on your own initiative, and
nothing goes into the vault before he has seen it.

## Two modes

| Invocation      | What it does                                                    |
| --------------- | --------------------------------------------------------------- |
| bare, `/draft`  | Turn this conversation into a draft for the project it is about |
| `/draft --open` | List the open drafts of the current project and pick one up     |

Either form takes the project as an argument, `/draft --open dots` and
`/draft dots: <subject>`, where the colon separates the project from the
subject. Without a colon the whole argument is the subject. The argument beats
the working directory, and it is what makes both forms usable from a
subdirectory of the project.

## Where drafts live

`~/projects/vault/drafts/<project>-<topic>.md`, a sibling of `notes/`, never
inside it. Every hub and knowledge query is scoped `FROM "notes"`, so a draft is
invisible to them. Only the index's dedicated open-drafts block queries
`drafts/`, which is the point: unfinished thinking never appears as knowledge.

`<project>` is the directory name of the project, `routing-lab` for
`~/repos/routing-lab`, so that `ffd routing` and `rg 'project: routing-lab'`
find the same set. It is `[a-z0-9-]+` and nothing else, which is what keeps the
lookup below correct: it anchors the name in a regular expression and passes the
paths through `xargs`, so a dot in the name would match a second project and a
space would split one path into two.

## Draft contract

```markdown
---
title: "Routing Lab: OSPF Metrics"
type: draft
project: routing-lab
summary: Why the cost formula disagrees with the lab handout.
status: todo
created: 2026-08-13
updated: 2026-08-13
---

# Routing Lab: OSPF Metrics

Whatever the brainstorm produced.
```

- `title` needs quotes because of the colon, and so does **every** value
  containing `: `. An unquoted scalar with a colon in it is read as a mapping
  and breaks the whole frontmatter, which Obsidian reports as invalid
  properties.
- `type` is `draft`. It stays even though the folder already says so: if the
  file ever moves to `notes/`, this is where you see what it was.
- `project` is the directory name. It comes from the argument where his
  invocation named one, otherwise from the conversation, and it is never asked
  for. It is visible in the preview and in the file name, so correcting it costs
  one word.
- `summary` is one line under about 70 characters, read in a list next to the
  others. `prettier` folds a longer value onto a second line, which is valid
  YAML but noise in the fzf preview.
- `status` is one of the five below, and a new draft gets `todo` unless his
  command names another. It stands in the preview, so correcting it costs one
  word, and a draft that stays listed as open too long is the cheap error where
  a `done` that is not one would be the expensive one.

  | Value        | Meaning                                     |
  | ------------ | ------------------------------------------- |
  | `todo`       | written down, not worked on                 |
  | `wip`        | being worked on                             |
  | `done`       | carried out, or what mattered became a note |
  | `superseded` | replaced, `superseded_by` says by what      |
  | `dropped`    | considered and rejected                     |

- `superseded_by: "[[routing-lab-ospf-metrics-v2]]"` exists only on a
  `superseded` draft. A link in a property is a real link, so the newer draft
  gets a backlink and its history is visible from there.
- `depends_on: ["[[routing-lab-ospf-metrics]]"]` names the drafts that must be
  carried out first. It is always a list, even with one entry, and every value
  is a quoted wiki link, so the blocking draft gets a backlink. It exists only
  where the order is real: the later draft's decision cannot be made until the
  earlier one is. A session that produces several drafts records the order here,
  because otherwise it lives only in that conversation and is gone with it.
- A `dropped` draft is **not** deleted. The vault has no version control, so a
  deleted file is gone on every device, and "we considered this and rejected it"
  is exactly what cannot be reconstructed later.
- No `tags`, no `topic`, no hub.

Below the frontmatter only the `# Title` is required. Write the sections the
conversation actually produced, no fixed skeleton, no empty headings. If the
conversation says what should happen next, write it down; a `todo` whose next
step is nowhere in the file is an empty claim.

## Writing a draft

1. **Scope.** One draft is one subject in one project. If arguments name a
   subject, they win. A session that produces several drafts writes each one on
   its own and shows them in dependency order, with `depends_on` set where one
   must be carried out before another.
2. **Search first.** Grep `~/projects/vault/drafts/` for the project and the
   subject. On a hit, extend that draft and bump `updated` instead of writing a
   second one. If the new thinking contradicts what that draft decided, say so
   and offer to replace it; never fold both decisions into one file silently.
   Replacing it is `superseded` and happens only on his word, because a
   successor is a second file and a status he did not ask for. The successor is
   the old name plus `-v2`, then `-v3`: a supersede is by definition the same
   subject, otherwise it would be a new draft, so only the counter moves. That
   is the one exception to the duplicate rule, and it keeps the chain together
   under `ffd` and `rg`.
3. **Show it, then wait.** Build the whole file and put it up with the path it
   would get, formatted exactly as it will land:

   ```sh
   prettier --stdin-filepath ~/projects/vault/drafts/<name>.md <<'EOF' \
     | python3 -c '
   import sys, yaml, re, datetime
   t = sys.stdin.read(); sys.stdout.write(t)
   m = re.match(r"---\n(.*?)\n---\n", t, re.S) or sys.exit("no frontmatter")
   try: f = yaml.safe_load(m.group(1))
   except yaml.YAMLError as e: sys.exit(f"frontmatter: {e}")
   bad  = [f"missing {k}" for k in ("title","type","project","summary","status","created","updated") if k not in f]
   bad += ["type must be draft"] * (f.get("type") != "draft")
   bad += [f"{k} must be a string" for k in ("title","summary","project") if not isinstance(f.get(k), str)]
   bad += ["status must be todo|wip|done|superseded|dropped"] * (f.get("status") not in ("todo","wip","done","superseded","dropped"))
   s = f.get("superseded_by")
   bad += ["superseded_by must be a quoted \"[[draft]]\" when status is superseded"] * (f.get("status") == "superseded" and (not isinstance(s, str) or not re.fullmatch(r"\[\[[^]]+\]\]", s)))
   bad += ["superseded_by exists only when status is superseded"] * (f.get("status") != "superseded" and "superseded_by" in f)
   d = f.get("depends_on")
   bad += ["depends_on must be a non-empty list of quoted \"[[draft]]\" links"] * ("depends_on" in f and (not isinstance(d, list) or not d or not all(isinstance(x, str) and re.fullmatch(r"\[\[[^]]+\]\]", x) for x in d)))
   bad += [f"{k} is not allowed on a draft" for k in ("tags","topic","hub") if k in f]
   bad += [f"{k} must be YYYY-MM-DD" for k in ("created","updated") if type(f.get(k)) is not datetime.date]
   sys.exit("frontmatter: " + "; ".join(bad) if bad else 0)
   '
   <the whole draft, frontmatter and body>
   EOF
   ```

   `--stdin-filepath` resolves the vault's `.prettierrc` from that path even
   though the file does not exist yet. The check passes prettier's output
   through unchanged, so what gets validated is exactly the text you show and
   later write. The content rides in the heredoc, so no temporary file exists
   either: nothing is on disk before the OK. The delimiter must not occur in the
   content: a draft that itself contains a line `EOF` needs `<<'DRAFT'` or any
   other word that does not.

   A frontmatter that merely parses is not enough: `status: open` is valid YAML
   and still outside the table, and no query would ever see that draft, which is
   why the values are checked too. On a failure repair the frontmatter and run
   it again; never show a preview that did not pass.

   The date check is `type(...) is datetime.date` and not `isinstance`: PyYAML
   reads `2026-08-16 10:00:00` as a `datetime.datetime`, which is a subclass of
   `date` and would pass an `isinstance` check despite not being `YYYY-MM-DD`.

   Nothing is on disk until he says yes; on an extension show only the changed
   passages. Run `prettier --check` on the target file before you build the
   extension. If it fails, the `prettier -w` in step 5 will reformat passages
   your subject never touched, so put that formatting change up as a second
   passage of its own and let him approve it separately. A reformat never rides
   along unseen on a content change.

   **Only an explicit command writes a status.** A remark that something is now
   carried out states a fact and authorises nothing. You may offer the change
   once, in a single line, and never bring it up a second time.

   **A change to `status` alone needs no preview.** His command already names
   the whole change, "set the draft to done", so there is nothing left for him
   to see and asking again only costs him a second yes. Run the frontmatter
   check, write, and report the new status. The exception ends where the diff
   does: `updated` may ride along, anything else, a line of body text or the
   `superseded_by` that a `superseded` requires, is a normal change and gets its
   preview.

   **A supersede is one approval unit.** It touches two files, the new successor
   and the predecessor's frontmatter, but it is one decision and gets one
   preview and one yes: the whole successor first, then the predecessor's
   changed lines. Its `status` moves together with `superseded_by`, so it is
   never covered by the status-only exception above.

4. **Write.** Write the approved content directly to its absolute path under
   `~/projects/vault/drafts/`. Never write anywhere else. On a supersede write
   the successor first: a `superseded_by` pointing at a file that does not exist
   is the broken half, while a successor whose predecessor is not yet marked is
   only untidy.
5. **Format.** `prettier -w` on the file, once it sits in the vault.
6. **Report.** One or two sentences: which file, created or extended, for which
   project, at which status.

**Never edit `index.md`.** Its list of open drafts is a Dataview query over
`status`, and a line added by hand there is a second truth that drifts.

## Picking one up: `--open`

Run this in the project you are working in, not here.

1. **Find.** The project is the argument where one was given, otherwise the
   directory name of the working directory. Name the project you searched for in
   your answer: from a subdirectory the directory name is not the project, and a
   wrong one has to be visible rather than silent. List the drafts whose
   `project` matches and whose `status` is `todo` or `wip`:

   ```sh
   rg -l '^project: <project>$' ~/projects/vault/drafts/ | xargs -r rg -l '^status: (todo|wip)$'
   ```

   `-r` is not decoration: without it an empty first result leaves the second
   `rg` with no path, it searches the working directory instead, and a project
   file carrying `status: todo` is reported as an open draft.

   If nothing matches the directory name, say so and offer the open drafts of
   all projects rather than guessing.

2. **Choose.** More than one hit: put them up with `summary` and `status` and
   wait. A draft whose `depends_on` still points at a `todo` or `wip` draft is
   blocked, so say that with it instead of offering it as an equal choice.
   Exactly one: name it and go on.
3. **Read it whole**, on disk with Read. It is a draft, not an order: it may
   contain options that were never decided and thinking that the code has since
   overtaken.
4. **Say what you understood.** Three sentences: what the draft wants, what of
   it is already in the code, and where it contradicts what you see.
5. **Ask how to proceed**, and do nothing until answered. Carry it out, plan it
   first, or keep it in context as a reference. Ask in the same breath whether
   `status` should go to `wip`.
6. **Never set `done` on your own.** Whether something is finished is his call,
   and a status change is a vault write like any other: only on command. On his
   command it is written straight away, under the status-only exception in step
   3, with the frontmatter check but without a preview.

## Style

- Drafts are English, even though we speak German.
- No em dashes. Use commas, periods, semicolons, colons.
- Minimal diffs when extending a draft: touch only what the subject requires.
- YAGNI: the simplest draft that carries the thought. No empty sections, no
  placeholders.
