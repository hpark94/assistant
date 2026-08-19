#!/usr/bin/env bash
# Symlink global.md and the note, draft and deep-search skills into place, for
# Claude and Codex. Idempotent. Links are relative to what the home and this
# repo have in common, so a renamed user survives, and a moved home survives
# while the repo moves with it. A link that points somewhere else is replaced and
# said so, because a silent one would take a deliberate override with it.
# Missing tools are reported, never installed.
set -euo pipefail

repo=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
refused=0

link() {
  local target=$1 name=$2 dir rel err old=
  dir=$(dirname -- "${name}")
  if ! err=$(mkdir -p -- "${dir}" 2>&1); then
    printf '  %-6s %s: %s\n' KEEP "${name/#"${HOME}"/\~}" "${err#mkdir: }" >&2
    refused=1
    return
  fi
  rel=$(realpath --relative-to="${dir}" -- "${target}")

  if [[ -L ${name} ]]; then
    old=$(readlink -- "${name}")
    if [[ ${old} == "${rel}" ]]; then
      printf '  %-6s %s\n' ok "${name/#"${HOME}"/\~}"
      return
    fi
  elif [[ -e ${name} ]]; then
    printf '  %-6s %s exists and is not a symlink; move it away, then rerun\n' \
      KEEP "${name/#"${HOME}"/\~}" >&2
    refused=1
    return
  fi

  if ! err=$(ln -sfn -- "${rel}" "${name}" 2>&1); then
    printf '  %-6s %s: %s\n' KEEP "${name/#"${HOME}"/\~}" "${err#ln: }" >&2
    refused=1
    return
  fi
  if [[ -n ${old} ]]; then
    printf '  %-6s %s -> %s, was %s\n' relink "${name/#"${HOME}"/\~}" "${rel}" "${old}"
  else
    printf '  %-6s %s -> %s\n' link "${name/#"${HOME}"/\~}" "${rel}"
  fi
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
#
# The MCP tools deep-search needs are deliberately not checked. Both agents do
# expose them, `codex mcp list` from config.toml and `claude mcp list` over the
# network, but the check would have to name the server, and ADR 0009 keeps the
# vendor out of everything but the skill that calls it.
printf '\nTools:\n'
for tool in prettier python3 rg ffd; do
  if command -v "${tool}" >/dev/null 2>&1; then
    printf '  %-6s %s\n' ok "${tool}"
  else
    printf '  %-6s %s\n' MISS "${tool}"
  fi
done
if python3 -c 'import yaml' >/dev/null 2>&1; then
  printf '  %-6s python3 yaml\n' ok
else
  printf '  %-6s python3 yaml\n' MISS
fi

exit "${refused}"
