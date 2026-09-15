# A project name is slugged

ADR 0040 takes a draft's project from the git root's name. A directory called
`My_Notes` or `dots.old` fails the check's `[a-z0-9-]+`, and nothing said what
happens then: one agent slugged it, one stopped, one asked, and `--open` later
derived a string that matched none of them.

The project is now the slug of the argument or the directory name, by the same
formula as `<topic>`. A slug YAML reads as something else, `yes` or `2026`,
stops the write, and the answer says to name another project as an argument.

## Considered Options

**Stopping on every name that is not already a slug (rejected).** It never
writes a project string that differs from the directory. It was rejected because
the slug is deterministic, `--open` derives the same one, and the preview shows
it where correcting it costs one word.

**Quoting a name YAML misreads (rejected).** It keeps `yes` as a project. It was
rejected by the draft skill's own text search: a quoted `project:` line is
invisible to the `--open` lookup.
