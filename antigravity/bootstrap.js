#!/usr/bin/env node
/**
 * Antigravity subagent definition loader for inter.face.
 * Reads agents/*.md, strips markdown frontmatter, and formats definition payloads
 * for Antigravity's define_subagent tool.
 */

const fs = require('fs');
const path = require('path');

const ROOT_DIR = path.resolve(__dirname, '..');
const MANIFEST_PATH = path.join(__dirname, 'subagents.json');

function loadSubagentDefinitions() {
  const manifest = JSON.parse(fs.readFileSync(MANIFEST_PATH, 'utf8'));
  const definitions = [];

  for (const item of manifest.subagents) {
    const filePath = path.join(ROOT_DIR, item.agent_file);
    if (!fs.existsSync(filePath)) {
      throw new Error(`Agent file missing: ${filePath}`);
    }

    const content = fs.readFileSync(filePath, 'utf8');
    // Extract body without YAML frontmatter
    const frontmatterMatch = content.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n([\s\S]*)$/);
    const systemPrompt = frontmatterMatch ? frontmatterMatch[2].trim() : content.trim();

    definitions.push({
      name: item.name,
      description: item.description,
      role: item.role,
      model: item.model,
      enable_write_tools: item.enable_write_tools,
      enable_subagent_tools: item.enable_subagent_tools,
      enable_mcp_tools: item.enable_mcp_tools,
      system_prompt: systemPrompt
    });
  }

  return definitions;
}

if (require.main === module) {
  try {
    const defs = loadSubagentDefinitions();
    console.log(JSON.stringify(defs, null, 2));
  } catch (err) {
    console.error('Error bootstrapping subagents:', err.message);
    process.exit(1);
  }
}

module.exports = { loadSubagentDefinitions };
