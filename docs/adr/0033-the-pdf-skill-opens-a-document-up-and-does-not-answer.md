# The pdf skill opens a document up and does not answer

The skill was asked for as two things at once: summarise a PDF, or ask questions
about it. One operation was built instead. `pdf-read` produces a page map and a
summary beside the document, and every question afterwards is ordinary work that
names a page from that map. Whoever next reads the file will find a summary
sitting there and a question mode missing, and will want to add one.

## Considered Options

**A question mode inside the skill (rejected).** It is what was asked for, and
the machinery is already there: the readers, the routes, the fan-out. It was
rejected because the two regimes need different things back. A question known
beforehand wants the pages that carry the answer and nothing else, which is the
oracle-page effect the readers exist for. A question that comes later has only
what the first pass left behind. Serving both from one contract means the later
question is answered from the summary, and a summary is a lossy compression
whose omissions are invisible to the reader of the answer. The map keeps the
page numbers instead, so the later question reaches the page rather than the
description of it.

**Reading the marked figure pages eagerly (rejected).** A figure lost on the
text route is the failure that motivated the mark at all, so reading those pages
while the document is open looks like finishing the job. It was rejected on two
counts. The share of marked pages runs from 12 % to 88 % across the measured
documents, so the eager variant has no predictable cost, and on an engineering
textbook it is the whole book. And evaluating the figure is answering: the mark
says a figure is there and where, which is exactly what the map is for.

**Screenshot plus `/deep-search` instead of a skill (rejected).** For a single
slide it is cheaper than anything built here, needs no file, and was the obvious
alternative. It was rejected because `deep-search` reads the live web and not
the document: it answers what the world says about the thing on the slide, never
what the slide says. It also does not scale past one page, and a pasted image
never becomes a file, so nothing it produced could be cited or embedded later.
For the single-slide case the answer is not this skill either, it is an ordinary
question with the image attached.

**One route for every document (rejected).** A single rule would be shorter than
a measured threshold with a route table hanging off it. It was rejected because
`pdftotext` silently drops everything drawn, which loses a slide entirely, while
rendering a prose script burns tokens on a text layer that is already complete.
The two failures point in opposite directions and no single route avoids both.

## Consequences

- The skill has one operation and no modes. A follow-up question is ordinary
  work with the map in hand, and needs no contract of its own.
- The map is a file beside the PDF rather than conversation, because the reuse
  on the second day is what pays for the first pass.
- Figures on the text route are marked and not read. A question that touches a
  marked page reads that page then.
- The map file is outside the vault, so `global.md`'s vault rules do not reach
  it and writing it is ordinary work.
