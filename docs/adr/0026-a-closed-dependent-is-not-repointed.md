# A closed dependent is not repointed

ADR 0024 gave a supersede the duty to repoint the drafts whose `depends_on`
named the predecessor. The rule went into the writing step and nothing else
moved with it. A review round of the five instruction files found three things
open in one sentence: it named no lookup, where `--open` gets one with its `-r`
argued; it named no scope, although `drafts/` is flat and a dependency crosses
projects; and "every draft whose `depends_on` names it" reached a `done` or
`dropped` dependent, which the draft contract protects with "a `done` or a
`dropped` one takes nothing but its `## Outcome`". An agent could not obey both.

Only a `todo` or `wip` dependent is repointed. The candidates come from
`rg -l '\[\[<predecessor>\]\]' ~/projects/vault/drafts/` over the whole folder,
and the set is narrowed by reading them, because that grep also finds a body
mention and a `superseded_by` pointing the other way.

## Considered Options

**Repointing every dependent regardless of status (rejected).** It is the
literal reading of ADR 0024 and needs no filter. It was rejected because a
closed draft's `depends_on` records what it waited for at the time, and nothing
waits on it any more. Carving an exception into the contract sentence would also
make the one line that keeps a closed draft closed negotiable, and that line is
what stops new thinking from being filed under a status `--open` never surfaces.

**Scoping the lookup to the predecessor's project (rejected).** Every draft
carries `project`, and `--open` already searches by it, so the same lookup was
available for free. It was rejected because `drafts/` is one flat folder and the
project prefix in a file name is a naming convention rather than a boundary.
Nothing stops a draft in one project from waiting on a decision made in another,
and a dependency the lookup cannot see is the case the whole rule exists for.

**A grep anchored on the `depends_on` line itself (rejected).** It would return
the dependents alone and spare the reading step. It was rejected on a proof: a
`depends_on` list longer than the print width is folded by prettier into a
multi-line block sequence, so the link no longer stands on the `depends_on` line
at all. Written into a scratch directory holding the vault's `.prettierrc`, a
108 character `depends_on` line came back from `prettier -w` as a block sequence
over five lines. A line-anchored pattern would have missed exactly the draft
with the most dependencies.

## Consequences

- The repoint has a lookup that is wider than its target set, and the narrowing
  happens by reading. That is deliberate: a candidate discarded by reading costs
  nothing, a dependent never found costs the link.
- A closed dependent keeps a link that points at a superseded draft. `--open`
  follows `superseded_by` to the end of the chain, and no one is waiting on that
  draft anyway.
- The supersede's own approval unit is unchanged. Each repointed draft takes its
  own pass through steps 3 to 6, which is what ADR 0024 decided and what the
  step's line count now says.
