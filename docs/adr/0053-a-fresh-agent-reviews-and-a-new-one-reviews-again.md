# A fresh agent reviews, and a new one reviews again

A review with two Codex readers and one fresh agent found the review rules of
`AGENTS.md` open in four places. They did not say who answers the five
questions, so one agent reviewed its own patch and another spawned readers. The
count of touched instruction files had no unit, so a change split into two
commits escaped its round. The grep ran only "before the round", and the second
round ran after any patch, even where round one found nothing. Question 4
compared a skill with `global.md` and never with the mechanics another skill
carries too, although both skills have to carry them.

The five questions are now answered by a fresh agent, and the second round by a
new one. The count is per commit, the grep runs before every commit, and a
second round follows only where the first patched. Question 4 also asks about
mechanics two skills both carry.

## Considered Options

**The author answers the questions (rejected).** ADR 0019 left it that way and
it costs no delegation. It was rejected because the author reads the wording it
meant and not the wording it wrote, which is the gap every multi-reader review
of this repo found and no self-review did.

**The same reviewer for round two (rejected).** It already knows the files and
checks its own findings fastest. It was rejected because it reads the patch
against what it reported, so the patch is no longer read cold, and round two
exists to catch what the patch itself broke.

**Counting instruction files per change rather than per commit (rejected).** A
change is what the author means by it, and nothing on disk records it. A commit
is on disk, and `AGENTS.md` already asks for one after every change.

## Consequences

- `CLAUDE.md` is named as not counted: it holds no rule and only imports
  `AGENTS.md`.
- An ADR goes into the commit of the change it records, which is how the history
  already did it.
