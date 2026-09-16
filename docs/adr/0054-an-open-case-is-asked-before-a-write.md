# An open case is asked before a write

A review with two Codex readers and one fresh agent found a dozen cases the
instruction files leave open: which date `verified` takes beside an unverified
claim, what counts as a claim, what a successor draft carries over, a page range
out of bounds, what counts as a search, when a map is reusable. Each one lets
two careful agents act differently.

`global.md` now says once that a case these files leave open is asked about and
never guessed where the answer decides a write, and that the agent chooses where
it decides only a read. Only the one case no agent notices before it writes got
words of its own: a deletion moves with `mv -n`, and a name already in `.trash/`
stops it.

## Considered Options

**Settling every case where it arises (rejected).** It gives every agent the
same answer. It was rejected because each answer is a sentence in a file that
was just measured for carrying too many, and the next review finds the next open
case: the list does not end.

**Leaving them to judgement (rejected).** It costs nothing. It was rejected
because two agents that guess differently before a write leave different files
in a vault with no version control, and nothing reports which guess was made.

## Consequences

- A difference between agents that only a read shows is accepted.
- An open case that no agent notices is not covered by the rule. Where one turns
  up, it gets words of its own, as the bin collision did.
