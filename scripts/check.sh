#!/usr/bin/env bash
# inter.face integrity checks. No deps beyond coreutils + jq.
set -uo pipefail
cd "$(dirname "$0")/.." || exit 1
FAIL=0
fail() { printf '  FAIL: %s\n' "$1"; FAIL=1; }
ok()   { printf '  ok: %s\n' "$1"; }

echo "== placeholder scan =="
# The deep-research harness once returned a literal "test claim" / example.com
# stub that passed schema validation. Never let that reach a shipped file.
HITS=$(grep -rniE 'example\.com|\bTBD\b|\bTODO\b|Lorem ipsum|test claim|FIXME|XXX' \
  --include='*.md' --include='*.json' --include='*.mdc' . \
  2>/dev/null | grep -v '^\./docs/' | grep -v '^\./\.git' | grep -v '^\./\.superpowers/' || true)
if [ -n "$HITS" ]; then fail "placeholder text in shipped files:"; echo "$HITS" | sed 's/^/    /'
else ok "no placeholders"; fi

echo "== resident budget =="
if [ -f AGENTS.md ]; then
  N=$(wc -l < AGENTS.md | tr -d ' ')
  [ "$N" -le 200 ] && ok "AGENTS.md ${N} lines (<=200)" || fail "AGENTS.md ${N} lines, budget 200"
else fail "AGENTS.md missing"; fi

echo "== json validity =="
for f in .claude-plugin/plugin.json .claude-plugin/marketplace.json \
         .codex-plugin/plugin.json gemini-extension.json opencode.json; do
  if [ -f "$f" ]; then
    jq empty "$f" 2>/dev/null && ok "$f parses" || fail "$f is not valid JSON"
  else fail "$f missing"; fi
done

echo "== skill frontmatter =="
for f in skills/inter.face/SKILL.md commands/interface.md .cursor/rules/inter.face.mdc; do
  if [ -f "$f" ]; then
    head -1 "$f" | grep -q '^---$' && ok "$f has frontmatter" || fail "$f missing opening ---"
  else fail "$f missing"; fi
done

echo "== internal links resolve =="
BROKEN=0
while IFS= read -r line; do
  src=${line%%:*}; target=${line#*:}
  dir=$(dirname "$src")
  [ -e "$dir/$target" ] || { fail "broken link in $src -> $target"; BROKEN=1; }
done < <(grep -rhoE '\]\(\.{1,2}/[^)#]+\)' --include='*.md' . 2>/dev/null \
         | grep -v '^\./docs/' >/dev/null 2>&1; \
         grep -rnoE '\]\((\.{1,2}/[^)#]+)\)' --include='*.md' . 2>/dev/null \
         | grep -v '/docs/' | grep -v '/\.superpowers/' | sed -E 's/^([^:]+):[0-9]+:\]\((.*)\)$/\1:\2/')
[ "$BROKEN" -eq 0 ] && ok "all relative links resolve"

echo "== every reference file forks on surface class =="
for f in STYLES.md CRAFT.md TOOLS.md SURFACES.md ACCESS.md; do
  if [ -f "$f" ]; then
    if grep -qiE 'page-shaped' "$f" && grep -qiE 'tool-shaped' "$f"; then
      ok "$f forks on surface class"
    else fail "$f does not address both page-shaped and tool-shaped"; fi
  else fail "$f missing"; fi
done

echo "== Apple numbers ship as pairs =="
if [ -f SURFACES.md ]; then
  if grep -qE '(44.*28|28.*44)' SURFACES.md || (grep -q '44×44\|44pt' SURFACES.md && grep -q '28×28\|28pt' SURFACES.md); then
    ok "SURFACES.md carries default AND minimum"
  else fail "SURFACES.md must carry 44pt default AND 28pt minimum, never 44 alone"; fi
else fail "SURFACES.md missing"; fi

echo
[ "$FAIL" -eq 0 ] && echo "ALL CHECKS PASS" || echo "CHECKS FAILED"
exit "$FAIL"
