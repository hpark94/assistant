# The paper search is a mode of deep-search

I wanted a search that answers from research papers and nothing else. Exa keeps
an index of papers, reached through `web_search_advanced_exa` with
`category: "publication"`. The MCP schema offers that category and `pdf`, and no
`research paper`. One call with a question about long-context attention returned
seven papers, most of them as `exa.ai/library/publication/...` entries carrying
the abstract, DOI, authors, year, a `type` such as `preprint` and a citation
count, which was `null` for several recent ones.

The answer has the shape of a Deep Search answer, only from another pool, so
`deep-search` gains `--papers` instead of a sibling skill. Every search in that
mode goes to the publication index. The abstract picks and the full text is
read; where no full text is reachable the abstract stands, marked
`abstract only`. Preprints count and are marked. A claim links to the DOI. The
ceiling drops to 12 full texts, a reader takes at most three papers per round,
and an empty index is reported rather than replaced by the open web.

Two facts set the reader limit and the ceiling. A paper is long:

```sh
for id in 2310.05869 2402.02244 1901.02860; do printf '%s ' $id; curl -sL "https://arxiv.org/pdf/$id" | pdftotext - - | wc -c; done
```

gave 51791, 65090 and 88054 characters. And `web_fetch_exa` delivers all of it:
a fresh sub-agent fetched `https://arxiv.org/pdf/2310.05869` with
`maxCharacters: 120000` and measured 50474 characters ending in the last line of
the last proof on page 19. That fetch is recorded from a running session and is
not a command that can be re-run as it stands.

## Considered Options

**A separate `paper-search` skill (rejected).** It would keep `deep-search`
untouched. It was rejected because a skill stands on itself and `global.md`, so
it would carry the whole loop, the delegation, the load line and the ceiling a
second time, and every later change to one would be a disagreement with the
other.

**Searching with `includeDomains` on arXiv, ACL Anthology and the like beside
the index (rejected).** It reaches full texts the index does not list. It was
rejected for the reason ADR 0018 gives for one engine: with two search sources a
paper that never turned up could be one nobody wrote or one that sat in the
other half, and saturation stops being countable. A full text is reached by
fetching what an index entry points to, which needs no second search.

**The abstract as the source (rejected).** It is cheap and the index carries it
already. It was rejected because limitations, method and numbers stand in the
paper and not in its abstract, and an answer resting on abstracts reads as
deeper than it is. The abstract stays as a marked fallback where the paper is
behind a paywall.

**Peer-reviewed work only (rejected).** In fast fields the relevant work is
often only a preprint, so the filter would drop it. Marking it keeps its weight
visible instead.

**The same ceiling of 24 full texts (rejected).** A paper is many times a web
page, and a question that needs more than twelve of them is too broad, which is
what the brake is there to show.

**Reading only the relevant sections of a paper (rejected).** Knowing which
section is relevant takes reading the paper, so the filter is the reading
itself.

**Falling back to the open web when the index yields nothing (rejected).** The
flag said papers only, and a silent change of pool would hide the absence that
is the answer.

**Citation counts on the claim (rejected).** The index has none for many recent
entries, so a count beside one paper and none beside another weighs by a gap.

## Consequences

- Only `skills/deep-search/SKILL.md` changes. Its `description` names the flag,
  because the description is the one part Codex reads, and the trigger sentences
  stay as they are.
- The skill now names a link target and two markers for a claim. The citation
  form itself, a Markdown link on the sentence, stays in `global.md`, so the
  split ADR 0009 made holds.
