# A bare note names no other topic

ADR 0043 had a bare `/note` name every other topic the session produced in one
line, unless it was already named. The same review that found the open cases
found it left open whether that line is the `notizwuerdig` line `global.md`
allows once, so one agent can fold the two into one line and another write both.

The line is gone. A bare `/note` captures the last topic and says nothing about
the others. `notizwuerdig` is the one place an agent points at something worth
keeping.

## Considered Options

**Keeping the line as ADR 0043 decided (rejected).** It keeps a second topic
from being lost when I type `/note` once. It was rejected because `global.md`
already gives exactly one such pointer, and a second one in the skill is the
follow-up that sentence rules out.

## Consequences

- ADR 0043 stands otherwise: one bare `/note` is one topic, and arguments naming
  several get the split named.
