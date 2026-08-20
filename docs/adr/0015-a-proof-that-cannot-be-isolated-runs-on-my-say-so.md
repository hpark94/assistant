# A proof that cannot be isolated runs on my say-so

`global.md` gave a proof two outcomes. Either it runs in a scratch directory and
comes back with a command that rebuilds its own environment, or "no cheap or
safe test exists", the answer is marked unverified, and nothing runs. "In a
scratch directory, never in my live setup" admitted no third.

A review of the vault found that a third had already happened.
`virtualization-docker-libvirt-nat.md:135-146` records half a proof run against
the live setup on 2026-08-11: `nft flush chain ip filter DOCKER-USER`, a
`systemctl restart docker`, and the check that the forwarding policy survives
both. The note is honest about it and calls the result "recorded rather than
repeatable", with the warning that a re-run drops the machine's forwarding for a
moment. Nothing in the rule covered what the note describes.

The class is not exotic on this machine. A firewall chain, a running daemon, an
interface: there is no scratch version because the thing under test is the live
one, and copying it is what the question is about. Calling such an answer
unverified would be false. The command ran, the answer came back, and it is
checkable by anyone willing to pay the same price again.

What is missing is therefore not an exit but a gate. The absolute opening is
narrowed to proofs that can be isolated, and the rule gains a third paragraph:
the command is named before it runs, it runs on an explicit yes, and what comes
back is given as recorded rather than repeatable.

## Considered Options

**Keeping the rule absolute (rejected).** The note's own paragraph is the record
of an exception and the file stays as it is. It costs nothing and it keeps the
strongest possible bar in the file loaded in every project. It was rejected
because the bar is not the thing that protects the setup: the yes is, and an
absolute rule with a standing exception teaches an agent to take the exception
quietly rather than to ask. A rule that describes two outcomes where there are
three is read as an oversight by the next agent that meets the third.

**Marking such answers unverified (rejected).** The exit already exists, and it
is one sentence away. It was rejected because it is untrue. Unverified is for a
claim that was not shown and says what stood in the way; this claim was shown,
once, and the gap section would have to invent a gap that is not there. It also
loses the result, which is the expensive part.

**A yes after the run (rejected).** Run it, report what was done, and let me
object. It reads as the smaller interruption. It was rejected because the cost
is already paid by then: the chain is flushed, the daemon restarted, the
forwarding was down. A gate that opens after the fact is a notification.

## Consequences

- `global.md`'s "Where tests run" gains one paragraph and the two outcomes
  become three. The scratch rule is narrowed to everything that writes and can
  be isolated, and the read-only exception beside it is unchanged.
- The gate is the only new obligation, and it costs a turn: a proof that would
  have run silently now waits. That is the point of it.
- The note skill records the exact command like any other Proof, but only an
  isolatable one has to rebuild its own environment. A live result says that it
  is recorded rather than repeatable, the shape
  `virtualization-docker-libvirt-nat.md` already had.
