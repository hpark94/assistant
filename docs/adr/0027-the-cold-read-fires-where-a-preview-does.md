# The cold read fires where a preview does

ADR 0023 put a fresh agent in front of every draft that carries a `## Steps`
section, before its preview. The trigger it wrote was "a new draft and a
modification", and a review round of the five instruction files found that
"modification" was doing normative work while standing defined nowhere. Two
edges came out of it. A close has a preview and lands with its `## Steps`
intact, because an open box survives a `done`, so the rule fired and sent a cold
reader to ask which open steps it could not carry out on a draft that was being
closed. A tick has no preview at all, so the rule's anchor, "before their
preview", dissolved and left it unsaid whether every click costs a subagent run.

The trigger is now the preview: a change that has one, on a file that lands with
a `## Steps` section under a `todo` or `wip` status. That names the two things
that decide it and leaves no term to define.

## Considered Options

**Firing on a close as a last look at the open boxes (rejected).** A close is
the last moment anyone reads the file with attention, and an unfinished step
would be worth seeing before it goes quiet. It was rejected because ADR 0023
grounds the read in a step someone has to carry out weeks later, and a close
ends that. An open box that survives a `done` records what was deliberately not
done, which is the reason `dropped` exists instead of deletion; it is not a gap
to be repaired.

**Firing on a tick as well (rejected).** A tick changes what the next reader
finds open, so the file's carry-out-ability really does change under it. It was
rejected because there is no preview to put the findings beside. The read would
produce a list with nowhere to go, and every click on a box would cost a
subagent run, which is the opposite of the rule that ticking in Obsidian is the
ordinary way.

**Defining "modification" as a term of its own (rejected).** One sentence in the
draft skill naming what counts would have kept the trigger as it was. It was
rejected because the definition would only repeat what the trigger says once it
names the preview and the status, and a term defined beside the rule it serves
is a second place for the two to drift apart.

## Consequences

- A supersede's predecessor never takes a cold read: its status leaves `todo`
  and `wip` in the same write. The successor takes one where it carries steps.
- The status is read as it will land and not as it stands, so a draft going from
  `todo` to `wip` with new steps in the same change is still read cold.
- ADR 0023 is not edited. It records what was found and why the read exists;
  this record narrows where it fires.
