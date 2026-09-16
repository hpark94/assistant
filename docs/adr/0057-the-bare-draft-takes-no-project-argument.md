# The bare draft takes no project argument

`/draft dots: <subject>` split project and subject at a colon, and every draft
title carries a colon, `Routing Lab: OSPF Metrics`. The same review found that
`/draft Routing Lab: OSPF metrics` reads as project `routing-lab` to one agent
and as a subject to another.

The bare form now takes only a subject, and the project always comes from the
git root or the working directory, as ADR 0040 and 0047 settled.
`/draft --open dots` keeps its project argument, which holds nothing else.

## Considered Options

**A single-word project before the colon (rejected).** It keeps naming another
project from anywhere. It was rejected because a one-word title prefix reads the
same way, and the preview already shows the project where correcting it costs
one word.

**A flag for the project (rejected).** `--project dots` has no colon to collide
with. It was rejected because it adds syntax for what one word in the preview
already does.
