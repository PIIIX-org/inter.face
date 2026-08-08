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
HITS=$(grep -rniE 'example\.com|\bTBD\b|\bTODO\b|Lorem ipsum|test claim|FIXME|\bXXX\b' \
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
for f in STYLES.md CRAFT.md TOOLS.md SURFACES.md ACCESS.md REDESIGN.md BREAKING.md; do
  if [ -f "$f" ]; then
    if grep -qiE 'page-shaped' "$f" && grep -qiE 'tool-shaped' "$f"; then
      ok "$f forks on surface class"
    else fail "$f does not address both page-shaped and tool-shaped"; fi
  else fail "$f missing"; fi
done

echo "== Apple numbers ship as pairs =="
if [ -f SURFACES.md ]; then
  if grep -qE '(44.*28|28.*44)' SURFACES.md; then
    ok "SURFACES.md carries default AND minimum"
  else fail "SURFACES.md must carry 44pt default AND 28pt minimum, never 44 alone"; fi
else fail "SURFACES.md missing"; fi

echo "== routing-table line counts are current =="
# These went stale three phases running. The router's budget argument is only
# worth making if its numbers are true.
LC_BAD=0; LC_N=0
while read -r f n; do
  [ -f "$f" ] || { fail "routing table names a missing file: $f"; LC_BAD=1; continue; }
  ACT=$(wc -l < "$f" | tr -d ' '); LC_N=$((LC_N + 1))
  [ "$ACT" = "$n" ] || { fail "AGENTS.md says $f is $n lines; it is $ACT"; LC_BAD=1; }
done < <(grep -oE '\]\(\./[^)]+\) [0-9]+' AGENTS.md | sed -E 's/\]\(\.\/([^)]+)\) ([0-9]+)/\1 \2/' | sort -u)
SELF=$(grep -oE 'This file [0-9]+' AGENTS.md | grep -oE '[0-9]+' | head -1)
if [ -n "$SELF" ]; then
  ACT=$(wc -l < AGENTS.md | tr -d ' ')
  [ "$ACT" = "$SELF" ] || { fail "AGENTS.md's worked example says 'This file $SELF'; it is $ACT"; LC_BAD=1; }
fi
[ "$LC_BAD" -eq 0 ] && ok "all ${LC_N} routing-table counts match wc -l"

echo "== cross-file section pointers exist =="
# The router sends a phase to "ACCESS.md §13" and an agent to "SURFACES.md §1-§3".
# A pointer at a section that was renumbered sends the reader nowhere.
PTR_BAD=0; PTR_N=0
while read -r target n; do
  [ -f "$target" ] || { fail "pointer to missing file: $target §$n"; PTR_BAD=1; continue; }
  PTR_N=$((PTR_N + 1))
  grep -qE "^## ${n}\." "$target" || { fail "$target has no §${n}"; PTR_BAD=1; }
done < <(
  grep -rhoE '[A-Z][A-Za-z]+\.md`?\*{0,2} §[0-9]+(–§[0-9]+)?' \
    AGENTS.md loops/*.md agents/*.md skills/inter.face/SKILL.md 2>/dev/null \
  | sed -e 's/[`*]//g' \
  | awk '{ f=$1; s=$2; gsub(/§/,"",s);
           if (split(s,r,"–") == 2) { for (i=r[1]; i<=r[2]; i++) print f, i }
           else print f, s }' \
  | sort -u
)
[ "$PTR_BAD" -eq 0 ] && ok "all ${PTR_N} cross-file section pointers resolve"

echo "== loop and conductor do not restate each other =="
# v1 shipped one rule in both loops/01 §10 and direction-conductor step 9. They
# drifted, and the run followed the stale copy. One sentence, one home.
DRIFT=0
for pair in "loops/01-direction.md agents/direction-conductor.md" \
            "loops/02-craft.md agents/craft-conductor.md"; do
  set -- $pair
  [ -f "$1" ] && [ -f "$2" ] || continue
  norm() { tr '\n' ' ' < "$1" | sed -e 's/[`*_>|]//g' -e 's/  */ /g' -e 's/\. /.\n/g' \
           | sed -e 's/^ *//' -e 's/ *$//' | awk 'length($0) >= 60'; }
  DUP=$(comm -12 <(norm "$1" | sort -u) <(norm "$2" | sort -u))
  if [ -n "$DUP" ]; then
    fail "$1 and $2 share verbatim sentences:"; echo "$DUP" | sed 's/^/    /'; DRIFT=1
  fi
done
[ "$DRIFT" -eq 0 ] && ok "no loop/conductor sentence is written twice"

echo
[ "$FAIL" -eq 0 ] && echo "ALL CHECKS PASS" || echo "CHECKS FAILED"
exit "$FAIL"
