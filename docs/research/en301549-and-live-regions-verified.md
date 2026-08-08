# Research — the EAA standards chain, live-region support, SPA focus

**Date:** 2026-08-08
**Method:** ETSI's published PDFs read directly (curl is blocked by an anti-bot page; both were
pulled with a real browser download), plus rendered W3C and practitioner sources.

This closes the two items `ACCESS.md` marked *not established in this pass* — §12's EN 301 549
version and §7's screen-reader support table — and re-dates the one that survives the recheck.

---

## 1. EN 301 549 — and the chain does not lead where the plugin assumed

**Directory:** `https://www.etsi.org/deliver/etsi_en/301500_301599/301549/`

| Directory | File | Cover page reads |
|---|---|---|
| `03.02.01_60` (2021-03-19) | `en_301549v030201p.pdf` | **EN 301 549 V3.2.1 (2021-03) — HARMONISED EUROPEAN STANDARD** |
| `04.01.00_20` (2025-11-12) | `en_301549v040100ev.pdf` | earlier draft |
| `04.01.00_30` (2026-06-24) | `en_301549v040100va.pdf` | **Final draft EN 301 549 V4.1.0 (2026-06) — HARMONISED EUROPEAN STANDARD** |

There is no `04.01.00_60`. **V3.2.1 is the latest published edition. V4.1.0 is a final draft.**

### Which WCAG each edition carries

**V3.2.1:** "NOTE 1: The present document reflects the content of the W3C **WCAG 2.1**
Recommendation [5]." The copyright clause is scoped the same way: "The WCAG 2.1 [5] content
referenced in clauses 9, 10 and 11..."

**V4.1.0**, in its list of changes: "the requirements of clauses 9, 10 and 11 have all been
updated to align with the **WCAG 2.2** recommendation [4]."

### Which Directive each edition maps to — this is the part that was assumed wrong

V4.1.0's foreword states the whole history in two paragraphs:

> EN 301 549 (V3.2.1) was prepared under the Commission's standardisation request C(2017)2585
> final to provide, in additions to its other uses, one voluntary means of conforming to the
> essential requirements of **Directive (EU) 2016/2102** on the accessibility of the websites
> and mobile applications of public sector bodies. The minimum requirements of the European Web
> Accessibility Directive (Directive (EU) 2016/2102) are explicitly detailed in Annex ZA of the
> present document.
>
> The present document has been prepared under the Commission's standardisation request
> C(2022) 6456 final to provide one voluntary means of conforming to the essential requirements
> of **Directive (EU) 2019/882** on the accessibility requirements for products and services.
> The minimum requirements of Directive (EU) 2019/882 are explicitly detailed in **Annex ZB**.
>
> **Once the present document is cited in the Official Journal of the European Union** under that
> Directive, compliance with the normative clauses of the present document given in the tables in
> clause A.2 confers, within the limits of the scope of the present document, a **presumption of
> conformity** with the corresponding essential requirements of that Directive and associated
> EFTA regulations.

V4.1.0's introduction: "developed in response to standardisation request **M 587** ... It is a
revision of the EN 301 549 (V3.2.1) that was initially prepared in response to Mandate M 554."

V3.2.1's own foreword names only the Web Accessibility Directive: "Once the present document is
cited in the Official Journal of the European Union under **Directive 2016/2102**..." and its
Annex A tables identify the requirements applicable to that Directive. **V3.2.1 contains no EAA
annex.**

New in V4.1.0: Annex ZA (2016/2102, updating V3.2.1's Annex A), **Annex ZB (2019/882, five
tables — ZB.1–ZB.3 products, ZB.4 all services, ZB.5 specific services)**, Annex ZC (other
directives per 2019/882 Annex I Section VI), and a new clause A.2 for evaluating conformance of
specific ICT products and services with the EAA's essential requirements.

### The finding, stated plainly

As of **2026-08-08**:

1. The EAA has applied since **28 June 2025** (already verified in `ACCESS.md` §12).
2. The harmonised standard that maps to the EAA — V4.1.0, Annex ZB — is a **final draft**, not a
   published EN, and therefore not yet citable in the Official Journal under that Directive.
3. The **published** harmonised standard, V3.2.1, carries **WCAG 2.1** and maps to the *Web
   Accessibility Directive* (public-sector bodies), not the EAA.

So the EU chain today runs: EAA in force → **no published harmonised standard mapping to it** →
the standard everyone reaches for instead carries WCAG 2.1. WCAG 2.2 enters the EAA chain only
when V4.1.0 is published and cited.

