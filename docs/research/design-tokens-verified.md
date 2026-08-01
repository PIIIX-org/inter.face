# Verified — design tokens as the handoff format

**Date:** 2026-08-01
**Source:** the Design Tokens Format Module, read off the rendered spec (84,421 characters).

`DIRECTION.md` is prose. Spec v2 added `tokens.json` as its machine-readable sibling so the
build step does not have to OCR a design image or parse English. This is what that file must
conform to.

---

## Status — get the name right

It is a **Community Group Draft**, dated **30 July 2026**. It is *not* a W3C Recommendation
and not a W3C standard. Calling it "the W3C design token standard" in the plugin would be
wrong in the same checkable way as the 44pt claim.

Correct phrasing: *the Design Tokens Community Group (DTCG) format*.

Being a live draft two days old is an argument for pinning: state which draft the plugin
targets, because the value shapes below have already changed between drafts.

## The structure rules

Three properties carry everything: `$value`, `$type`, `$description`. `$extensions` holds
tool-specific data.

The one hard structural constraint:

> If an object contains both `$value` and child tokens/groups, this creates an invalid
> structure where the object cannot be both a token and a group.

So `color.brand` cannot be both a color *and* a namespace holding `color.brand.hover`. That
forces a naming decision at design time — either `color.brand.base` / `color.brand.hover`, or
a flat leaf. Worth stating, because the intuitive nesting is illegal.

`$type` is inherited from the nearest ancestor group that declares it, which is why grouping
by type rather than by component is the cheaper structure.

## The type list — verified, exhaustive

`border` · `cubicBezier` · `dimension` · `duration` · `fontFamily` · `fontWeight` ·
`gradient` · `number` · `shadow` · `strokeStyle` · `transition` · `typography`

(Plus `color`, whose section uses different phrasing than the "MUST be set to the string X"
construction the others share — its exact value shape was not confirmed in this pass and needs
one more look before we write a color token by hand.)

## The two value shapes that break naive token files

**`dimension` is an object, not a string.**

> The value MUST be an object containing a numeric value (integer or floating-point) and unit
> of measurement (**"px" or "rem"**).

So `"16px"` is invalid. It must be `{ "value": 16, "unit": "px" }`. And the unit set is closed
— **px and rem only**. No `pt`, no `dp`, no `em`, no `%`.

**This collides directly with our platform research.** Apple specifies in `pt`, Material in
`dp` and `sp`. Neither is expressible in a DTCG `dimension`. So `tokens.json` is a **web
artifact**, and native surfaces need their numbers carried in `DIRECTION.md` prose or in a
`$extensions` block. That is a real limit of the handoff format and the plugin should say so
rather than pretending one file serves all four surfaces.

**`duration` is likewise an object**, numeric value plus `"ms"` or `"s"`.

## Composite types are the useful part

`typography`, `shadow`, `border`, `transition`, `gradient`, and `strokeStyle` are composite —
one token carrying several sub-values. That maps well onto what Gate B actually produces: a
motion spec is a set of `transition` tokens (duration + `cubicBezier` + delay), not a
paragraph.

Aliasing supports **pointer syntax into a composite** — "references to specific properties
within composite tokens, not just entire token values" — so a design system can reuse one
easing curve across every transition without duplicating it.

## What this settles for the plugin

1. **`tokens.json` targets a pinned DTCG draft**, named by date, and is described as a
   Community Group format rather than a standard.
2. **It is web-scoped.** Native `pt`/`dp`/`sp` values live in `DIRECTION.md` and optionally
   `$extensions`. Say the limit out loud.
3. **Group by type, not by component**, so `$type` inherits and the file stays short.
4. **Paired color tokens** — the `minimalist-ui` steal where a swatch ships with its
   foreground — need modelling as a group of two color tokens with a `$description` binding
   them, since DTCG has no native "pair" type. Contrast stays structural, but the pairing is a
   convention we impose, not one the format enforces.
5. **The motion spec becomes `transition` tokens**, which is the first time in this family a
   motion spec has been machine-readable instead of prose that gets rebuilt three times.

## Still open

The `color` value shape (colorSpace, hex vs components), and whether any real tooling consumes
this draft's object-form `dimension` yet — a format nothing reads is a format that will drift.
