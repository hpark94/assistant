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

## Where drafts live

`~/projects/vault/drafts/<project>-<topic>.md`, a sibling of `notes/`, never
inside it. Every hub query and every index block is scoped `FROM "notes"`, so a
draft is invisible to all of them, which is the point: it is unfinished.

`<project>` is the directory name of the project, `routing-lab` for
`~/repos/routing-lab`, so that `ffd routing` and `rg 'project: routing-lab'`
find the same set.

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
- `project` is the directory name, and it is derived from the conversation, not
  asked for. It is visible in the preview and in the file name, so correcting it
  costs one word.
- `summary` is one line under about 70 characters, read in a list next to the
  others. `prettier` folds a longer value onto a second line, which is valid
  YAML but noise in the fzf preview.
- `status` is one of:

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
- A `dropped` draft is **not** deleted. The vault has no version control, so a
  deleted file is gone on every device, and "we considered this and rejected it"
  is exactly what cannot be reconstructed later.
- No `tags`, no `topic`, no hub: drafts are outside `notes/` and no query sees
  them.

Below the frontmatter only the `# Title` is required. Write the sections the
conversation actually produced, no fixed skeleton, no empty headings. If the
conversation says what should happen next, write it down; a `todo` whose next
step is nowhere in the file is an empty claim.

## Writing a draft

1. **Scope.** One draft is one subject in one project. If arguments name a
   subject, they win.
2. **Search first.** Grep `~/projects/vault/drafts/` for the project and the
   subject. On a hit, extend that draft and bump `updated` instead of writing a
   second one; if the thinking replaced the old one, that is `superseded`, not a
   silent overwrite.
3. **Show it, then wait.** Build the whole file and put it up with the path it
   would get, formatted exactly as it will land:

   ```sh
   prettier --stdin-filepath ~/projects/vault/drafts/<name>.md < draft \
     | python3 -c '
   import sys, yaml, re, datetime
   t = sys.stdin.read(); sys.stdout.write(t)
   m = re.match(r"---\n(.*?)\n---\n", t, re.S) or sys.exit("no frontmatter")
   try: f = yaml.safe_load(m.group(1))
   except yaml.YAMLError as e: sys.exit(f"frontmatter: {e}")
   bad  = [f"missing {k}" for k in ("title","type","project","summary","status","created","updated") if k not in f]
   bad += [f"{k} must be a quoted string" for k in ("title","summary","project") if not isinstance(f.get(k), str)]
   bad += ["status must be todo|wip|done|superseded|dropped"] * (f.get("status") not in ("todo","wip","done","superseded","dropped"))
   bad += [f"{k} must be YYYY-MM-DD" for k in ("created","updated") if not isinstance(f.get(k), datetime.date)]
   sys.exit("frontmatter: " + "; ".join(bad) if bad else 0)
   '
   ```

   `--stdin-filepath` resolves the vault's `.prettierrc` from that path even
   though the file does not exist yet. The check passes prettier's output
   through unchanged, so what gets validated is exactly the text you show and
   later write.

   A frontmatter that merely parses is not enough: `status: open` is valid YAML
   and still outside the table, and no query would ever see that draft, which is
   why the values are checked too. On a failure repair the frontmatter and run
   it again; never show a preview that did not pass.

   Nothing is on disk until he says yes; on an extension show only the changed
   passages.

4. **Write.** Through the Obsidian MCP (`mcp__obsidian__vault_write`), so paths
   stay vault relative and Obsidian sees the write. Those tools are bound at
   session start; if they are absent here, write the file on disk and say so
   instead of implying the write went through the vault API.
5. **Format.** `prettier -w` on the file, once it sits in the vault.
6. **Report.** One or two sentences: which file, created or extended, for which
   project, at which status.

**Never edit `index.md`.** Its list of open drafts is a Dataview query over
`status`, and a line added by hand there is a second truth that drifts.

## Picking one up: `--open`

Run this in the project you are working in, not here.

1. **Find.** The project is the directory name of the working directory. List
   the drafts whose `project` matches and whose `status` is `todo` or `wip`:

   ```sh
   rg -l '^project: <project>$' ~/projects/vault/drafts/ | xargs rg -l '^status: (todo|wip)$'
   ```

   If nothing matches the directory name, say so and offer the open drafts of
   all projects rather than guessing.

2. **Choose.** More than one hit: put them up with `summary` and `status` and
   wait. Exactly one: name it and go on.
3. **Read it whole**, on disk with Read. It is a draft, not an order: it may
   contain options that were never decided and thinking that the code has since
   overtaken.
4. **Say what you understood.** Three sentences: what the draft wants, what of
   it is already in the code, and where it contradicts what you see.
5. **Ask how to proceed**, and do nothing until answered. Carry it out, plan it
   first, or keep it in context as a reference. Ask in the same breath whether
   `status` should go to `wip`.
6. **Never set `done` on your own.** Whether something is finished is his call,
   and a status change is a vault write like any other: only on command, and the
   preview rule applies to it too, frontmatter check included.

## Style

- Drafts are English, even though we speak German.
- No em dashes. Use commas, periods, semicolons, colons.
- Minimal diffs when extending a draft: touch only what the subject requires.
- YAGNI: the simplest draft that carries the thought. No empty sections, no
  placeholders.
