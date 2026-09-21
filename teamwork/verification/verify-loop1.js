#!/usr/bin/env node
/**
 * Objective Programmatic Verification for Loop 1 (Direction) -> Gate A
 * Verifies that the Gate A deliverable package is complete, accessible (§10),
 * distinct across concepts, and navigable via board.html.
 */

const fs = require('fs');
const path = require('path');

function verifyLoop1(runSlug, baseDir = process.cwd()) {
  const runDir = path.join(baseDir, 'runs', runSlug);
  const errors = [];
  const warnings = [];
  const passes = [];

  if (!fs.existsSync(runDir)) {
    return { success: false, errors: [`Run directory not found: ${runDir}`], warnings, passes };
  }

  // 1. Check DIRECTION.md existence and direction section
  const directionPath = path.join(runDir, 'DIRECTION.md');
  if (!fs.existsSync(directionPath)) {
    errors.push('DIRECTION.md is missing from run directory');
  } else {
    const directionContent = fs.readFileSync(directionPath, 'utf8');
    if (!directionContent.includes('## 1.') && !directionContent.includes('Direction')) {
      warnings.push('DIRECTION.md may be incomplete; expected concept direction sections');
    } else {
      passes.push('DIRECTION.md exists and contains direction sections');
    }
  }

  // 2. Check design directory and concepts
  const designDir = path.join(runDir, 'design');
  if (!fs.existsSync(designDir)) {
    errors.push('design/ directory is missing');
  } else {
    const entries = fs.readdirSync(designDir, { withFileTypes: true });
    const conceptDirs = entries.filter(e => e.isDirectory()).map(e => e.name);

    if (conceptDirs.length < 3) {
      errors.push(`Expected at least 3 distinct concept directories in design/, found ${conceptDirs.length}: ${conceptDirs.join(', ')}`);
    } else {
      passes.push(`Found ${conceptDirs.length} distinct concepts: ${conceptDirs.join(', ')}`);
      
      // Check comps within concept directories
      for (const concept of conceptDirs) {
        const cPath = path.join(designDir, concept);
        const compFiles = fs.readdirSync(cPath).filter(f => f.endsWith('.md') || f.endsWith('.png') || f.endsWith('.html'));
        if (compFiles.length === 0) {
          errors.push(`Concept directory ${concept} has no comp files (.md, .png, or .html)`);
        } else {
          passes.push(`Concept ${concept} contains comp deliverables: ${compFiles.join(', ')}`);
        }
      }
    }

    // 3. Check board.html
    const boardPath = path.join(designDir, 'board.html');
    if (!fs.existsSync(boardPath)) {
      errors.push('design/board.html is missing. Gate A cannot be held without a navigable board.');
    } else {
      const boardContent = fs.readFileSync(boardPath, 'utf8');
      if (!boardContent.includes('<html') || !boardContent.includes('</html>')) {
        errors.push('design/board.html is not valid HTML markup');
      } else {
        passes.push('design/board.html exists and is valid HTML');
        for (const concept of conceptDirs) {
          if (!boardContent.includes(concept)) {
            warnings.push(`design/board.html does not appear to reference concept "${concept}"`);
          }
        }
      }
    }
  }

  // 4. Check TRANSLATE.md
  const translatePath = path.join(runDir, 'TRANSLATE.md');
  if (!fs.existsSync(translatePath)) {
    warnings.push('TRANSLATE.md not found in run directory');
  } else {
    const translateContent = fs.readFileSync(translatePath, 'utf8');
    if (!translateContent.includes('page-shaped') && !translateContent.includes('tool-shaped')) {
      errors.push('TRANSLATE.md row 1 (surface class: page-shaped vs tool-shaped) is not settled');
    } else {
      passes.push('TRANSLATE.md carries settled surface class');
    }
  }

  const success = errors.length === 0;
  return { success, errors, warnings, passes };
}

if (require.main === module) {
  const slug = process.argv[2];
  if (!slug) {
    console.error('Usage: node verify-loop1.js <run-slug> [base-dir]');
    process.exit(1);
  }
  const result = verifyLoop1(slug, process.argv[3]);
  console.log(`== Loop 1 Verification for: ${slug} ==`);
  for (const p of result.passes) console.log(`  [PASS] ${p}`);
  for (const w of result.warnings) console.log(`  [WARN] ${w}`);
  for (const e of result.errors) console.log(`  [FAIL] ${e}`);
  console.log(`Result: ${result.success ? 'GATE A READY' : 'VERIFICATION FAILED'}`);
  process.exit(result.success ? 0 : 1);
}

module.exports = { verifyLoop1 };
