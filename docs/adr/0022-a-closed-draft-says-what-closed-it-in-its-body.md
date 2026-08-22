# A closed draft says what closed it in its body

Seven of the eleven drafts of this project were `done`, and two of them read as
open. `assistant-sourced-web-search` ended on "One proof is still open" and
`assistant-draft-lifecycle` on "Update `CONTEXT.md`, ADR 0004 (…) then prove",
both under a frontmatter saying finished. The frontmatter said the draft was
closed, the body said what was left to do, and nothing in the file said which of
the two was younger.

The closing section already existed in every one of those drafts, under five
different headings: `## What was carried out`, `## Suggested Direction`,
`## Decision`, `## Decisions` and `## Next step`. The content was universal and
only the name was not, so what was missing was a name and an append rule and not
a mechanism. A close now appends `## Outcome`, on `done` and on `dropped`, and
nothing above it is rewritten.

## Considered Options

**An `overtaken_by` property (rejected).** Record in the frontmatter what closed
the draft, the way `superseded_by` records what replaced it. It was rejected on
three counts. Its target is usually an ADR or a commit and therefore outside the
vault, where a wiki link cannot point and the existence check cannot look.
Nothing would ever query it, because every lookup already filters on `todo` and
`wip` and never reads a closed draft. And `status` would end up carrying two
axes, where the draft stands and what the world did to it afterwards, which is
the ambiguity the section is meant to remove.

The precedent against it is ADR 0013. `superseded_by` cost an entire decision
about its existence check, three commits with two later corrections, and it has
not been used once in eleven drafts. A gap in a draft's story is not answered
with a new frontmatter property.

**Weaving the outcome into the prose (rejected).** Correct the sections the
close overtook, so the file reads as one consistent statement. It was rejected
because a closed draft records its own time: the prose above says what was
believed when it was written, and the vault has no version control that would
show it had ever said anything else.

**Leaving the closing section free-form (rejected).** It is what the eleven
drafts already did, and it produced five headings for one thing. A name that
varies cannot be asked for by a rule, and the two drafts that read as open had
no closing section at all.

**An `## Outcome` on `superseded` as well (rejected).** A supersede already
carries `superseded_by` as a checked link with a backlink, and it already goes
up as one approval unit with the whole successor beside it. The successor is the
outcome.

## Consequences

- A close is no longer a status change alone, so the no-preview exception stops
  short of it. The exception itself was not rewritten and keeps covering a `wip`
  and a tick; the status and the section go up together and take one yes,
  because a `done` written ahead of a refused Outcome is exactly the state the
  section exists to prevent.
- The five closed drafts that carry no `## Outcome` stay as they are. Only the
  two that read as open were repaired, and a record is not retrofitted.
- `## Steps` is now the last section of the _open_ body. `## Outcome` is the one
  section that may follow it, which does not weaken ADR 0011's rule that a task
  line stands nowhere else: a closing section holds no task lines.
