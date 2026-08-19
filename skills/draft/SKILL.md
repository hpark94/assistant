---
name: draft
description:
  "Write down a brainstorm about a project as a draft in the Obsidian vault at
  ~/projects/vault/drafts/, and pick up the open drafts of the project you are
  working in with --open. Triggers, and nothing else: the command /draft or
  $draft. Never invoke this because the conversation mentions a draft, an
  outline, a sketch or a brainstorm."
---

# draft

A draft is thinking about one project, written down while it is still
unfinished. It lives in `~/projects/vault/drafts/`, it is not knowledge, and it
is not a note. This file owns the whole Draft operation and its lifecycle, and
assumes `global.md`, which is loaded in every project, and nothing else.

**This skill never grills.** Sharpening the thinking is a separate interview on
its own trigger, and it ends by offering the `entwurfswuerdig` line that brings
me here. By the time `/draft` runs, the thinking is as sharp as it is going to
get: write it down, do not reopen it. What is still undecided is content for the
draft, not a reason to start an interview.

## Two modes

| Invocation      | What it does                                                    |
| --------------- | --------------------------------------------------------------- |
| bare, `/draft`  | Turn this conversation into a draft for the project it is about |
| `/draft --open` | List the open drafts of the current project and pick one up     |

Either form takes the project as an argument, `/draft --open dots` and
`/draft dots: <subject>`, and the two read it differently. In `--open` the
argument is the project and nothing else. In the bare form a colon separates the
project from the subject, and without a colon the whole argument is the subject.
The argument beats the working directory, and it is what makes both forms usable
from a subdirectory of the project.

## Where drafts live

`~/projects/vault/drafts/<project>-<topic>.md`, a sibling of `notes/`, never
inside it. Every hub and knowledge query is scoped `FROM "notes"`, so a draft is
invisible to them. Only the index's dedicated open-drafts block queries
`drafts/` by name, which is the point: unfinished thinking never appears as
knowledge. Its sync-conflict block is scoped to nothing at all and does see
them, which is what a hunt for conflicted copies is for.

`<project>` is the directory name of the project, `routing-lab` for
`~/repos/routing-lab`, so that the same string names it on disk and finds its
drafts with `rg 'project: routing-lab'` in the vault. It is `[a-z0-9-]+` and
nothing else, which is what keeps the lookup below correct: it anchors the name
in a regular expression and passes the paths through `xargs`, so a dot in the
name would match a second project and a space would split one path into two.

`<topic>` is a short ASCII slug of the subject and, unlike a note's file name,
not the slug of the title: a `-v2` successor keeps the title of the draft it
replaces, so the two cannot be tied together. Keep it short enough to type in
`ffd` and close enough to the title to be recognised there.

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
- `project` is the directory name. It comes from the argument where my
  invocation named one, otherwise from the working directory, which is the rule
  `--open` uses too. Where the working directory is not a project of mine, it
  comes from the conversation and the preview says so. It is never asked for: it
  stands in the preview and in the file name, so correcting it costs one word.
- `summary` is one line under about 70 characters, read in a list next to the
  others. `prettier` folds a longer value onto a second line, which is valid
  YAML but noise in the fzf preview.
- `status` is one of the five below, and a new draft gets `todo` unless my
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
  is a quoted wiki link, so the blocking draft gets a backlink. Every target has
  to exist as a file in `drafts/`, which the check enforces: a link with a typo
  in it is not a weak dependency, it is no dependency at all, and nothing else
  would ever notice. It exists only where the order is real: the later draft's
  decision cannot be made until the earlier one is. A session that produces
  several drafts records the order here.
- A `dropped` draft is **not** deleted on its own, and deleting one is a command
  under Writing to the Vault. The vault has no version control, so a deleted
  file is gone on every device, and "we considered this and rejected it" is
  exactly what cannot be reconstructed later.
- No `tags` and no `hub`.

Below the frontmatter the `# Title` is required, and `## Steps` wherever the
body takes the checklist form below. Everything else is the sections the
conversation actually produced, no fixed skeleton, no empty headings. The draft
is read in a session that was not part of this conversation: what is only in the
context now is gone with it. If the conversation says what should happen next,
write it down; a `todo` whose next step is nowhere in the file is an empty
claim.

## The checklist body

