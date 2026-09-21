#!/usr/bin/env node
/**
 * Master verification runner for inter.face under teamwork-preview.
 * Runs all three verification suites across a given run directory.
 */

const { verifyLoop1 } = require('./verify-loop1');
const { verifyLoop2 } = require('./verify-loop2');
const { verifyLoop3 } = require('./verify-loop3');

function verifyAll(runSlug, baseDir = process.cwd()) {
  console.log(`========================================`);
  console.log(`inter.face Teamwork Verification: ${runSlug}`);
  console.log(`========================================\n`);

  const r1 = verifyLoop1(runSlug, baseDir);
  console.log(`-- Loop 1 / Gate A --`);
  for (const p of r1.passes) console.log(`  [PASS] ${p}`);
  for (const w of r1.warnings) console.log(`  [WARN] ${w}`);
  for (const e of r1.errors) console.log(`  [FAIL] ${e}`);
  console.log(`Gate A Status: ${r1.success ? 'READY' : 'NOT READY'}\n`);

  const r2 = verifyLoop2(runSlug, baseDir);
  console.log(`-- Loop 2 / Gate B --`);
  for (const p of r2.passes) console.log(`  [PASS] ${p}`);
  for (const w of r2.warnings) console.log(`  [WARN] ${w}`);
  for (const e of r2.errors) console.log(`  [FAIL] ${e}`);
  console.log(`Gate B Status: ${r2.success ? 'READY' : 'NOT READY'}\n`);

  const r3 = verifyLoop3(runSlug, baseDir);
  console.log(`-- Loop 3 / Gate C --`);
  for (const p of r3.passes) console.log(`  [PASS] ${p}`);
  for (const w of r3.warnings) console.log(`  [WARN] ${w}`);
  for (const e of r3.errors) console.log(`  [FAIL] ${e}`);
  console.log(`Gate C Status: ${r3.success ? 'READY' : 'NOT READY'}\n`);

  const allPassed = r1.success && r2.success && r3.success;
  console.log(`========================================`);
  console.log(`Overall Result: ${allPassed ? 'ALL GATES READY' : 'INCOMPLETE OR FAILED'}`);
  console.log(`========================================`);

  return { allPassed, r1, r2, r3 };
}

if (require.main === module) {
  const slug = process.argv[2];
  if (!slug) {
    console.error('Usage: node verify-all.js <run-slug> [base-dir]');
    process.exit(1);
  }
  const { allPassed } = verifyAll(slug, process.argv[3]);
  process.exit(allPassed ? 0 : 1);
}

module.exports = { verifyAll };
