# The figure mark uses a fixed count and not one relative to the document

ADR 0033 settled that figures on the text route are marked and not read. It did
not settle what triggers the mark. `pdf-read` marks a page from 12 drawing
operations upwards, a fixed number that does not adapt to the document. The
first thing anyone notices about that number is that it marks 82 % of a
typesetting-heavy textbook, which reads as a broken threshold, and the fix that
suggests itself is to scale it to the document. That was tried and it fails, in
a way the marked share alone cannot show.

## Considered Options

**A threshold relative to the document, `max(12, 3 × median)` (rejected).** Page
furniture varies enormously between documents: the measured median drawing count
per page was 0 for one database textbook, 2 and 6 for two lecture scripts, and
76 for an engineering textbook whose every page carries rules, boxes and table
lines. Against a fixed 12 the shares marked were 30 %, 12 %, 43 % and 82 %, and
82 % looks like a marker that says nothing. The relative form brought that last
one to 7 %.

It was rejected by ground truth. Twenty-four systematically sampled pages of the
engineering textbook were rendered and looked at: 21 of them carry a figure. The
book really does have a circuit diagram on nearly every page, so 82 % was the
right answer and the relative threshold, which lands at 228 there, found 3 of
the 21. Recall 14 %. The marked share is not evidence about a detector; only
labelled pages are, and the inference from share to quality was the actual
error.

Across three documents and 72 labelled pages the fixed 12 found all 44 figure
pages with 4 false alarms, all of them pages of ruled tables. Recall 100 %,
precision 92 %.

**Marking from the text instead, on `Abbildung`, `nebenstehend` and the like
(rejected).** It costs nothing, since the reader has the page's text in front of
it on the text route, and it needs no threshold at all. It was rejected at 31 %
recall: 5 of 16 figures on the sampled script, because a figure set beside a
paragraph is frequently never named in it. It also found nothing the drawing
count missed, so it does not earn a place as a second channel either.

**Counting raster images only, with `pdfimages -list` (rejected).** It is the
obvious tool and needs no trace parsing. It was rejected because figures in
TeX-set documents are vector paths, not images: `pdfimages` finds one single
image in the whole 398-page engineering book and ten pages in a 372-page script
that has figures on 185.

## Consequences

- The mark is `fill_path` plus `stroke_path` plus 30 times `fill_image`, from 12
  upwards, and the number does not move with the document.
- False alarms are accepted and false negatives are not. A superfluous mark
  costs a word in the map; a missed figure is invisible for good, which is the
  failure the mark exists against.
- The share of pages a document gets marked carries no information about whether
  the marking is right. A future doubt about the threshold has to be settled
  with labelled pages, the way this one was.
- `mutool` is a dependency of the skill, and `install.sh` reports it missing.
