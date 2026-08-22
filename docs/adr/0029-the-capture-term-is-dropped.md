# The capture term is dropped

`global.md` gated a permission on a term it never defined: "a correction to an
existing Note outside a capture" needed a command, and nothing said what a
capture was. A review round found that as a load time gap and the finding was
right. The repair was wrong. A definition went into the bullet above it, "a run
of one that writes a Note, a Hub or a Draft is a capture", and it contradicted
the note skill in two places within the same patch: mode three says of a
commanded correction "there is nothing to capture", and the hub contract says
"No capture ever edits an existing hub" while prescribing exactly that
correction two sentences later.

The term now leaves the permission. The bullet names the trigger it was standing
in for: "a correction I command to an existing Note". The note skill keeps the
word for the operation it owns.

## Considered Options

**Defining it correctly (rejected).** "Writing a Note, a Hub or a Draft from
what a session produced is a capture; a change I name myself is not" draws the
boundary where the skills actually draw it, and it would have survived both
collisions. It was rejected because the second half of that definition is the
trigger, and the trigger is already in the sentence that needed it. A definition
that only restates a trigger is a second surface for one distinction, and this
one drifted from its skills on the day it was written.

**Leaving the term undefined, as it stood before (rejected).** It had worked for
months, and no agent had ever been recorded misreading it. It was rejected
because the load time test does not ask whether a gap has bitten yet. A bullet
that gates a permission has to be readable when no skill is loaded, and "outside
a capture" is not.

**Defining it in each skill instead (rejected).** Both skills use the word and
each could carry the definition, which is how the ASCII slug and the frontmatter
check are already handled. It was rejected because the gate was in `global.md`,
and a definition in a file the reader has not loaded is a rule that does not
hold.

## Consequences

- `global.md` still uses "capture" in two justifications, where it gates nothing
  and a loose reading costs nothing.
- The note skill is the owner of the word and the only file that defines it by
  use.
- `global.md`'s bullet and the note skill's third mode now say the same thing in
  the same words, "a correction I command", which is what the two files failing
  to agree had cost.