A session that decided anything gets a checklist, one that decided nothing stays
prose. A mixed session is not a third case: what was decided becomes steps, what
is still being weighed stays in the prose above them. The skill picks the form
and there is no flag for it: the preview catches a wrong guess and correcting it
costs one word, the same way `project` and `status` are already handled.

`## Steps` is the last section of the body and the only place a task line may
stand, and it holds nothing but task lines and their bullets. Above it the prose
that carries the why, in whatever shape the conversation produced, the closing
remark that something needs no change at all included. A task line stranded in a
weighing looks like a step and is not, and no query counts the boxes, so its
place in the file is the only thing that tells a step from an option.

A step is a checkpoint: after it something is demonstrably different, a command
runs through, a file exists, a check goes green. Steps with nothing to observe
are folded together. The reason is resumption, because after three weeks the
last tick has to say what state the world is in.

An entry is a task line with optional indented bullets, `Check:` for what
justifies the tick and `Watch:` for the warning that saves you before the step.
Only the task line is required, and a bullet that is there carries one of those
two labels.

```markdown
- [ ] `install.sh` links the skill into both agent directories
  - Check: `ls -l ~/.claude/skills/draft` shows a relative link
  - Watch: Codex reads `~/.agents/skills`, Claude `~/.claude/skills`
```

An extension never takes the form away. New prose goes above `## Steps`, which
stays the last section, and new steps go at the end of the list, below the
ticked ones. A draft that was prose gains a `## Steps` where the new session
decided something, never for its own sake.

## Writing a draft

1. **Scope.** One draft is one subject in one project. If arguments name a
   subject, they win. A session that produces several drafts writes each one on
   its own and shows them in dependency order, with `depends_on` set where one
   must be carried out before another.
2. **Search first.** Grep `~/projects/vault/drafts/` for the project and the
   subject. On a hit, extend that draft and bump `updated` instead of writing a
   second one. A `done`, `superseded` or `dropped` draft is not a hit: extending
   it files new thinking under a closed status where `--open` never surfaces it
   again, so write a new draft and name the closed one in the preview. If the
   new thinking contradicts what that draft decided, say so and offer to replace
   it; never fold both decisions into one file silently. Replacing it is
   `superseded` and happens only on my word, because a successor is a second
   file and a status I did not ask for. The successor is the old name plus
   `-v2`, then `-v3`: a supersede is by definition the same subject, otherwise
   it would be a new draft, so only the counter moves. That is the one exception
   to the duplicate rule, and it keeps the chain together under `ffd` and `rg`.
