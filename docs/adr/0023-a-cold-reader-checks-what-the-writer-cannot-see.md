# A cold reader checks what the writer cannot see

`assistant-load-time-ownership` named "the five review questions" five times and
listed them nowhere. It went through a full preview and neither the writer nor I
noticed, because both of us had the five in context and read them into the file
without seeing that they were absent from it. That is a class of gap a warm
reader cannot find: the missing text is supplied by the conversation both sides
are sitting in, and the preview shows the whole file without ever showing the
hole.

The repair was tried once before it became a rule, on the preview of the draft
that decided it. A fresh agent without the session's context was handed the file
and asked which of its open steps it could not carry out from that file alone.
It came back with four holes in one pass: the order of the status write against
the Outcome preview, which text a modification hands the reader, whether a
finding may be folded in silently, and that "instruction file" was defined
nowhere although the review regime counts them. Three of that draft's decisions
came out of the answer.

The rule fires wherever the file as it will land carries a `## Steps` section,
on a new draft and on a modification alike. A step is a checkpoint someone has
to be able to carry out weeks later, so a draft with steps is the one that can
fail this way; a prose draft that decided nothing has nothing to fail on.

## Considered Options

**A self-check in the preview (rejected).** Add a question to the writing steps:
would this file be carried out correctly by a session that was not part of this
conversation? It costs nothing and needs no second agent. It was rejected
because the writer answers it out of the context that is the fault. The question
had in effect already been asked: the contract says that the draft is read in a
session that was not part of this conversation, and the file with five unlisted
questions passed under it anyway.

**A machine check (rejected).** Have the frontmatter check, or a second script,
flag a term the file names but never defines. Nothing in the text separates a
term that is defined elsewhere from one that is defined nowhere, and the
threshold that would have caught "the five review questions" flags every
`prettier` and every `rg` beside it.

**Handing the reader the narrowed preview (rejected).** On a modification the
preview shows only the changed passages, and the reader could be given the same.
It was rejected because a reader given a fragment cannot tell a gap in the file
from a passage it was not shown, which makes its answer worthless exactly where
the file is oldest. It is given the whole file as it will land, the way the
frontmatter check already runs on the whole file.

**Letting the reader repair what it finds (rejected).** A rewrite would arrive
already fixed and cost me nothing to approve. It was rejected because the
finding is the point: a fold-in shows me the repair and hides which gap the file
had, and the reader has none of the session's decisions to repair it with. It
answers with a list, and the list goes up beside the preview.

## Consequences

- The read runs before the preview and its findings go up beside it, so one yes
  still covers the whole write. Sending the findings up afterwards would cost a
  second yes and would put a check after the point where the file can still
  change cheaply.
- Every draft with steps now costs one subagent run. That is the same instrument
  the proof rule in `global.md` already prescribes for a proof that needs a
  built environment, used here on a file instead of a command.
- The case this record rests on is no longer on disk.
  `assistant-load-time-ownership` has listed all five questions since
  2026-08-21, and the vault has no version control, so what stands here is that
  draft's account of the gap rather than an artifact that can be opened. This
  ADR is not edited when that stops being reconstructible; it records what was
  found.
