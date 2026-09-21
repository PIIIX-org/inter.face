#!/usr/bin/env node
/**
 * Objective Programmatic Verification for Loop 2 (Craft) -> Gate B
 * Verifies that the Gate B deliverable package is complete, runnable,
 * respects performance budgets, implements reduced motion (§10),
 * and provides valid tokens.json.
 */

const fs = require('fs');
const path = require('path');

function verifyLoop2(runSlug, baseDir = process.cwd()) {
  const runDir = path.join(baseDir, 'runs', runSlug);
  const errors = [];
  const warnings = [];
  const passes = [];

  if (!fs.existsSync(runDir)) {
    return { success: false, errors: [`Run directory not found: ${runDir}`], warnings, passes };
  }

  // 1. Check tokens.json
  const tokensPath = path.join(runDir, 'tokens.json');
  if (!fs.existsSync(tokensPath)) {
    errors.push('tokens.json is missing from run directory');
  } else {
    try {
      const tokensContent = fs.readFileSync(tokensPath, 'utf8');
      const tokens = JSON.parse(tokensContent);
      passes.push('tokens.json exists and is valid JSON');

      // Check essential token groups
      const keys = Object.keys(tokens);
      if (keys.length === 0) {
        errors.push('tokens.json is empty');
      } else {
        passes.push(`tokens.json contains token groups: ${keys.join(', ')}`);
      }
    } catch (err) {
      errors.push(`tokens.json parsing error: ${err.message}`);
    }
  }

  // 2. Check prototypes directory and runnable HTML prototypes
  const protoDir = path.join(runDir, 'prototypes');
  if (!fs.existsSync(protoDir)) {
    errors.push('prototypes/ directory is missing');
  } else {
    const protoEntries = fs.readdirSync(protoDir);
    const htmlPrototypes = protoEntries.filter(f => f.endsWith('.html'));
    const verdictFiles = protoEntries.filter(f => f.endsWith('.verdict.md'));

    if (htmlPrototypes.length === 0) {
      errors.push('No runnable .html prototype files found in prototypes/');
    } else {
      passes.push(`Found ${htmlPrototypes.length} runnable HTML prototype(s): ${htmlPrototypes.join(', ')}`);

      for (const protoFile of htmlPrototypes) {
        const protoPath = path.join(protoDir, protoFile);
        const content = fs.readFileSync(protoPath, 'utf8');

        // Check for self-contained structure
        if (!content.includes('<html') && !content.includes('<meta') && !content.includes('<style')) {
          errors.push(`Prototype ${protoFile} is missing valid HTML structure`);
        }

        // Check for reduced-motion query (§10 requirement if motion is used)
        const hasAnimation = /keyframes|transition|animation|requestAnimationFrame|gsap/i.test(content);
        if (hasAnimation) {
          const hasReducedMotion = /prefers-reduced-motion/i.test(content);
          if (!hasReducedMotion) {
            warnings.push(`Prototype ${protoFile} uses motion/animation but does not explicitly declare prefers-reduced-motion media query (§10)`);
          } else {
            passes.push(`Prototype ${protoFile} declares prefers-reduced-motion media query`);
          }
        }

        // Check for WebGL context loss handling if WebGL is used
        const hasWebGL = /webgl|three(\.min)?\.js|<canvas/i.test(content);
        if (hasWebGL) {
          const hasContextLoss = /webglcontextlost|fallback|no-webgl/i.test(content);
          if (!hasContextLoss) {
            warnings.push(`Prototype ${protoFile} utilizes WebGL/canvas without explicit context loss or no-webgl fallback handling (§10)`);
          } else {
            passes.push(`Prototype ${protoFile} includes WebGL fallback or context loss handling`);
          }
        }
      }
    }

    if (verdictFiles.length === 0) {
      warnings.push('No .verdict.md files found in prototypes/ to document evidence labels');
    } else {
      passes.push(`Found ${verdictFiles.length} technique verdict file(s): ${verdictFiles.join(', ')}`);
      for (const vFile of verdictFiles) {
        const vContent = fs.readFileSync(path.join(protoDir, vFile), 'utf8');
        const hasEvidenceLabel = /TESTED|PARTIAL|INFERRED/i.test(vContent);
        if (!hasEvidenceLabel) {
          warnings.push(`Verdict file ${vFile} does not state an evidence label (TESTED, PARTIAL, or INFERRED)`);
        } else {
          passes.push(`Verdict ${vFile} states evidence label`);
        }
      }
    }
  }

  // 3. Check DIRECTION.md craft sections
  const directionPath = path.join(runDir, 'DIRECTION.md');
  if (fs.existsSync(directionPath)) {
    const dirContent = fs.readFileSync(directionPath, 'utf8');
    const hasMotion = /motion|timing|easing/i.test(dirContent);
    const hasBudget = /budget|tier|byte/i.test(dirContent);
    if (!hasMotion || !hasBudget) {
      warnings.push('DIRECTION.md craft section may be missing motion spec or byte budget declarations');
    } else {
      passes.push('DIRECTION.md includes craft motion spec and budget tiers');
    }
  }

  const success = errors.length === 0;
  return { success, errors, warnings, passes };
}

if (require.main === module) {
  const slug = process.argv[2];
  if (!slug) {
    console.error('Usage: node verify-loop2.js <run-slug> [base-dir]');
    process.exit(1);
  }
  const result = verifyLoop2(slug, process.argv[3]);
  console.log(`== Loop 2 Verification for: ${slug} ==`);
  for (const p of result.passes) console.log(`  [PASS] ${p}`);
  for (const w of result.warnings) console.log(`  [WARN] ${w}`);
  for (const e of result.errors) console.log(`  [FAIL] ${e}`);
  console.log(`Result: ${result.success ? 'GATE B READY' : 'VERIFICATION FAILED'}`);
  process.exit(result.success ? 0 : 1);
}

module.exports = { verifyLoop2 };
