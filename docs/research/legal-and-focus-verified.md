# Verified — legal enforcement, focus management, live regions, accessible names, i18n

**Date:** 2026-08-02
**Method:** rendered DOM text pulled with a headless browser from the primary source itself,
then read in context. **Not** WebFetch summaries and **not** from memory. This project has
already caught four instances of plausible-but-wrong content, including one claim that
contradicted its own cited source, so every quote below was read off the live rendered page.
`curl` is useless for most of these: EUR-Lex and the W3C TR pages are JS-rendered and return a
near-empty shell to a plain fetch.

**Why this pass exists.** Two areas returned **zero surviving claims across three separate
research-workflow attempts**: legal enforcement (`accessibility-wcag.md` finding 10 at *medium*
confidence and explicitly flagged "MUST be re-verified against the primary texts";
`native-a11y-verified.md` HALF TWO, zero claims) and SPA focus management / live regions
(`web-a11y-patterns.md` finding 8, zero claims). Law and spec sites defeat summarizers. The
browser is what works.

**The rule this file is written under:** a wrong compliance deadline in a design tool is worse
than an absent one, because someone could rely on it. Everything not verified below is named
in the final section as *not established in this pass*, and nothing there ships as fact.

Pages read:

| Source | URL |
|---|---|
| Directive (EU) 2019/882 — European Accessibility Act | `https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32019L0882` |
| DOJ — ADA Title II web rule guidance | `https://www.ada.gov/resources/2024-03-08-web-rule/` |
| US Access Board — Revised Section 508 Standards (ICT) | `https://www.access-board.gov/ict/` |
| WAI-ARIA 1.2 (Recommendation) | `https://www.w3.org/TR/wai-aria-1.2/` |
| ARIA APG — Landmark Regions | `https://www.w3.org/WAI/ARIA/apg/practices/landmark-regions/` |
| ARIA APG — Providing Accessible Names and Descriptions | `https://www.w3.org/WAI/ARIA/apg/practices/names-and-descriptions/` |
| WAI Tutorial — Functional Images | `https://www.w3.org/WAI/tutorials/images/functional/` |
| Understanding SC 3.2.6 Consistent Help | `https://www.w3.org/WAI/WCAG22/Understanding/consistent-help.html` |
| W3C i18n — Text size in translation | `https://www.w3.org/International/articles/article-text-size` |
| W3C i18n — Approaches to line breaking | `https://www.w3.org/International/articles/typography/linebreak.en` |
| Unicode CLDR — Plural Rules | `https://cldr.unicode.org/index/cldr-spec/plural-rules` |

The ADA page carries a dateline of **April 08, 2024** with the April 2026 extension folded into
its opening paragraph. EUR-Lex serves the consolidated directive text. W3C pages carry a 2026
copyright line.

---

## 1. The European Accessibility Act — Directive (EU) 2019/882

### The dates, verbatim from Article 31

> 1.   Member States shall adopt and publish, by 28 June 2022, the laws, regulations and
> administrative provisions necessary to comply with this Directive. They shall immediately
> communicate the text of those measures to the Commission.
>
> 2.   They shall apply those measures from **28 June 2025**.
>
> 3.   By way of derogation from paragraph 2 of this Article, Member States may decide to apply
> the measures regarding the obligations set out in Article 4(8) at the latest from 28 June 2027.

Article 2 scopes the same date to the goods and services themselves — products "placed on the
market **after 28 June 2025**", services "provided to consumers **after 28 June 2025**".

**Article 32 is the part almost every summary drops.** There is a long transitional tail:

> Member States shall provide for a transitional period ending on **28 June 2030** during which
> service providers may continue to provide their services using products which were lawfully
> used by them to provide similar services before that date.
>
> Service contracts agreed before 28 June 2025 may continue without alteration until they
> expire, but no longer than **five years** from that date.

Self-service terminals lawfully in use before 28 June 2025 may run "until the end of their
economically useful life, but no longer than **20 years** after their entry into use."

So "the EAA applied from 28 June 2025" is true and incomplete: legacy content and legacy
hardware have their own clocks running to 2030 and beyond.

### What is actually in scope

Products (Article 2(1)): consumer general-purpose computer hardware systems and their operating
systems; payment terminals; ATMs, ticketing machines, check-in machines and interactive
self-service information terminals; consumer terminal equipment with interactive computing
capability used for electronic communications services; the same for accessing audiovisual media
services; and e-readers.

