# The word decides between delete and archive

ADR 0025 settled that "the reason decides, not the word": what no longer belongs
in the knowledge is archived, and a command deletes. The rewrite after the
three-reader review turned that into "what I command deleted is deleted,
whatever reason the command gives", and the second review round found the new
sentence contradicting 0025 with no successor. The rewrite had rested on a
summary of 0025 that got it wrong.

The word now decides. "Delete" deletes and "archive" archives, whatever reason
comes with it, and neither is read as the other. A delete reaches any file I
name outside `archive/` and `.trash/`; an archiving reaches a Note only. This
replaces 0025's rule; its rejection of reading every deletion command on a note
as an archiving stands and is now the rule itself. It also overrides ADR 0020's
rejection of deleting instead of archiving: a reason that fits archiving no
longer turns a delete into one.

## Considered Options

**The reason decides, as ADR 0025 had it (rejected).** "Lösch X, die ist
veraltet" names a reason that fits archiving, and the agent would archive. It
was rejected because I say "archivieren" when I mean it, and an agent that
weighs the reason makes two readings of one command possible again.

## Consequences

- An agent never proposes the other act because of a reason it heard.
- A Hub or a Draft has no archiving route, which `global.md` now says by
  limiting archiving to a Note.
