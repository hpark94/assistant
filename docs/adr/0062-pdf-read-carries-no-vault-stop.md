# pdf-read carries no vault stop

The pdf-read skill stopped before reading a PDF whose map would fall inside
`~/projects/vault`, and its repairs of an existing map were limited to maps
outside it. ADR 0033 rested on that: the map file is outside the vault, so
writing it is ordinary work. I never run pdf-read on a PDF in the vault.

The stop and the two "outside the vault" limits are gone. A map inside the vault
is a write under Writing to the Vault in `global.md`, which allows it only on my
command, and on a permission `global.md` wins over any skill.

## Considered Options

**Keeping the stop (rejected).** It stops before a single page is read, where
`global.md` alone only stops the write, possibly after the whole PDF was read.
It was rejected because the case does not occur, and three sentences of a skill
guarding a case that does not occur are the surface the load time rule exists to
cut.

## Consequences

- Should a vault PDF ever be opened, the reading may be wasted before the write
  is refused. That is the price of the cut.
- ADR 0033's statement that the map lies outside the vault now holds by use and
  not by a rule in the skill.
