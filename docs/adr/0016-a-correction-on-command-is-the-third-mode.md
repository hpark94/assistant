# A correction on command is the third mode

`global.md` sends a correction to an existing Note outside a capture to the note
skill, "its preview and mechanics from the skill", and says of itself that it
does not repeat their procedures. The skill had no place to receive it. Its head
announced two modes, both captures, and its procedure opened with "Identify the
last self contained topic, not the whole session", which is a session and not a
file. Everything a correction needs was already in the file, the hit branch of
step 2 that corrects what is now wrong and bumps `updated`, the preview of the
changed passages in step 5, the format step and the report. What was missing was
the door.

The same gap had a second half. A note's hub is stored twice, in `hub` and as
the prefix of its file name, so moving a note is a rename plus a frontmatter
edit and belongs in Obsidian, where the rename carries the incoming wiki links
along. The skill says so absolutely, "Its hub is the one thing you never
correct" and "Never offer and never run `mv` on a note", but it says it inside
step 2 and phrases the answer for a capture: "if the content you are adding
would have gone under a different hub as a new note, say so in one line". A
commanded move adds no content, so the answer did not fit the question, and
`global.md` had meanwhile settled that a trigger never narrows what an explicit
command means.

Both halves are one door. The head names a third mode, a correction I command to
a note that already exists, and that mode says where it enters the procedure and
which two things it hands back instead of doing them.

## Considered Options

**A clause in the hit branch of step 2 (rejected).** It is the smallest diff and
it puts the sentence where the work happens. It was rejected because the file
would still open by claiming there are two modes and both are captures. An agent
that reads the head and then works the procedure never reaches the clause with
the right question in mind, and a file that is wrong in its own summary is wrong
in the place it is read first.

**Putting hub immutability in the Note contract, or in `CONTEXT.md`
(rejected).** The hub not moving is a property of a Note rather than of a mode,
and the contract's `hub` bullet is where a reader looks. It was rejected because
the reason lives with the mechanism: Obsidian's rename against `mv`, and four
devices with no version control behind them. Moving the rule to the contract
either strands it from that reason or copies it, and `CONTEXT.md` would on top
reopen what ADR 0011 settled about which prohibitions may stand there, for a
case whose operation the skill already owns.

**A section of its own for the non-capture case (rejected).** It reads as the
tidy answer: corrections are not captures, so they get their own place. It was
rejected because that place would have to carry the frontmatter check, the
preview rules, the format step and the report a second time. ADR 0012 rejected
the same duplication one file further up, and the argument does not weaken
inside a single file.

## Consequences

- The head of the skill says three and the procedure is untouched. Step 2 keeps
  its capture wording, which is correct there, and the third mode points into
  it.
- A commanded hub move now has an answer, and it is the same answer as a noticed
  one. The one line that names the better hub is no longer tied to content being
  added.
- `global.md`'s routing lands somewhere. What it promised the skill owns, the
  skill now visibly owns.
