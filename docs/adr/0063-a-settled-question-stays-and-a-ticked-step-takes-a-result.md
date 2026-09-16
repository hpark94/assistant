# A settled question stays and a ticked step takes a result

Working through `routing-lab-verifier-flags` showed that a plan carried out by
hand changes under the hands. Steps were added and reworded after the fact, and
decisions nobody had made yet piled up under a free-prose `## Still open`. Three
things went wrong in that file. A question answered later was deleted, and the
step that answered it still said "answers the open question below" about a
question no longer there. Open steps kept saying "still open above" about things
a prose section had since decided. And ticked steps grew commits, measurements
and corrections to their own Check inside `Watch:`, a label defined as the
warning before the step, under a `global.md` rule that did not say whether a
tick's bullets are part of what it protects.

`## Still open` is now a named section directly above `## Steps`. A decided
entry stays and gains `Settled YYYY-MM-DD:` with the decision in one sentence
and where its why stands; settling it corrects the open steps and prose it makes
wrong in the same unit. A ticked step takes an appended `Result:` and nothing
else, and `global.md` says that its bullets belong to it and that appending one
is not rewriting it. New open steps may go anywhere below the last tick.

## Considered Options

**A separate section for fog (rejected).** The wayfinder skill keeps "Not yet
specified" for work it can see coming but cannot phrase sharply, apart from
sharp questions. It was rejected because every further section is one more place
a reader has to look, and the draft that prompted this held almost no fog.
`## Still open` carries both kinds.

**A checkbox for a settled question (rejected).** It reads naturally and
Obsidian makes it clickable. It was rejected because a task line may stand only
under `## Steps`, which is what tells a step from an option.

**Moving a settled question into a `## Settled` section (rejected).** It keeps
`## Still open` short. It was rejected because the question leaves the place
every reference to it expects, which is the failure this change exists for.

**Labelling the weighing of a question, `Options:` (rejected).** Nothing reads
it mechanically, so a label would be scaffolding, and every existing entry would
need rebuilding.

**Leaving results under `Watch:` unregulated (rejected).** It is what happened,
and the results are exactly what a session resuming the draft needs. It was
rejected because the label then means two things, and because `global.md` could
be read to forbid the bullet altogether.

**Forbidding any bullet under a tick and putting results into a new step
(rejected).** It keeps the absolute whole. It was rejected because a step that
records what another step turned out to be is no checkpoint.

**Naming `Result:` in `global.md` (rejected).** The label is the draft skill's
mechanics; `global.md` allows appending a bullet and the skill says which.

**New steps only at the end of the list (rejected).** A step discovered while
the work runs belongs before the open steps it has to precede; only the ticked
steps need to stay an unbroken record.

## Consequences

- `routing-lab-verifier-flags` is not rewritten by this change. Its lost ROA
  question and its stale `Watch:` lines on open steps are a correction of its
  own, and its results under `Watch:` on ticked steps stay, being part of
  protected steps.
- A `Settled` bullet is append-only by the skill and not by `global.md`: a tick
  is a claim about the world, a decision is thinking in a draft, and one really
  overturned goes through the supersede rule.
- `--open` reports the count of unsettled entries and the one the next open step
  waits on, and nothing more.
