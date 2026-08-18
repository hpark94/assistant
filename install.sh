#!/usr/bin/env bash
# Symlink global.md and the note, draft and deep-search skills into place, for
# Claude and Codex. Idempotent. Links are relative, so they survive a different
# user name or a moved home. Missing tools are reported, never installed.
set -euo pipefail

repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
refused=0

link() {
  local target=$1 name=$2 dir rel
  dir=$(dirname -- "${name}")
  mkdir -p -- "${dir}"
  rel=$(realpath --relative-to="${dir}" -- "${target}")

  if [[ -L ${name} ]]; then
    if [[ $(readlink -- "${name}") == "${rel}" ]]; then
      printf '  ok    %s\n' "${name/#${HOME}/\~}"
      return
    fi
  elif [[ -e ${name} ]]; then
    printf '  KEEP  %s exists and is not a symlink; move it away, then rerun\n' \
      "${name/#${HOME}/\~}" >&2
    refused=1
    return
  fi

  ln -sfn -- "${rel}" "${name}"
  printf '  link  %s -> %s\n' "${name/#${HOME}/\~}" "${rel}"
}

printf 'Links:\n'
link "${repo}/global.md" "${HOME}/.claude/CLAUDE.md"
link "${repo}/global.md" "${HOME}/.codex/AGENTS.md"
for skill in note draft deep-search; do
  link "${repo}/skills/${skill}" "${HOME}/.claude/skills/${skill}"
  link "${repo}/skills/${skill}" "${HOME}/.agents/skills/${skill}"
done

# The skills call prettier, python3 and rg in their preview and lookup steps. A
# missing one fails in the middle of a capture with an error that does not say
# why, so name it here instead. No skill calls ffd; the naming rules exist for
# it, so a missing one only makes the notes harder to find. Installing them is
# mise's and dots' job, not this repo's.
printf '\nTools:\n'
for tool in prettier python3 rg ffd; do
  if command -v "${tool}" >/dev/null 2>&1; then
    printf '  ok    %s\n' "${tool}"
  else
    printf '  MISS  %s\n' "${tool}"
  fi
done
if python3 -c 'import yaml' >/dev/null 2>&1; then
  printf '  ok    python3 yaml\n'
else
  printf '  MISS  python3 yaml\n'
fi

exit "${refused}"
