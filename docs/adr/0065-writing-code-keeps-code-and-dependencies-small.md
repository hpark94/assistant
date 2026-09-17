# Writing code keeps code and dependencies small

Ponytail, https://github.com/DietrichGebert/ponytail as of 2026-09-17, is a
third-party ruleset that makes a coding agent write the least code that works.
It is not installed on this system. I wanted its preference for little code and
few external libraries in every project, without a failure that had shown up
yet.

`global.md` now has a `Writing code` section with three rules: a new external
dependency waits for my yes, new code is looked for first in the codebase, the
standard library, the platform and the installed dependencies, and no
abstraction nobody asked for. They are how work gets done in a project, so a
project's own file overrides them under the existing precedence.

## Considered Options

**Installing the ponytail plugin (rejected).** It injects its ruleset through
Node hooks into every prompt and subagent, writes `~/.config/ponytail/` and can
add a `statusLine` to `~/.claude/settings.json`. It was rejected because it is a
normative surface outside this repo that changes on its own schedule and does
not hold the same way for both agents.

**The rules as a boundary that holds against the project (rejected).** It was
rejected because a taste for little code is not protection from harm, and a
second exception next to the Vault would cost the precedence clause its
simplicity.

**Ponytail's other parts (rejected).** Its never-cut list for validation,
security and data loss counterweights an aggressive cut this file does not make.
Marked shortcut comments and a required runnable check are working methods a
project gives itself. The `lite`, `full` and `ultra` levels need plugin commands.

**Moving the YAGNI line into the new section (rejected).** It holds for
everything written, notes and drafts and this repo included, and in the code
section it would read as code only and fall under the project's precedence.

## Consequences

- The benchmark ponytail publishes was not taken as a reason: one model, n=4,
  run by its author.