3. **Show it, then wait.** Build the whole file and put it up with the path it
   would get, formatted exactly as it will land:

   ```sh
   prettier --stdin-filepath ~/projects/vault/drafts/<name>.md <<'EOF' \
     | python3 -c '
   import sys, yaml, re, datetime, os
   t = sys.stdin.read(); sys.stdout.write(t)
   m = re.match(r"---\n(.*?)\n---\n", t, re.S) or sys.exit("no frontmatter")
   try: f = yaml.safe_load(m.group(1))
   except (yaml.YAMLError, ValueError) as e: sys.exit(f"frontmatter: {e}")
   isinstance(f, dict) or sys.exit("frontmatter: not a mapping")
   link = r"\[\[[a-z0-9-]+(\|[^]]*)?\]\]"
   bad  = [f"missing {k}" for k in ("title","type","project","summary","status","created","updated") if k not in f]
   bad += ["type must be draft"] * (f.get("type") != "draft")
   bad += [f"{k} must be a string" for k in ("title","summary","project") if not isinstance(f.get(k), str)]
   bad += ["project must be [a-z0-9-]+"] * (not re.fullmatch(r"[a-z0-9-]+", str(f.get("project"))))
   bad += ["status must be todo|wip|done|superseded|dropped"] * (f.get("status") not in ("todo","wip","done","superseded","dropped"))
   bad += [f"{k} must stand once, unquoted, as the --open lookup reads it" for k in ("project","status") if re.findall(rf"^{k}:.*$", m.group(1), re.M) != [f"{k}: {f.get(k)}"]]
   ex = lambda x: os.path.exists(os.path.expanduser("~/projects/vault/drafts/" + x[2:-2].split("|")[0] + ".md")) or x[2:-2].split("|")[0] in sys.argv[1:]
   s = f.get("superseded_by")
   bad += ["superseded_by must be a quoted \"[[draft]]\" when status is superseded"] * (f.get("status") == "superseded" and (not isinstance(s, str) or not re.fullmatch(link, s)))
   bad += ["superseded_by exists only when status is superseded"] * (f.get("status") != "superseded" and "superseded_by" in f)
   bad += [f"superseded_by target does not exist: {s}"] * (isinstance(s, str) and bool(re.fullmatch(link, s)) and not ex(s))
   d = f.get("depends_on")
   bad += ["depends_on must be a non-empty list of quoted \"[[draft]]\" links"] * ("depends_on" in f and (not isinstance(d, list) or not d or not all(isinstance(x, str) and re.fullmatch(link, x) for x in d)))
   bad += [f"depends_on target does not exist: {x}" for x in (d if isinstance(d, list) else []) if isinstance(x, str) and re.fullmatch(link, x) and not ex(x)]
   bad += [f"{k} is not allowed on a draft" for k in ("tags","hub") if k in f]
   bad += [f"{k} must be YYYY-MM-DD" for k in ("created","updated") if type(f.get(k)) is not datetime.date]
   sys.exit("frontmatter: " + "; ".join(bad) if bad else 0)
   ' <every draft file name this same yes also writes>
   <the whole draft, frontmatter and body>
   EOF
   ```

   `--stdin-filepath` resolves the vault's `.prettierrc` from that path even
   though the file does not exist yet. The check passes prettier's output
   through unchanged, so what gets validated is exactly the text you show and
   later write. The content rides in the heredoc, so nothing of it reaches the
   vault: nothing is on disk there before the OK. The command formats and
   checks, it does not show: its output is a tool result that stays folded up in
   the transcript, so copy it into the answer itself, in a fenced block under
   the path the file would get. The delimiter must not occur in the content: a
   draft that itself contains a line `EOF` needs `<<'DRAFT'` or any other word
   that does not.

   A frontmatter that merely parses is not enough: `status: open` is valid YAML
   and still outside the table, and no query would ever see that draft, which is
   why the values are checked too. `project` and `status` are checked twice
   over, once as values and once as the raw line: the `--open` lookup is a text
   search, so a quoted `project: "assistant"` parses to the same string and is
   still invisible to it. That is also why a name YAML reads as something else
   is no project name: `yes` and `2026` are `[a-z0-9-]+` and parse to a boolean
   and a number, and quoting them to survive that loses the text search. The
   `depends_on` and `superseded_by` lines are the checks that read the disk,
   because a link's target is not something the text can tell you. A target is a
   draft's file name and nothing else, `[a-z0-9-]+`, so no link walks out of the
   folder it is looked up in. They strip an alias after `|`, append `.md` and
   look in `drafts/`; a session writing several drafts writes each on its own,
   so the target is already there when the dependent one is checked. A supersede
   is one approval unit, so there the successor is not on disk yet when the
   predecessor is checked. That is what the names after the closing quote are
   for: each of them counts as present. Pass what the successor's link is
   written as, the file name without its `.md`, and nothing else: a link with a
   typo in it still fails, and so does a supersede that left the name out. On a
   failure repair the frontmatter and run it again; never show a preview that
   did not pass.

   The date check is `type(...) is datetime.date` and not `isinstance`: PyYAML
   reads `2026-08-16 10:00:00` as a `datetime.datetime`, which is a subclass of
   `date` and would pass an `isinstance` check despite not being `YYYY-MM-DD`.

   Nothing is on disk until I say yes; on an extension show only the changed
   passages, while the check above still runs on the whole file as it will land.
   Run `prettier --check` on the target file before you build the extension. If
   it fails, the `prettier -w` in step 5 will reformat passages your subject
   never touched, so put that formatting change up as a second passage of its
   own and let me approve it separately. A reformat never rides along unseen on
   a content change. Refused, the file keeps its old bytes and takes the
   approved passage as shown. That is the one place where what lands is not byte
   for byte what the check ran on; its verdict still holds, because prettier
   folds lines and never changes a value, so the frontmatter it reads is the
   same either way.

   **Only an explicit command writes a status or sets a tick.** A remark that
   something is now carried out states a fact and authorises nothing. You may
   offer the change once, in a single line, and never bring it up a second time.
   Ticking in Obsidian is the ordinary way and the point of the file living in
   the vault, where the box is clickable on all four devices; the agent is the
   second hand, not the first.

   **A change to `status` or a tick alone needs no preview.** My command already
   names the whole change, "set the draft to done", "tick step three", so there
   is nothing left for me to see and asking again only costs me a second yes.
   Run the frontmatter check, write, and report the new status or the step you
   ticked. `prettier --check` on the file still comes first, because the
   `prettier -w` after the write does not care how small the change was: a draft
   that was never formatted would be rewrapped whole on the back of a one word
   command. Where it fails, write the status and leave `prettier -w` off that
   file, the same as a formatting passage I refused, and say in the report that
   the file is still unformatted. The exception ends where the diff does:
   `updated` may ride along, anything else, another line of body text or the
   `superseded_by` that a `superseded` requires, is a normal change and gets its
   preview.

   **A `- [x]` line is untouchable.** Never rewrite or delete a ticked step: a
   tick claims something happened in the world, and the vault has no version
   control that would expose the lie. Something the work overtook becomes a new
   step that takes it back, a real contradiction goes through the supersede
   rule. No command lifts this: an `x` set in error comes out in Obsidian, where
   it costs a click, and the `prettier -w` of step 5 is no exception to it
   because rewrapping a line is not rewriting a step. An open box carries no
   such protection: it is body text like any other and changes under the rules
   above. It also survives a `done`, because a finished draft with empty boxes
   records what was deliberately not done, which is why `dropped` exists instead
   of deletion. Do not ask about them on the status change.

   **A supersede is one approval unit.** It touches two files, the new successor
   and the predecessor's frontmatter, but it is one decision and gets one
   preview and one yes: the whole successor first, then the predecessor's
   changed lines. Its `status` moves together with `superseded_by`, so it is
   never covered by the no-preview exception above.

