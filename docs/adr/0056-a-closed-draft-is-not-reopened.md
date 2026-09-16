# A closed draft is not reopened

A `done` or `dropped` draft carries an `## Outcome`, and a change of status
alone needs no preview. The same review found nothing that said whether that
status may go back to `todo` or `wip`: one agent could set it on command and
leave an open draft with an Outcome, another refuse, a third remove the Outcome
in a body change the closed-body rule forbids.

The status of a closed draft now never goes back to `todo` or `wip`. New
thinking on its subject is a new draft with the next counter, which the draft
skill already prescribed for a closed draft that is not a hit.

## Considered Options

**A reopen operation (rejected).** Back to `wip`, the Outcome removed in a
previewed change. It keeps one file per subject. It was rejected because it
rewrites what the close recorded, the `-v2` route already exists, and it needed
a third status transition with its own preview rule.

## Consequences

- A closed draft may still become `superseded`: a supersede moves forward and
  keeps the record.
