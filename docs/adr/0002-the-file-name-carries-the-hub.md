# The file name carries the Hub

Notes are found with `ffd`, which is `fd` piped into fzf and therefore matches
paths and file names, never frontmatter. A Note's Hub is duplicated into its
file name for exactly that reason: `disk-management-memory-usage.md` with the
title `Disk Management: Memory Usage`. Typing `disk` in fzf narrows to the
subject, typing `dmemu` lands on the Note, and the Hub works as a namespace
without a single folder.

Because the prefix already carries the context, the rest of the name stays
short. `virtualization-docker-libvirt-nat.md` rather than
`virtualization-docker-breaks-libvirt-vm-nat.md`. The file name is still the
title as an ASCII slug, which is what marksman needs to resolve wiki links.

## Consequences

- Renaming a Hub renames its children's files. Obsidian moves wiki links along,
  file names it does not.
- The Hub is stored twice, in the name and in `topic`. Accepted, because one
  skill writes both in one step and neither is ever edited alone.
- Moving a Note to another Hub is therefore not Capture's job: it would have to
  rewrite `topic`, rename the file, carry the incoming links and delete the old
  path in a Vault without version control. Capture names the better Hub in one
  line and leaves the move to Obsidian, where renaming a file updates all the
  links to it: <https://obsidian.md/help/Files+and+folders/Manage+notes>.