Services (Article 2(2)): electronic communications services; services providing access to
audiovisual media services; named elements of air, bus, rail and waterborne passenger transport
(websites, mobile apps, e-tickets, travel information, interactive self-service terminals);
**consumer banking services**; **e-books and dedicated software**; and **e-commerce services**.
Article 2(3) adds answering emergency communications to 112.

Content exempted from the website/app obligations includes "pre-recorded time-based media
published before 28 June 2025", "office file formats published before 28 June 2025", and
archives containing only content not updated or edited after 28 June 2025.

### The microenterprise exemption, with its actual threshold

Article 3 definition, verbatim:

> ‘microenterprise’ means an enterprise which employs **fewer than 10 persons** and which has an
> annual turnover **not exceeding EUR 2 million** or an annual balance sheet total not exceeding
> EUR 2 million;

Article 4(5), verbatim:

> Microenterprises providing services shall be exempt from complying with the accessibility
> requirements referred to in paragraph 3 of this Article and any obligations relating to the
> compliance with those requirements.

Note the asymmetry, which is stated in Recital: microenterprises **providing services** are
exempt outright; microenterprises **dealing with products** are not exempt — their obligations
are merely "lighter", and Article 14(4) exempts them only from *documenting* their
disproportionate-burden assessment, not from making it.

### The finding that matters most for a design tool

**The European Accessibility Act never names WCAG.** Searching the full directive text for
"WCAG", "Web Content Accessibility", or "EN 301 549" returns nothing. The mechanism is Article
15 — conformity is *presumed* for products and services conforming to harmonised standards whose
references have been published in the Official Journal:

> Products and services which are in conformity with harmonised standards or parts thereof the
> references of which have been published in the Official Journal of the European Union, shall be
> presumed to be in conformity with the accessibility requirements of this Directive in so far as
> those standards or parts thereof cover those requirements.

So the chain is EAA → harmonised standard (EN 301 549) → WCAG, and the WCAG version is a
property of the standard's edition, not of the law. Any statement of the form "the EAA requires
WCAG 2.1 AA" is a two-step inference presented as a citation.

## 2. ADA Title II web rule (United States)

From ada.gov's own guidance page, verbatim, one sentence carrying three dates:

> On April 24, 2024, the Federal Register published the Department of Justice’s (Department)
> final rule updating its regulations for Title II of the Americans with Disabilities Act (ADA).
> The final rule has specific requirements about how to ensure that web content and mobile
> applications (apps) are accessible to people with disabilities. **On April 20, 2026, the
> Federal Register published the Department’s Interim Final Rule (IFR) extending the compliance
> date for State and local government entities with a total population of 50,000 or more to
> April 26, 2027. The compliance date for public entities with a total population of less than
> 50,000, or any special district government, is extended to April 26, 2028.**

The technical standard, verbatim:

> Requirement: The Web Content Accessibility Guidelines (WCAG) Version **2.1, Level AA** is the
> technical standard for state and local governments’ web content and mobile apps.

Two scope facts the page states directly. **Title II binds state and local governments, not
private businesses** — every example on the page is a city, a state parks department, a town
water bill. And a contractor does not escape it: "If a city lets people pay for public parking
using a mobile app, that mobile app must meet WCAG 2.1, Level AA even if the app is run by a
private company."

The page also **names WCAG 3.0 by name** as an example of an acceptable higher standard:

> a state parks department would probably be allowed to [use a higher standard] … if that
> standard provides the same or more accessibility and usability than WCAG 2.1, Level AA.

This confirms the 2.2/3.0 status finding from a second direction: the regulator's own text
treats WCAG 3.0 as a hypothetical future alternative, not as anything currently required.

**This corrects `accessibility-wcag.md` finding 10, which was at medium confidence and carried
reconstructed URLs.** Its dates were right. It is now primary-verified and can be cited.

## 3. Section 508 (United States, federal procurement)

From the Access Board's Revised 508 Standards, E205.4, verbatim:

> Electronic content shall conform to Level A and Level AA Success Criteria and Conformance
> Requirements in **WCAG 2.0** (incorporated by reference, see 702.10.1).

The software provisions repeat the same bar: "User interface components, as well as the content
of platforms and applications, shall conform to Level A and Level AA Success Criteria and
Conformance Requirements in WCAG 2.0."

There is an exception worth knowing because it is the one place a legal instrument *subtracts*
success criteria:

