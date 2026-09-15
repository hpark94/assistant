# A commanded draft correction finds its draft

ADR 0046 let a commanded draft correction skip step 2, which held the only
search in the skill. A review found nothing then said how the named draft is
found: one agent grepped, one asked for a file name, one guessed a path.

The correction now greps `drafts/` for the draft I name, stops where nothing
fits, and puts several that fit up with `summary` and `status`. It still skips
step 2: its search is for the draft named, not for the subject, its dependencies
or a successor name. The head of the skill names it as a third mode, the way ADR
0016 did for the note skill.

## Considered Options

**Requiring the file name (rejected).** It makes the lookup exact. It was
rejected because the note skill finds a named note by its search, and the same
command should not cost more words on a draft.

## Consequences

- ADR 0046 is not edited. Its "skips the search" means step 2's search.
