# A decided draft carries its plan as a checklist

A grilling that ends in a decision had nowhere to put the plan it produced. The
chain was already there, the grilling sharpens and offers `entwurfswuerdig`,
`/draft` writes the thinking down, but a draft's body was prose, and prose does
not say where a plan carried out by hand stands. Between "we decided this" and
"three of six steps are done" the vault held nothing.

A draft's body may therefore take a second shape. A session that decided
something gets a checklist, one still weighing options stays prose, and the
skill picks between them without a flag, the same way it already picks `project`
and `status` and lets the preview catch a wrong guess. `## Steps` is the last
section of the body and the only place a task line may stand; an entry is a task
line with optional indented `Check:` and `Watch:` bullets. A step is a
checkpoint, meaning something is demonstrably different after it, because the
tick has to say what state the world is in to somebody resuming in three weeks.
Ticking happens in Obsidian, where the box is clickable on all four devices, and
by the agent on an explicit command, under the rule that already governs
`status`. A set `- [x]` is untouchable: it claims something happened in the
world, and the vault has no version control that would expose the lie.

Nothing else was built for it. No new skill, no new type, no new folder, no new
frontmatter field, no change to `global.md`. The frontmatter check stays
frontmatter and does not learn to read boxes, because nothing consumes them
mechanically: the index block queries `status`, and `--open` reads the whole
file anyway. Without a silent consumer there is nothing to deceive. That flips
the day a Dataview block counts progress.

## Considered Options

**A separate plan type in `plans/` (rejected).** A sibling of `notes/` and
`drafts/` holding carried-out plans, with its own frontmatter and its own query
block. It reads clean, and it duplicates the entire draft lifecycle for a
difference that only concerns the body: status, project binding, supersede
chain, index block, frontmatter check, the `--open` lookup. Everything a plan
needs a draft already has. This is the option that will be proposed again, which
is why it is written down here.

**An explicit `/draft --plan` (rejected).** The invoker names the body form
instead of the skill guessing it. It adds a third argument format next to the
bare colon form and `--open`, and it makes the same decision twice, once in the
conversation that just settled it and once at the command line. A wrong guess
costs one word in the preview; a third format costs every invocation.

**`--open` executing the checks (rejected).** It would make the `Check:` line
load-bearing instead of something only a reader acts on, and could report the
true state rather than the recorded one. It was rejected because `--open` is a
read, and a check lifted out of a draft runs against the live environment, while
the proof rule in `global.md` demands a scratch directory. Reconciling those two
is a decision of its own and not something a read command settles in passing.

**Body rules in the frontmatter check (rejected).** The failure class is real: a
task line stranded in a weighing section looks like a step and would falsify any
count. But no query counts them, and the one thing that does, `--open`, reads
the whole file and sees a stranded line for what it is. Teaching the check to
parse the body would break its single responsibility, that the file's properties
are valid YAML with the values the queries expect.

## Consequences

- The draft skill's sentence "Below the frontmatter only the `# Title` is
  required" is amended rather than left standing beside its own exception.
  `## Steps` is required wherever the checklist form applies.
- A tick and a status change are one rule and not two. The paragraphs that
  already carried the status carry both: an explicit command, no preview, the
  frontmatter check, a report, and `updated` may ride along. A second,
  differently worded exception beside them would have been the thing to keep in
  step forever.
- Status wins over open boxes. A `done` draft with empty boxes keeps them, for
  the reason `dropped` exists instead of deletion: what was deliberately not
  done is exactly what cannot be reconstructed later.
- `CONTEXT.md` gains **Checkpoint**. The untouchability of a set tick is a
  structural invariant and belongs there; the authorization and preview rules
  stay in the skill.
- Five questions the first cut of these rules left unanswered are settled here.
  `## Steps` holds task lines and their bullets and nothing else. A session that
  decided anything at all gets a checklist, with whatever it is still weighing
  as prose above the list. `Check:` and `Watch:` are the labels an optional
  bullet carries. An extension never takes the form away. And a tick set in
  error comes out in Obsidian rather than on a command to the agent, which is
  the one prohibition here that no command lifts.
- `install.sh` is unchanged. Both agents' skill paths already resolve to the
  repo file, so the new rules reach them together.