> EXCEPTION: Non-Web documents shall not be required to conform to the following four WCAG 2.0
> Success Criteria: 2.4.1 Bypass Blocks, 2.4.5 Multiple Ways, 3.2.3 Consistent Navigation, and
> 3.2.4 Consistent Identification.

### The three-standard spread, verified end to end

| Instrument | Named standard | Binds |
|---|---|---|
| Section 508 (Revised) | **WCAG 2.0** A + AA | US federal ICT procurement |
| ADA Title II rule | **WCAG 2.1** AA | US state and local government |
| EAA (Directive (EU) 2019/882) | **names no WCAG version at all** | EU products and services in Article 2 scope |

**No instrument verified in this pass names WCAG 2.2.** Designing to 2.2 is anticipatory, not
compliance — which is the correct reason to do it, since the gap is exactly the six new A/AA
criteria and every one of them is cheaper to decide than to retrofit.

## 4. Focus management — what the spec actually says, and where it stops

WAI-ARIA 1.2, §4.3.1 Information for Authors. This is the closest thing to a normative rule on
focus after a destructive DOM change, and it is one sentence:

> If the author removes the element with focus, the author SHOULD move focus to a **logical
> element**. Similarly, authors SHOULD not scroll the element with focus off screen unless the
> user performed a scrolling action.

Also normative, and a direct constraint on which ARIA pattern a design may pick:

> Authors MUST manage focus on the following container roles: grid, listbox, menu, menubar,
> radiogroup, tree, treegrid, tablist

And §4.3 on returning to a composite widget:

> It is essential that a container maintain a usable and consistent strategy when focus leaves a
> container and is then later refocused. While there may be exceptions, it is recommended that
> when a previously focused container is refocused, the active descendant be the same element as
> the active descendant when the container was last focused. Exceptions include cases where the
> contents of a container widget have changed, and widgets like a menubar where the user expects
> to always return to the first item when focus leaves the menu bar.

**The gap, stated precisely.** A client-side route change is exactly the case the first quote
describes — the element with focus is removed — so the obligation to move focus to a logical
element does apply. **What the spec does not do is name the destination.** No W3C normative text
read in this pass specifies where focus goes on an SPA route change, whether the new page title
must be announced, or how the View Transitions API interacts with focus restoration. That is a
genuine specification gap, not a lookup failure, and it is why route-change focus has to be a
design decision written down rather than a rule to look up.

## 5. Live regions — normative, from WAI-ARIA 1.2

Definition:

> Live regions are perceivable regions of a web page that are typically updated as a result of an
> external event **when user focus may be elsewhere**. These regions are not always updated as a
> result of a user interaction.

The three `aria-live` values, verbatim from §6.7:

> **assertive** — Indicates that updates to the region have the highest priority and should be
> presented the user immediately.
>
> **off (default)** — Indicates that updates to the region should not be presented to the user
> unless the user is currently focused on that region.
>
> **polite** — Indicates that updates to the region should be presented at the next graceful
> opportunity, such as at the end of speaking the current sentence or when the user pauses typing.

The restraint clause is normative, with a SHOULD NOT:

> Because an interruption may disorient users or cause them to not complete their current task,
> authors **SHOULD NOT use the assertive value unless the interruption is imperative**.

And the clause that kills the assumption of deterministic behaviour:

> Politeness levels are essentially an ordering mechanism for updates and serve as a **strong
> suggestion** to user agents or assistive technologies. The value may be overridden by user
> agents, assistive technologies, or the user.

Also: `assertive` may *destroy* queued speech — "User agents or assistive technologies MAY choose
to clear queued changes when an assertive change occurs."

### `role="alert"` vs `role="status"`

| | `alert` | `status` |
|---|---|---|
| Spec description | "A type of live region with important, and usually time-sensitive, information." | "A type of live region whose content is advisory information for the user but is not important enough to justify an alert, often but not necessarily presented as a status bar." |
| Implicit `aria-live` | `assertive` | `polite` |
| Implicit `aria-atomic` | `true` | `true` |

Both quotes and both implicit-value sentences are verbatim from the roles definitions. The
`status` role carries one extra normative author obligation:

> Authors SHOULD ensure an element with role **status does not receive focus** as a result of
> change in status.

`alert` additionally: "If the operating system allows, the user agent SHOULD fire a system alert
event through the accessibility API when the WAI-ARIA alert is created."

