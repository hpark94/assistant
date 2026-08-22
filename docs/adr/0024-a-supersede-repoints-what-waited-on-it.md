# A supersede repoints what waited on it

`assistant-load-time-ownership` was superseded on 2026-08-22, and
`assistant-draft-lifecycle-v2` had a `depends_on` pointing at it. The link kept
working, because `--open` follows `superseded_by` to the end of the chain before
it calls a draft blocked. It kept working and it said the wrong thing: the
dependent named a draft whose decisions had been replaced, and nothing in the
file said so.

A supersede therefore reads every draft whose `depends_on` names the predecessor
against the successor, and repoints the link where the successor still carries
what the dependent waits for. Where it does not, the dependency is reported and
I decide. Each such draft is its own approval unit; the supersede's own covers
the successor and the predecessor's two lines and nothing beyond them.

The draft that decided this rule held that it needed no record, because the rule
states its own reason. The second review round disagreed and this ADR is the
result: the reason in the rule text says what to do about a stale link, and not
why the chain `--open` already follows is not enough, which is the half that
gets reopened.

## Considered Options

**Nothing, because the chain already resolves it (rejected).** `--open` follows
`superseded_by` "on to the end of the chain" and reports a ring or a gone target
as broken, so a dependent that was never repointed still finds a status to read.
It is the cheapest option and it is already implemented. It was rejected because
the chain is a read-time repair on a link that is wrong on disk. It resolves
only while the predecessor is there, and a draft is deleted on my command like
any other file in the vault, at which point the dependent points at nothing and
the loss shows up at the first `--open` after it. The write check reads the disk
for a `depends_on` target and would have caught that at the time the link was
written; it cannot catch a target that leaves later.

**Folding the dependents into the supersede's one yes (rejected).** The
predecessor and the successor already go up as one approval unit, and the
dependents could ride along in it. It was rejected because a dependent is a
separate judgement and not a second half of this one: whether the successor
still carries what that draft waits for is decided per file, and one of them may
come back as a report instead of a repoint. This is the same boundary ADR 0013
drew and not a break with it. There a supersede was kept in one unit because the
two halves are one decision; here each dependent is a decision of its own, so an
unbounded set of files cannot ride on the yes the supersede was given.

**Repointing every link that names the predecessor (rejected).** Mechanical, it
needs no reading and it always leaves the chain short. It was rejected because
the successor may have dropped the very thing the dependent was waiting for. A
link bent to look satisfiable when it is not is worse than a stale one, and
nothing downstream would notice: the existence check asks whether the file is
there and never what it contains.

## Consequences

- `--open`'s chain following stays exactly as it is. It is what keeps an
  unrepointed link resolving in the window before the repoint, and it still
  carries the ring and gone-target cases, which repointing does not touch.
- A supersede can now cost several yeses, one per dependent. That is the price
  of the per-file judgement, and it falls only on drafts that actually name the
  predecessor, which in eleven drafts has been at most one at a time.
- Where the successor no longer carries what a dependent waits for, the answer
  is a report and a decision of mine. The rule never resolves that case on its
  own, so a supersede can leave a stale link behind on purpose.
- The first case is on record: `assistant-draft-lifecycle-v2` was repointed to
  `assistant-load-time-ownership-v2` on 2026-08-22, where the successor did
  carry the blocker.
