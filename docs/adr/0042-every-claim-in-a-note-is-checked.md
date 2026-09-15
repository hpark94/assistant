# Every claim in a note is checked

ADR 0017 tied a note's checks to `global.md`: a claim for which `global.md`
requires a Proof was run, and a claim for which it does not was carried by its
citation. `global.md` requires a Proof only where I ask whether something is
possible, how it behaves or why it fails. A `/note` on a settled conversation
asks nothing, so a review found two careful agents splitting on the same claim
about `rsync --delete`: one wrote it with no section, the other ran it.

Every claim a note makes is now checked, whether or not I asked. What I have and
can run is run; a claim nothing I have can run, and what a standard or a
specification defines, is checked by a source read in full and cited on its
sentence; a claim that got neither goes into `## Not verified`. A command that
already ran in this session counts where it is the command the note records. A
change to an existing note checks what it adds or rewords and names in one line
the claims already there that carry no check.

ADR 0017's third state stays: a sourced claim takes no section, and `verified`
is still the oldest aging check.

## Considered Options

**Checking only where `global.md` requires a Proof (rejected).** It was the rule
until now and costs nothing on a note from a conversation. It was rejected
because whether a question was asked is a fact about the conversation and not
about the claim, and the note is read on a day when that conversation is gone.

**Only runnable claims in a note (rejected).** It makes every claim in the vault
a command. It was rejected because a note about what an RFC defines could then
not exist.

**A command for every claim, a source never enough (rejected).** It was rejected
for the same reason ADR 0017 gives: that IPv6 fragments only at the source is
not a fact this machine settles.

**Rechecking the whole note on every change (rejected).** It keeps an old note
from carrying unchecked claims. It was rejected because a small extension would
then show changes I never asked for, and the one line naming the unchecked ones
leaves the decision with me.

## Consequences

- The contract's example shows the exact commands and their output, and it lost
  the `ncdu` claim that nothing checked.
