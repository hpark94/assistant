# assistant

This repo holds `global.md`, the instruction file both agents load in every
project, the note, draft and deep-search skills under `skills/`, the vocabulary
in `CONTEXT.md` and the decisions in `docs/adr/`. How to work with the Vault is
in `global.md` and in the skills; this file is only about changing them.

## Before you touch anything

Read `CONTEXT.md` for the vocabulary and the ADRs under `docs/adr/` that touch
your subject. `CONTEXT.md` owns meanings and structural invariants, not
authorization, procedure, ordering, tool choice or exceptions. `docs/adr/` holds
self-contained historical records of the decisions and the alternatives they
beat, not current operating policy. Both are yours to extend when a term or a
decision actually changes, never in passing.

Each rule has exactly one owner. `global.md` owns what holds in every project, a
skill owns its own operation, and neither repeats the other. A change that would
have to be made in two files is a sign that the rule is in the wrong place.

## Commands

- `./install.sh`: symlink `global.md` and the three skills into place.
  Idempotent, and it reports missing tools instead of installing them.
- `git -C ~/repos/assistant commit`: after every change in this repo, subject
  `docs(agents): what changed`. No trailing `Co-Authored-By` lines.
