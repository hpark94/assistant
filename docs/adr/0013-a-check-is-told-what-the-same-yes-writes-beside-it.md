# A check is told what the same yes writes beside it

`superseded_by` was the one link in a draft's frontmatter that nothing verified.
`depends_on` had an existence check from the start, with the argument that a
link with a typo in it is not a weak dependency but no dependency at all, and
the same argument holds one file further on: a `superseded_by` pointing at a
file that does not exist is what the skill itself calls the broken half. The
obvious repair, the same check on the other line, was made and was wrong.

A supersede is one approval unit. The predecessor's frontmatter and the whole
successor go up in one preview and take one yes, and nothing is on disk before
that yes. The check runs while the preview is built, so the successor it points
at cannot be there, and the skill's own rule that a preview which did not pass
is never shown then closed the path completely:

```sh
printf -- '---\ntitle: "T"\ntype: draft\nproject: assistant\nsummary: s\nstatus: superseded\nsuperseded_by: "[[assistant-ospf-metrics-v2]]"\ncreated: 2026-08-19\nupdated: 2026-08-19\n---\n\n# T\n' \
  | python3 draft-check.py
frontmatter: superseded_by target does not exist: [[assistant-ospf-metrics-v2]]
```

The write order that the skill already prescribes, successor first, does not
save it: it happens after the yes and cannot reach a check that ran before it.
Two reviewers and a verifier found this independently in the round after the
change, each from the same three sentences of the skill.

The check is therefore handed the file names that the same yes writes beside the
file under test, as arguments after the closing quote, and each of them counts
as present. `depends_on` uses the same helper, which costs nothing where a
session writes its drafts one at a time and covers the case where it does not.

This is stricter than the state before the check existed, not laxer. The name
passed in is the path the successor is actually written to, so a wiki link that
disagrees with it fails, and a supersede that names nothing fails too. Both
failures now happen before anything is on disk, where the broken half used to
surface at `--open` weeks later:

| case                                       | result                              |
| ------------------------------------------ | ----------------------------------- |
| supersede, successor named                 | passes                              |
| supersede, nothing named                   | superseded_by target does not exist |
| supersede, name disagrees with the link    | superseded_by target does not exist |
| `superseded_by` at a draft on disk         | passes without a name               |
| `depends_on` at a file the same yes writes | passes                              |

## Considered Options

**No check, with the reason written down (rejected).** State in the skill that
`superseded_by` cannot be verified because its target belongs to the same
approval unit, and let the write order and `--open` carry that half. It is the
smallest change and it is honest, and it was what the broken check was first
reverted to. It was rejected because the reason is a fact about _when_ the
target exists, not about whether it can be known: the agent writing the
supersede knows the successor's name, and a check that declines to ask for what
the caller already has is a gap dressed as a principle.

**A second run after the successor is written (rejected).** Keep the preview
free of the existence line and run the predecessor's check again between the two
writes, where the disk answers truthfully. It checks reality rather than a
passed-in string. It was rejected because it puts a check after the yes: a
failure there leaves the successor on disk and the predecessor unmarked, which
is the half state the write order exists to avoid, and it adds a phase to a
contract whose whole shape is check, show, wait, write.

**Splitting the supersede into two approval units (rejected).** Preview and
write the successor first, then the predecessor's changed lines as a second
change, and the target exists by the time the second check runs. It needs no new
mechanism at all. It was rejected because it costs a second yes for one
decision, and the skill argues in place that a supersede is one decision.

## Consequences

- The invocation line of the draft check ends in
  `' <every draft file name this same yes also writes>`, empty in every ordinary
  write. The note skill's checks are untouched, and not because the case is
  absent: a Note and its new Hub are one approval unit too, and the Note's `hub`
  links to the Hub by name. They read no disk at all, only the shape of that
  link, so nothing there can ask for a file that is not written yet.
- The paragraph beside the check states the asymmetry rather than the mechanism
  twice: several drafts are written each on their own, so their targets are
  already there, and a supersede is the one case where they are not.
- ADR 0012's reachability rule is unaffected. This is about what a check may
  assume, not about which skill a request reaches.
