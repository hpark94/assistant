# A source on the sentence is shown

The note contract knew two states. A claim was proved, and then the note carries
`## Verified` with the result, the exact command and a `verified` date, or it
was not, and then `## Not verified` says what was not shown and what stood in
the way. A review of the vault found two notes with neither,
`networking-ipv4-and-ipv6-security.md` and
`networking-osi-and-internet-protocol-layers.md`, and reported them as contract
violations.

They are not. Both carry their claims on Markdown links to primary sources, RFC
9099, 6274, 4890, 7112, 6980 and 9288 in the one, ITU-T X.200 and the X.224 to
X.226 series with RFC 1122 and 1123 in the other, each on the sentence that
makes the claim. That is what `global.md` prescribes for a source, down to the
placement. Demanding a command instead would demand a command that does not
exist: that IPv6 fragments only at the source is not a fact this machine
settles. Demanding `## Not verified` would demand a gap section that has to
invent its own subject, because nothing stood in the way and nothing is missing.

The contract was short a state. A source-backed claim for which `global.md` does
not require a Proof is recorded by its citation alone. A standard does not go
stale. A version, a price, an API surface, a limit or a release does, which is
the class `global.md`'s search duty already names. `verified` is therefore the
oldest date of every claim in the note that can go stale, whether a command ran
or a source was read. A fresh check on one cannot hide a stale one beside it.

The motivating notes use primary sources, and those remain the first choice. The
state is not limited to them: where no suitable primary source is available, a
reliable secondary one may stand in, with one brief reason why it is the best
available source. The distinction is between a Proof and a source record, not
between a claim with a perfect source and one the best available source carries.

## Considered Options

**Treating the two notes as violations (rejected).** Give each a
`## Not verified` section and the contract stays as it is. It was the review's
own reading and it needs no change to the skill. It was rejected because it is
false. The claims were shown, by documents that outlive any command run here and
that a reader can check without this machine, and a gap section on top of
thirteen primary sources would say nothing true.

**A `## Sources` section (rejected).** It makes the third state visible in the
note, which is the honest complaint against leaving it unmarked. It was rejected
by `global.md`, which asks for a Markdown link on the sentence that carries the
claim and rules out "no numbered footnotes, no collected list at the end". The
section is that list.

**No distinction between claims that age and claims that do not (rejected).**
The simple version: a sourced claim never carries `verified`, and the field
stays what it is, a date for a command. It was rejected because `index.md` asks
`WHERE verified AND verified < date(today) - dur(6 months)`. A note without the
field never comes back, so a price, a limit or an API surface taken from a web
source would rot where nothing looks. That is precisely the class the search
duty in `global.md` was written for, and it would have been the class with no
clock.

**`verified` with a `## Verified` section naming the source and the read date
(rejected).** It answers the reader who sees a date and looks for what explains
it. It was rejected because the section is defined as the result and the exact
command, and a read has neither; what it would hold is the link that already
stands two lines up, which is the collected list again under another heading.

## Consequences

- The two networking notes are compliant as written and are not touched. The
  contract moved to them.
- A note may carry `verified` without a `## Verified` section. The contract's
  `verified` bullet, which coupled the two, now says where they come apart and
  makes the oldest aging claim the note's date.
- The sentence that called `## Not verified` "the only other section the
  contract names" was wrong about `## Related` before this decision and would
  have been wrong twice after it. It now names the three sections it has.
- The boundary between Proof and source is explicit. Where the thing in question
  can be exercised, `global.md` puts the command first, and a citation is not a
  way out of running it. `media-imv-keybindings.md` is the case that stays as it
  is: documentation-sourced, locally checkable, and carrying the gap section
  that says which part was not shown.
- `global.md` prefers a primary source and permits a reliable secondary source
  only where no suitable primary one is available and the answer says why.
