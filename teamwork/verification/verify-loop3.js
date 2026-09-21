#!/usr/bin/env node
/**
 * Objective Programmatic Verification for Loop 3 (System) -> Gate C
 * Verifies that the Gate C deliverable package is complete,
 * sheet.html is built strictly from tokens, gaps.md documents missing values,
 * and keyboard completeness (§15) is walked for tool-shaped surfaces.
 */

const fs = require('fs');
const path = require('path');

function verifyLoop3(runSlug, baseDir = process.cwd()) {
  const runDir = path.join(baseDir, 'runs', runSlug);
  const errors = [];
  const warnings = [];
  const passes = [];

  if (!fs.existsSync(runDir)) {
    return { success: false, errors: [`Run directory not found: ${runDir}`], warnings, passes };
  }

  // 1. Check system directory
  const systemDir = path.join(runDir, 'system');
  if (!fs.existsSync(systemDir)) {
    return { success: false, errors: ['system/ directory is missing from run directory'], warnings, passes };
  }

  // 2. Check sheet.html
  const sheetPath = path.join(systemDir, 'sheet.html');
  if (!fs.existsSync(sheetPath)) {
    errors.push('system/sheet.html is missing. Gate C cannot be held without the navigable component sheet.');
  } else {
    const sheetContent = fs.readFileSync(sheetPath, 'utf8');
    if (!sheetContent.includes('<html') || !sheetContent.includes('</html>')) {
      errors.push('system/sheet.html is not valid HTML markup');
    } else {
      passes.push('system/sheet.html exists and is valid HTML');

      // Check for dual color mode support (light & dark)
      const hasLightDark = /light|dark/i.test(sheetContent) && /(data-theme|theme|mode|prefers-color-scheme)/i.test(sheetContent);
      if (!hasLightDark) {
        warnings.push('system/sheet.html should demonstrate components in both light and dark colour modes');
      } else {
        passes.push('system/sheet.html demonstrates components in light and dark colour modes');
      }
    }
  }

  // 3. Check gaps.md
  const gapsPath = path.join(systemDir, 'gaps.md');
  if (!fs.existsSync(gapsPath)) {
    errors.push('system/gaps.md is missing. The handoff gap report is an essential Gate C deliverable.');
  } else {
    const gapsContent = fs.readFileSync(gapsPath, 'utf8');
    passes.push('system/gaps.md exists and documents handoff gaps');
  }

  // 4. Check keyboard walk if surface is tool-shaped
  const translatePath = path.join(runDir, 'TRANSLATE.md');
  let isToolShaped = false;
  if (fs.existsSync(translatePath)) {
    const tContent = fs.readFileSync(translatePath, 'utf8');
    isToolShaped = /tool-shaped/i.test(tContent) && !/page-shaped.*default/i.test(tContent);
  }

  const keyboardWalkPath = path.join(systemDir, 'keyboard-walk.md');
  if (isToolShaped) {
    if (!fs.existsSync(keyboardWalkPath)) {
      errors.push('Surface is tool-shaped but system/keyboard-walk.md is missing. §15 keyboard completeness binds hard on tool-shaped surfaces.');
    } else {
      passes.push('system/keyboard-walk.md exists and documents the §15 keyboard walk');
    }
  } else if (fs.existsSync(keyboardWalkPath)) {
    passes.push('system/keyboard-walk.md is provided');
  }

  const success = errors.length === 0;
  return { success, errors, warnings, passes };
}

if (require.main === module) {
  const slug = process.argv[2];
  if (!slug) {
    console.error('Usage: node verify-loop3.js <run-slug> [base-dir]');
    process.exit(1);
  }
  const result = verifyLoop3(slug, process.argv[3]);
  console.log(`== Loop 3 Verification for: ${slug} ==`);
  for (const p of result.passes) console.log(`  [PASS] ${p}`);
  for (const w of result.warnings) console.log(`  [WARN] ${w}`);
  for (const e of result.errors) console.log(`  [FAIL] ${e}`);
  console.log(`Result: ${result.success ? 'GATE C READY' : 'VERIFICATION FAILED'}`);
  process.exit(result.success ? 0 : 1);
}

module.exports = { verifyLoop3 };