Two further live-region roles exist and are rarely used correctly: `log` ("new information is
added in meaningful order and old information may disappear") and `marquee` ("non-essential
information changes frequently"). `timer` is also a live region role.

## 6. Landmarks — from the APG Landmark Regions practice

Design-time rules, paraphrased from the page's own bullets:

- **One `main` per page**, top-level. Same for `banner` and `contentinfo` — "Each page may have
  one contentinfo landmark."
- **"A region landmark MUST have a label."** It is the only landmark with a hard label
  requirement, and it is the fallback role "used to identify content that named landmarks do not
  appropriately describe."
- "If a page includes more than one [landmark of a type], each should have a unique label."
- The inverse, which nobody encodes: "If a navigation landmark has an identical set of links as
  another navigation landmark on the page, **use the same label** for each navigation landmark."
- **HTML `header`/`footer` silently stop being landmarks inside `article`, `aside`, `main`,
  `nav`, or `section`.** A footer nested in a `section` is not a `contentinfo`. This is a nesting
  consequence of a layout decision, invisible on screen.
- A `form` landmark "should have a label … visible to all users (e.g. an `h1`-`h6` element)".
- Use `search`, not `form`, when the form is a search.

**Note for anyone re-running this:** `https://www.w3.org/WAI/ARIA/apg/practices/live-regions/`
returns **404**. The APG has seven practice pages (Landmark Regions, Names and Descriptions,
Keyboard Interface, Grid and Table Properties, Range-Related Properties, Structural Roles, Hiding
Semantics) and **no live-regions practice page exists**. Live-region guidance has to come from
the ARIA spec itself, as above.

## 7. Accessible names — the five rules, and what an icon-only button owes

APG's "Providing Accessible Names and Descriptions" states five rules. The three that are design
decisions rather than implementation notes:

> **Rule 2: Prefer Visible Text.** In addition to serving as a more robust source for an
> accessible name, visible text labels enhance accessibility for many people with disabilities
> who do not use assistive technologies that present invisible accessible names. In most
> circumstances, visible text labels also make the user interface easier to understand for all
> users.

> **Rule 4: Avoid Browser Fallback.** … the HTML `title` and `placeholder` attributes are used as
> last resort sources of content for accessible names. Because the purpose of these attributes is
> not naming, their content typically yields **low quality accessible names that are not
> effective**.

> **Rule 5: Compose Brief, Useful Names.** Similar to how visually crowded screens and ambiguous
> icons reduce usability, excessively long, insufficiently distinct, or unclear accessible names
> can make a user interface very difficult, or even impossible, to use for someone who relies on
> a non-visual form of the user interface.

The `title` attribute specifically:

> The `title` attribute is commonly presented visually as a tooltip when the user hovers over the
> element with a pointing device, which is **not particularly discoverable, and is also not
> accessible to visual users without a pointing device**.

**The warning that costs designs content.** Eighteen roles take their name from child content —
`button`, `cell`, `checkbox`, `columnheader`, `gridcell`, `heading`, `link`, `menuitem`,
`menuitemcheckbox`, `menuitemradio`, `option`, `radio`, `row`, `rowheader`, `switch`, `tab`,
`tooltip`, `treeitem` (`menuitem` excludes a child `menu`; `treeitem` excludes a child `group`).
On any of them:

> If an element with one of the above roles that supports naming from child content is named by
> using `aria-label` or `aria-labelledby`, content contained in the element and its descendants
> is **hidden from assistive technology users** unless the descendant content is referenced by
> `aria-labelledby`. It is strongly recommended to avoid using either of these attributes to
> override content of one of the above elements except in rare circumstances where hiding content
> from assistive technology users is beneficial.

And an i18n hook stated on the same page:

> When a user interface is translated into multiple languages, ensure that `aria-label` values
> are translated.

### Icon-only controls — the primary source Task 5 flagged as missing

`icons-verified.md` closed with "the accessible name of an icon-only button [was] not checked
against a primary source in this pass." It now is. W3C WAI Tutorial, Functional Images:

> Functional images are used to initiate actions rather than to convey information. They are used
> in buttons, links, and other interactive elements. **The text alternative for the image should
> convey the action that will be initiated (the purpose of the image), rather than a description
> of the image.**

> For instance … the text alternative should be “print this page” rather than “(image of a)
> printer”, “search” rather than “magnifying lens” …

The failure mode, stated by W3C rather than inferred:

> Missing or empty alt values create significant problems for screen reader users because
> functional images are essential to the functionality of the content. Screen readers will
> typically announce the **image file name, the image URL, or the URL for the link destination**,
> which is unlikely to help users understand the action that will be initiated by the image.

Worked examples on the page: a stand-alone printer icon takes `alt="Print this page"`; a
magnifying-lens search button takes `alt="Search"`; an icon that duplicates adjacent link text
takes `alt=""`, "to avoid redundancy and repetition."

APG's own canonical case is the same shape: `<button type="button" aria-label="Close">X</button>`.

## 8. SC 3.2.6 Consistent Help — the gap `accessibility-wcag.md` finding 11 named

That finding established only the Level A designation and said "Treat this as a research gap."
Filled here from the Understanding document.

What counts as a help mechanism, verbatim:

> Typical help mechanisms include: Human contact details such as a phone number, email address,
> hours of operation. Human contact mechanism such as a messaging system, chat client, contact
> form, social media channel. Self-help option such as an up-to-date Frequently Asked Questions,
> How Do I page, Support page. A fully automated contact mechanism such as a chatbot.

The requirement is **relative order**, not pixel position:

> Regardless of which approach is used, the mechanism must be located in the **same relative
> order** on each page within the set of pages.

> If the help item is visually in a different location, but in the same serial order, that is not
> helpful from a user's point of view, but **it would not fail this criterion**.

It does not require help to exist:

> It is not the intent of this success criterion to require authors to provide help or access to
> help. The Criterion only requires that when one of the listed forms of help is available across
> multiple pages that it be in a consistent location.

The responsive exception is explicit and narrow:

> This exception allows the location in a smaller viewport to be different than in a larger
> viewport.

…and route navigation does not qualify: "merely navigating between pages within a set of web
pages is not a 'change initiated by the user' for the purposes of this exception."

Sufficient technique: **G220**, provide a contact-us link in a consistent location. Failure:
*Inconsistent Help Location*.

## 9. Internationalization

### Text expansion — a real table, correctly attributed

The W3C i18n article "Text size in translation" republishes IBM's figures. **The number is IBM's,
not W3C's**, and the article's own framing is "average expected expansion rates":

> The following are average expected expansion rates for text translated from English into
> European languages, as published by IBM in their *Guidelines to design global solutions*.

| No. of characters in English source | Average expansion |
|---|---|
| Up to 10 | **200–300%** |
| 11–20 | 180–200% |
| 21–30 | 160–180% |
| 31–50 | 140–160% |
| 51–70 | 151–170% |
| Over 70 | **130%** |

Reproduced exactly as published, including the non-monotonic 51–70 row (151–170%, above the
31–50 row's ceiling), which is what the source shows.

The load-bearing sentence:

> The general message is that text will normally expand, but note carefully how **the smaller the
> source message, the higher the likely translation length**.

> The problem tends to be that the smaller the English text, the more likely it is to be squeezed
> into a small space, such as alongside a form entry field, or inside a graphic, or a set of width
> restricted tabs, etc.

The article's worked case is the word for "views": one English word, three in Italian
(`visualizzazioni`), ratio **3.0**; German `-mal angesehen`, ratio **2.8**. It also names the
reverse: Spanish "Idioma de la interfaz" is *shorter* in English, and "smaller translations can
be as problematic as bigger ones if they leave too much white space on the page."

One measurement rule stated on the page: "Because of the width of the glyphs involved, each
Chinese and Korean character is counted as two English characters in width."

### CJK line breaking

W3C i18n, "Approaches to line breaking". The two parameters that decide everything:

> whether 'words' or syllables are separated in the text, and if so, how, and
> whether the writing system wraps words, syllables, or characters to the next line.

Japanese and Vai wrap **individual characters** "regardless of word or syllable boundaries" —
Japanese being mora-based rather than syllable-based, such that text can wrap *inside* a single
syllable (きょう). Chinese and Korean wrap syllables, "slightly unusual in that a syllable normally
corresponds to a single character, rather than a sequence." South-East Asian scripts including
Thai and Khmer have **no word separator at all** and require text analysis to find break points.

The rules that are not optional:

> It is common to most scripts that content should not start a line with a punctuation mark that
> shows the end of a phrase or section.

> Other punctuation marks are normally not expected to end a line. These include opening
> parentheses or brackets.

CSS exposes the Japanese-specific control: the `line-break` property's `strict` and `loose`
values decide whether a small kana may be separated from its preceding character — "This can
often be useful for text in narrow columns, such as newspapers." An alternative strategy "seen in
languages such as Japanese and Chinese involves leaving the punctuation **hanging outside the
margin**" — which only works "if there is a visible margin available", i.e. it is a layout
decision.

### Plural rules — six categories, not two

Unicode CLDR, Plural Rules, verbatim:

> Languages vary in how they handle plurals of nouns or unit expressions (“hour” vs “hours”, and
> so on). Some languages have two forms, like English; some languages have only a single form; and
> some languages have multiple forms. CLDR uses short, mnemonic tags for these plural categories:

`zero` · `one` (singular) · `two` (dual) · `few` (paucal) · `many` (also used for fractions if
they have a separate class) · `other` (required — general plural form — also used if the language
only has a single form).

The categories are **not grammatical categories**:

> The CLDR plural categories do not necessarily match the traditional grammatical categories.
> Instead, the categories are determined by changes required in a phrase or sentence if a numeric
> placeholder changes value.

CLDR's own worked example shows `few` covering 2–4, 22–24, 32–34 while `other` covers 0, 5–20,
25–30 — so the mapping from number to category is not a range check either. And the stated reason
the whole mechanism exists is a design one: it allows "more natural phrasing than constructions
like '1 hour(s)'."

---

## Not established in this pass — verify before relying on any of it

Named explicitly so silence is not read as agreement.

- **EN 301 549's current version and its WCAG edition.** ETSI was not fetched. The claim in
  `accessibility-wcag.md` that v3.2.1 incorporates WCAG 2.1 and that v4.1.1 moves to WCAG 2.2 AA
  with an OJEU citation "anticipated around October 2026" remains at that file's *medium*
  confidence and is **forward-looking**. Do not state a version number or an OJEU date.
- **Whether any EU member state's transposition names a WCAG version directly.** Transposition is
  national and 27-way; none was read.
- **Whether the EAA reaches non-EU companies selling into the EU.** The directive's territorial
  scope was not analysed and no quote supports either answer.
- **ADA Title III (private business) obligations.** The rule read here is Title II only. There is
  no equivalent DOJ web regulation for Title III verified in this pass; anything about private-
  sector ADA web liability is litigation history, not a named standard, and was not researched.
- **Where focus should go on an SPA route change.** Confirmed above as a specification gap. The
  common practitioner answers — a `tabindex="-1"` heading, the `main` landmark, a skip link, a
  visually-hidden route announcer — are not in any W3C normative text read here.
- **The View Transitions API's interaction with focus and `prefers-reduced-motion`.** Not read.
- **"A live region must exist in the DOM before content is injected into it."** This is very
  widely repeated and it is **not in the WAI-ARIA 1.2 text read in this pass**. It may be true of
  specific screen-reader implementations. It is not a spec requirement as far as this pass
  established.
- **Cross-screen-reader live-region behaviour** (NVDA / JAWS / VoiceOver differences, `aria-atomic`
  and `aria-relevant` support levels). No support table was fetched. The spec's own "strong
  suggestion … may be overridden" clause is the only verified statement about variability.
- **A measured figure for the cost of icon-only controls.** W3C states functional-image alt text
  as a requirement; no comprehension study, error rate, or task-time measurement was located.
  `icons-verified.md` already flags this and it is still open.
- **Any specific text-expansion percentage other than IBM's table above.** If a run needs a number
  for a language not covered by "European languages", it does not have one.
- **RTL mirroring rules beyond `§13`'s existing statement.** Not researched here.

## What goes where

| Finding | File |
|---|---|
| EAA dates, scope, microenterprise threshold, the WCAG-is-absent finding | `ACCESS.md` legal section |
| Title II standard + April 2027 / April 2028 compliance dates | `ACCESS.md` legal section |
| Section 508 → WCAG 2.0; the three-standard spread table | `ACCESS.md` legal section |
| ARIA §4.3.1 focus-on-removal SHOULD; the MUST-manage-focus role list | `ACCESS.md` focus section |
| SPA route-change destination as a named specification gap | `ACCESS.md` focus section |
| `aria-live` values, the assertive SHOULD NOT, alert vs status table | `ACCESS.md` live regions |
| Landmark rules; `header`/`footer` nesting trap; region MUST have a label | `ACCESS.md` structure |
| Five naming rules; the name-from-content hiding warning | `ACCESS.md` accessible names |
| Functional-image alt: name the action, not the picture | `ACCESS.md`, `CRAFT.md` icons |
| SC 3.2.6 relative-order requirement and its responsive exception | `ACCESS.md` WCAG 2.2 section |
| IBM expansion table; CJK wrapping; CLDR six plural categories | `ACCESS.md` i18n section |
