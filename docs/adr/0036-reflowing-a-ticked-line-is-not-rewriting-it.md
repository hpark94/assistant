# Reflowing a ticked line is not rewriting it

`global.md` makes the ticked `- [x]` step an absolute and closes it with "no
command lifts this". The draft skill then carved into it: "The `prettier -w` of
step 5 is no exception to it, because rewrapping a line is not rewriting a
step." That is a skill deciding what a prohibition in `global.md` means, and
`AGENTS.md` gives a prohibition to `global.md`. A cold reader handed both files
reads an absolute in one and its exception in the other, and is told the
absolute wins.

The definition now stands where the prohibition stands.

## Considered Options

**Leaving the carve-out in the draft skill (rejected).** It had stood for months
and the sentence reads well where it is. It was rejected because a reader who
loads no skill, which is every deletion and every ordinary edit, has the
absolute without the exception and must either stop formatting or decide the
question the skill was answering.

**Keeping `prettier -w` off any file that carries a ticked line (rejected).**
Then no exception is needed at all and the absolute stays whole. It was rejected
because a draft accumulates ticks, so the rule would stop formatting exactly the
files that live longest, and both skills would need a second reason why a file
comes back unformatted beside the one they already carry.

**Dropping "no command lifts this" (rejected).** The tick could be an ordinary
strong rule and the formatter would raise no question. It was rejected because
ADR 0032 names this and the archive rule as the two absolutes these files have,
both grounded in the vault having no version control, and reopening one to fit a
formatter is the wrong trade.

## Consequences

- The draft skill's sentence now restates what `global.md` carries. Whether it
  stays is a wording question for the change that touches that file.
- The note skill runs `prettier -w` over note bodies and has never mentioned
  ticked lines. It needs no sentence, because the exception is global.
- The exception assumes a formatter that folds lines and changes no word. A tool
  that rewrote values would break the exception and not the rule.
