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
# 200 through v0.2, when the router routed two loops and five agents. v0.3 added a
# third loop, a third gate, a sixth agent, the inbox and the close, and the router
# has that much more to route. Raised to 220 rather than paid for by deleting the
# routing table's reasons — but raised by 20, not removed: this file is resident in
# every context and the budget is the only thing that keeps it a skeleton.
if [ -f AGENTS.md ]; then
  N=$(wc -l < AGENTS.md | tr -d ' ')
  [ "$N" -le 220 ] && ok "AGENTS.md ${N} lines (<=220)" || fail "AGENTS.md ${N} lines, budget 220"
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

echo "== prose section-span counts are current =="
# Two of the routing table's counts are written in prose, not as "](./file) N",
# so the check above never sees them: ACCESS.md §13 "50 of 1,429" and
# SURFACES.md §1–§3 "250 of 772". They are the drift-prone pair — a section span
# moves whenever any section above it is edited, and SURFACES.md §4 was edited
# three times this release. A span runs from its opening "## N." to the next
# "## " heading, whatever that heading is called.
SPAN_BAD=0; SPAN_N=0
while read -r f a b span total; do
  [ -f "$f" ] || { fail "prose count names a missing file: $f"; SPAN_BAD=1; continue; }
  SPAN_N=$((SPAN_N + 1))
  TOT=$(wc -l < "$f" | tr -d ' ')
  [ "$TOT" = "$total" ] || { fail "AGENTS.md says $f is $total lines; it is $TOT"; SPAN_BAD=1; }
  START=$(grep -nE "^## ${a}\." "$f" | head -1 | cut -d: -f1)
  LAST=$(grep -nE "^## ${b}\." "$f" | head -1 | cut -d: -f1)
  if [ -z "$START" ] || [ -z "$LAST" ]; then
    fail "$f has no §${a} or no §${b}"; SPAN_BAD=1; continue
  fi
  NEXT=$(awk -v n="$LAST" 'NR > n && /^## / { print NR; exit }' "$f")
  [ -n "$NEXT" ] || NEXT=$((TOT + 1))
  ACT=$((NEXT - START))
  RANGE="§${a}"; [ "$a" = "$b" ] || RANGE="§${a}–§${b}"
  [ "$ACT" = "$span" ] || {
    fail "AGENTS.md says $f $RANGE is $span lines; it is $ACT"; SPAN_BAD=1; }
done < <(
  grep -oE '`[A-Z][A-Za-z]+\.md`[^§]{0,12}§[0-9]+(–§[0-9]+)?[^0-9]{0,16}[0-9,]+ of [0-9,]+' AGENTS.md \
  | tr -d ',`' \
  | sed -nE 's/^([A-Za-z.]+\.md)[^§]*§([0-9]+)(–§([0-9]+))?[^0-9]*([0-9]+) of ([0-9]+)$/\1 \2 \4 \5 \6/p' \
  | awk 'NF==5 { print $1, $2, $3, $4, $5 } NF==4 { print $1, $2, $2, $3, $4 }'
)
[ "$SPAN_N" -ge 2 ] || { fail "expected 2 prose 'N of M' counts in AGENTS.md, found ${SPAN_N}"; SPAN_BAD=1; }
[ "$SPAN_BAD" -eq 0 ] && ok "both prose section spans and file totals match"

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
            "loops/02-craft.md agents/craft-conductor.md" \
            "loops/03-system.md agents/system-builder.md"; do
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

echo "== the corpus total agrees with itself =="
# It is stated in six files and drifted in three of them during v0.2 — twice into
# agents/, which no other check scans. The routing-table check above catches a
# per-file count; this catches the sum.
# ponytail: four literal phrasings, not a parser. A fifth phrasing escapes it, and
# the fix is to add the phrasing here rather than to write a general one.
CORPUS=$(cat PRINCIPLES.md TRANSLATE.md STYLES.md CRAFT.md TOOLS.md SURFACES.md \
  ACCESS.md REDESIGN.md BREAKING.md IMPROVE.md loops/01-direction.md loops/02-craft.md \
  loops/03-system.md 2>/dev/null | wc -l | tr -d ' ')
CBAD=0; CN=0
while IFS= read -r hit; do
  src=${hit%%:*}; rest=${hit#*:}; lineno=${rest%%:*}
  # Compare integers, not formatted strings — BSD and GNU sed disagree on \B and \>.
  n=$(printf '%s' "${rest#*:}" | grep -oE '[0-9],[0-9]{3}' | head -1 | tr -d ',')
  [ -n "$n" ] || continue
  CN=$((CN + 1))
  [ "$n" = "$CORPUS" ] || { fail "$src:$lineno states a corpus total of $n; wc -l says $CORPUS"; CBAD=1; }
done < <(grep -rnE 'corpus is \**[0-9],[0-9]{3}|[0-9],[0-9]{3} lines across [a-z]+ reference|[0-9],[0-9]{3}-line corpus|reference files total [0-9],[0-9]{3}' \
  --include='*.md' . 2>/dev/null | grep -v '^\./docs/' | grep -v '^\./\.superpowers/' \
  | grep -v '^\./CHANGELOG\.md:')
# CHANGELOG.md is excluded on purpose. Its entries state what was true at a release —
# 6,056 across eleven files was true at v0.2 — and a changelog that renumbers itself to
# match today is no longer a record of anything.
[ "$CBAD" -eq 0 ] && ok "all ${CN} corpus-total statements match wc -l (${CORPUS})"

echo
[ "$FAIL" -eq 0 ] && echo "ALL CHECKS PASS" || echo "CHECKS FAILED"
exit "$FAIL"