4. **Write.** Write the approved content directly to its absolute path under
   `~/projects/vault/drafts/`. Never write anywhere else. On a supersede write
   the successor first: a `superseded_by` pointing at a file that does not exist
   is the broken half, while a successor whose predecessor is not yet marked is
   only untidy.
5. **Format.** `prettier -w` on the file, once it sits in the vault. A
   formatting passage I refused in step 3 is the one exception: the file is
   written and not reformatted, so what I kept stays as it was.
6. **Report.** One or two sentences: which file, created or extended, for which
   project, at which status.

**Writing a draft never edits `index.md`.** Its list of open drafts is a
Dataview query over `status`, and a line added by hand there is a second truth
that drifts.

## Picking one up: `--open`

Run this in the project you are working in, or name the project as an argument:
`/draft --open dots` works from any directory, this repo included.

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

2. **Choose.** Read every hit's `depends_on` first, whether one came back or
   several. A draft whose `depends_on` still points at a `todo` or `wip` draft
   is blocked. `superseded` is no answer by itself: follow `superseded_by` to
   the draft that replaced it and read that one's status, on to the end of the
   chain, and report a chain that comes back to a draft it already passed like a
   gone target. A `dropped` dependency is neither blocked nor free, because
   nothing is coming: report it and let me say whether the dependency goes or
   the draft does. A target that is gone is the deletion case the write check
   cannot catch: report it as broken rather than reading the draft as unblocked.
   More than one hit: put them up with `summary` and `status` and wait, saying
   of a blocked one that it is blocked instead of offering it as an equal
   choice. Exactly one: name it, say the same about it where it applies, and go
   on.
3. **Read it whole**, on disk with Read. It is a draft, not an order: it may
   contain options that were never decided and thinking that the code has since
   overtaken.
4. **Say what you understood.** Three sentences on the draft itself: what it
   wants, what of it is already in the code, and where it contradicts what you
   see. Where it has a `## Steps` section, add how many of its boxes are ticked,
   out of how many, and what the next open step is. Run none of its checks:
   `--open` is a read, and a check out of a draft would run against the live
   environment, which is what the proof rule in `global.md` sends to a scratch
   directory.
5. **Ask how to proceed**, and do nothing until answered. Carry it out, plan it
   first, or keep it in context as a reference. Ask in the same breath whether
   `status` should go to `wip`. A draft that step 2 found blocked is not offered
   for carrying out: its dependency is the thing to decide first, and a
   `dropped` or missing one is a decision of mine before anything else.
6. **Never set `done` on your own.** Whether something is finished is my call,
   and a status change is a vault write like any other: only on command. On my
   command it is written straight away, under the no-preview exception in step
   3, with the frontmatter check but without a preview.
