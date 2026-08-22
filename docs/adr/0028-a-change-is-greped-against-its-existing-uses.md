# A change is greped against its existing uses

A patch to the five instruction files passed both rounds the review regime
allows and still carried six defects. A third round, which `AGENTS.md` forbids
and which was run on command anyway, found them. Four had one shape: a term was
defined or a prohibition was tightened, and the sentences already using that
term or relying on the looser ban were never read against the new wording.

The four were "capture", defined in `global.md` against two sentences of the
note skill that say the opposite; the link ban, tightened from the target to the
syntax and thereby forbidding three contract examples the skills need; "keeps
its bytes" in the archiving, written two lines under the step that writes the
frontmatter; and "the one place", still claiming a count that the same patch had
made two.

The five questions have no slot for this. Question 4 compares a skill against
`global.md` and nothing compares two sentences of one file. So the round now
opens with a mechanical step: grep every term you defined and every prohibition
you tightened across all five files, and read each hit against the new wording.

## Considered Options

**A sixth question (rejected).** "Does a changed sentence contradict another
sentence in the same file?" fits the existing form and costs nothing. It was
rejected because it asks for the judgement that had just failed twice. The
questions are answered after the writing, by the writer, who has the new wording
in mind and the old uses out of sight. A grep produces the list of places to
look at instead of asking whether one was missed.

**Handing every patch to a cold reader (rejected).** It is what actually found
these six, and ADR 0023 already uses the instrument on a draft with steps. It
was rejected as the standing rule because its output is unbounded: the run that
found the six returned fifteen findings, several of them disputed between two
readers and several older than the patch. That is the unbounded review ADR 0019
closed, and a regime that cannot terminate is the disease rather than the cure.
It stays available as something I call, which is how it was used here.

**A machine check (rejected).** A script that flags a term defined in one file
and used in another. It was rejected for the reason ADR 0023 rejected one:
nothing in the text separates a use that contradicts the definition from one
that merely restates it, and the threshold that catches "capture" flags every
`prettier` beside it. The grep is deliberately dumber: it finds the hits and a
person reads them.

## Consequences

- The step runs before the round and is not a sixth question, so the cap of one
  round plus one second round stands exactly as ADR 0019 set it.
- It reaches only what the patch touched. A sentence that drifted without a term
  being defined or a ban tightened is still the round's business.
- The step was run against the patch that carries this record. It confirmed that
  `capture` no longer gates anything in `global.md`, that every `[[link]]` left
  in a skill names a file that does not exist, and that no counter survived.
