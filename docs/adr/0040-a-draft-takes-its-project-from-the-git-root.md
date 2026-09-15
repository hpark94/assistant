# A draft takes its project from the git root

A review with two Codex readers and one fresh agent asked where two careful
agents act differently. The draft skill named its project three ways: "from the
working directory" for a new draft, "the directory name of the working
directory" for `--open`, and "from the conversation" where the working directory
"is not a project of mine". In `~/repos/routing-lab/src` one agent wrote
`project: src`, one `routing-lab`, and one decided `src` was no project of mine
and read the project out of the conversation. `--open` then found different
drafts for each.

The project is now the name of `git rev-parse --show-toplevel`, and outside a
repository the name of the working directory. `--open` finds it the same way,
and so does its step that decides whether the code of the working directory is
the draft's code to read.

## Considered Options

**The working directory's own name (rejected).** It is what `--open` already
used, and it never needs git. It was rejected because a subdirectory of a
repository is the ordinary place a session runs in, and the skill had to carry a
warning that the name there is wrong.

**Keeping the conversation as the fallback (rejected).** Outside a repository,
from `~` say, the project the conversation is about is usually the right answer,
where the directory gives `hpark`. It was rejected because "a project of mine"
was defined nowhere and "the project the conversation is about" is a judgement
two agents make differently. The directory gives both the same wrong name, and
the preview shows it where correcting it costs one word.

## Consequences

- In a linked worktree the name is the worktree's directory and not the main
  checkout's. Both agents get the same name, and the preview shows it.
- A directory under `~/projects` that is not a repository still gives its own
  name only from its root, and a subdirectory's name from anywhere below.