This does not change the plugin's design target and it explains it. `ACCESS.md` §1 targets **WCAG
2.2 AA**, which is *stricter* than the current EU legal floor and forward-compatible with the
draft that is coming. That is the correct direction to be wrong in, and it is now a stated
position rather than an accident.

**Still open here:** whether V4.1.0 has been cited in the Official Journal since 2026-06
(EUR-Lex was not read this pass); whether any national transposition names a WCAG version
directly; territorial scope of the EAA for non-EU sellers. All three remain unestablished.

---

## 2. Live regions — the support table `ACCESS.md` said it did not have

**Source and tier.** `a11ysupport.io/tech/aria/aria-live_attribute` — practitioner test data,
**not a specification**, and the site says so twice: "This website does not attempt to establish
a standard for how assistive technologies must behave", and a caution that "Results across all
tests for this feature range from **4 years ago to 6 years ago**. ... Failing or partial results
may be out of date." Feature-level rating: **partial, 38/44**.

| Expectation | JAWS (Cr/Ed/FF) | Narrator (Ed) | NVDA (Cr/Ed/FF) | Orca (FF) | TalkBack (Cr) | VO iOS | VO macOS |
|---|---|---|---|---|---|---|---|
| MUST announce changes to the live region | ✓ ✓ ✓ | ✓ | ✓ ✓ ✓ | ✓ | ✓ | ✓ | ✓ |
| MUST convey `off` by not announcing | ✓ ✓ ✓ | ✓ | ✓ ✓ ✓ | ✓ | ✓ | ✓ | ✓ |
| MUST convey `polite` by not interrupting | ✓ ✓ ✓ | ✓ | ✓ ✓ ✓ | ✓ | ✓ | ✓ | **none** |
| MUST convey `assertive` by interrupting | **none ×3** | ✓ | ✓ ✓ ✓ | **none** | **none** | ✓ | ✓ |

Two rows carry the finding:

- **`assertive` does not interrupt in JAWS (all three browsers), Orca, or TalkBack.** The
  attribute is set, the region announces, but the interruption — the entire reason a designer
  reaches for `assertive` — does not happen. Designing an urgent message on the assumption that
  it will cut through is designing on a behavior a large share of users will not get.
- **`polite` does not reliably avoid interrupting in VoiceOver on macOS.** The gentler value is
  not uniformly gentle either.

This is exactly what `ACCESS.md` §7 already says at the spec level — the politeness values are
"a strong suggestion" that "may be overridden by user agents, assistive technologies, or the
user" — now with observed data behind it and its age on the label. The design conclusion does
not change; its force does. **Urgency that only exists in an `aria-live` value is urgency that
may never be delivered.** If something must be noticed, it needs a second channel — focus moved
to it, or a modal that takes focus by contract.

**The other §7 item, re-checked and still unestablished.** The widely repeated rule that a live
region must exist in the DOM before content is injected into it was searched again in WAI-ARIA
1.2 on 2026-08-08. Every occurrence of "live region" in the rendered spec was examined and none
states a DOM-presence requirement. The marker stands, now re-dated rather than inherited.

---

## 3. SPA route-change focus — consensus, and it is still not a specification

`ACCESS.md` §6 already establishes the important half from primary sources: the obligation
applies (the focused element is removed), and **no W3C normative text specifies the
destination**. That finding is unchanged; nothing in this pass contradicts it, and no source was
found that turns it into a spec question.

What can be added is the shape of the practitioner answer, and it is **CRAFT** — labeled, and
never to be cited as a standard. The options that actually get used, with what each costs:

| Destination | What the user gets | What it costs |
|---|---|---|
| The new page's `<h1>`, made programmatically focusable | The page title is announced; Tab continues into the content | A focus ring appears on a heading, which needs designing rather than suppressing |
| A wrapper or `<main>` landmark | Announces the region; Tab starts at the top of content | Some screen readers announce little more than "main" |
| A visually-hidden live region announcing the route | Nothing visual changes | Inherits every reliability problem in §2 above, and leaves the Tab position wrong |
| Nothing — the router's default | Focus falls to `<body>` | The next Tab starts in browser chrome and nothing is announced |

The last row is the default in most routers and is the one `ACCESS.md` already names as a
complete `§15` failure that no automated checker reports. The first two are the real choice.

The rule the plugin ships stays what it was — **choose once, apply to every route, record it in
`DIRECTION.md`, and verify by navigating and pressing Tab** — with one addition earned by §2:
if the choice is the live-region row, it is the weakest of the four and it should be chosen
knowing that.
