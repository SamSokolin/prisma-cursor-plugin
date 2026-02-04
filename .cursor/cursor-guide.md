# Building Plugins for Cursor

This guide explains how to create and submit plugins for the Cursor Marketplace.

## Overview

Cursor plugins allow you to package and distribute:

- **Rules** — Persistent AI guidance and coding standards
- **Skills** — Specialized agent capabilities for complex tasks
- **Agents** — Custom agent configurations and prompts
- **MCP Servers** — Model Context Protocol integrations
- **Hooks** — Automation scripts triggered by events

Once installed, plugins work seamlessly across all Cursor surfaces — the IDE, CLI, and Cloud.

## Plugin Structure

A plugin is a directory containing a manifest file and your plugin assets:

```
my-plugin/
├── .cursor/
│   └── plugin.json        # Required: plugin manifest
├── rules/                 # Cursor rules (.mdc files)
│   ├── coding-standards.mdc
│   └── review-checklist.mdc
├── skills/                # Agent skills
│   └── code-reviewer/
│       └── SKILL.md
├── agents/                # Custom agent configurations
│   └── security-reviewer.md
├── hooks.json             # Hook definitions
├── mcp.json               # MCP server definitions
├── scripts/               # Hook and utility scripts
│   └── format-code.py
└── README.md
```

## Plugin Manifest

Every plugin requires a `.cursor/plugin.json` manifest file.

### Required Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | string | Plugin identifier. Must be lowercase, kebab-case, no spaces (e.g., `my-plugin`). Users see this when installing. |
| `author` | object | Author info: `name` (required), `email` (required), `url` (optional — link to author's webpage) |
| `description` | string | Brief plugin description |

### Optional Fields

| Field | Type | Description |
| --- | --- | --- |
| `version` | string | Semantic version (e.g., `1.0.0`) |
| `keywords` | array | Tags for plugin discovery and categorization |
| `logo` | string | URL to SVG logo |
| `primaryColor` | string | Hex code for branding (e.g., `#4F46E5`) |
| `rules` | string|array | Custom paths to rules files/directories (in addition to default `rules/`) |
| `agents` | string|array | Custom paths to agent files/directories (in addition to default `agents/`) |
| `skills` | string|array | Custom paths to skill files/directories (in addition to default `skills/`) |
| `hooks` | string | Custom path to hooks file (replaces default `hooks.json`) |
| `mcp` | string | Custom path to MCP file (replaces default `mcp.json`) |

### Example Manifest

```json
{
  "name": "enterprise-plugin",
  "version": "1.2.0",
  "description": "Enterprise development tools with security scanning and compliance checks",
  "author": {
    "name": "ACME DevTools",
    "email": "devtools@acme.com",
    "url": "https://acme.com/devtools"
  },
  "keywords": ["enterprise", "security", "compliance"],
  "logo": "https://acme.com/logo.svg",
  "primaryColor": "#4F46E5"
}
```

## Plugin Examples

### Rules-Only Plugin

A simple plugin that provides coding standards:

```
eslint-rules/
├── .cursor/
│   └── plugin.json
└── rules/
    ├── prefer-const.mdc
    ├── no-any.mdc
    └── error-handling.mdc
```

```json
{
  "name": "eslint-rules",
  "description": "ESLint-inspired coding rules for TypeScript",
  "author": {
    "name": "Your Name",
    "email": "you@example.com"
  },
  "keywords": ["eslint", "typescript", "linting"]
}
```

### Skills Plugin

A plugin that adds specialized agent capabilities:

```
code-review-skills/
├── .cursor/
│   └── plugin.json
└── skills/
    ├── security-review/
    │   └── SKILL.md
    └── performance-audit/
        ├── SKILL.md
        └── scripts/
            └── analyze.py
```

```json
{
  "name": "code-review-skills",
  "description": "Advanced code review skills for security and performance",
  "author": {
    "name": "Your Name",
    "email": "you@example.com"
  },
  "keywords": ["code-review", "security", "performance"]
}
```

### Hooks Plugin

A plugin that provides automation hooks:

```
ci-hooks/
├── .cursor/
│   └── plugin.json
├── hooks.json
└── scripts/
    ├── pre-commit-lint.sh
    ├── post-save-format.py
    └── on-file-create-template.js
```

```json
{
  "name": "ci-hooks",
  "description": "CI/CD automation hooks for linting, formatting, and templating",
  "author": {
    "name": "Your Name",
    "email": "you@example.com"
  },
  "keywords": ["ci", "automation", "hooks", "linting"]
}
```

```json
// hooks.json
{
  "hooks": {
    "pre-commit": {
      "command": "./scripts/pre-commit-lint.sh",
      "description": "Run linting before commit"
    },
    "post-save": {
      "command": "python ./scripts/post-save-format.py",
      "description": "Auto-format on save"
    }
  }
}
```

### MCP-Only Plugin

A plugin that provides MCP server integrations:

```
database-mcp/
├── .cursor/
│   └── plugin.json
└── mcp.json
```

```json
{
  "name": "database-mcp",
  "description": "MCP servers for database interactions",
  "author": {
    "name": "Your Name",
    "email": "you@example.com"
  }
}
```

Note: The `mcp.json` file at the plugin root is automatically detected. You only need to specify the `mcp` field in `plugin.json` if using a custom path.

```json
// mcp.json
{
  "postgres": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-postgres"],
    "env": {
      "POSTGRES_CONNECTION_STRING": "${POSTGRES_URL}"
    }
  }
}
```

### Custom Agents Plugin

A plugin with custom agent configurations:

```
specialized-agents/
├── .cursor/
│   └── plugin.json
└── agents/
    ├── api-designer.md
    └── test-writer.md
```

```json
{
  "name": "specialized-agents",
  "description": "Specialized agents for API design and testing",
  "author": {
    "name": "Your Name",
    "email": "you@example.com"
  },
  "keywords": ["agents", "api", "testing"]
}
```

### Full-Featured Plugin

A comprehensive plugin with multiple components:

```
enterprise-toolkit/
├── .cursor/
│   └── plugin.json
├── rules/
│   ├── security-standards.mdc
│   └── code-style.mdc
├── skills/
│   └── compliance-check/
│       └── SKILL.md
├── agents/
│   ├── security-reviewer.md
│   ├── performance-tester.md
│   └── compliance-checker.md
├── hooks.json
├── mcp.json
├── scripts/
│   ├── security-scan.sh
│   └── format-code.py
└── README.md
```

```json
{
  "name": "enterprise-toolkit",
  "version": "2.0.0",
  "description": "Complete enterprise development toolkit with security, compliance, and automation",
  "author": {
    "name": "ACME DevTools",
    "email": "devtools@acme.com",
    "url": "https://acme.com/devtools"
  },
  "keywords": ["enterprise", "security", "compliance"],
  "logo": "https://acme.com/logo.svg",
  "primaryColor": "#4F46E5"
}
```

## Writing Rules

Rules are `.mdc` files that provide persistent guidance to the AI. Place them in the `rules/` directory.

Rules require YAML frontmatter with metadata:

```markdown
---
description: Prefer const over let for variables that are never reassigned
alwaysApply: true
---

prefer-const: Always use `const` for variables that are never reassigned. Only use `let` when the variable needs to be reassigned. Never use `var`.
```

### Rule Frontmatter Fields

| Field | Type | Description |
| --- | --- | --- |
| `description` | string | Brief description of what the rule does |
| `alwaysApply` | boolean | If `true`, rule applies to all files. If `false`, rule is available on request. |
| `globs` | string|array | Optional file patterns to apply the rule to (e.g., `"**/*.ts"`) |

**Tip:** You can use `/create-rule` in the Cursor agent to help generate rules with proper frontmatter.

## Writing Skills

*See Agent Skills [docs](https://cursor.com/docs/context/skills).* 

Skills are specialized capabilities defined in `SKILL.md` files. Each skill lives in its own directory under `skills/`.

Skills require YAML frontmatter with metadata:

```markdown
---
name: api-designer
description: Design RESTful APIs following OpenAPI 3.0 specification. Use when designing new API endpoints, reviewing API contracts, or generating API documentation.
---

# API Designer Skill

## When to Use

- Designing new API endpoints
- Reviewing API contracts
- Generating API documentation

## Instructions

1. Follow REST conventions for resource naming
2. Use appropriate HTTP methods (GET, POST, PUT, DELETE, PATCH)
3. Include proper error responses with standard HTTP status codes
4. Document all endpoints with OpenAPI 3.0 specification
5. Use consistent naming conventions (kebab-case for URLs, camelCase for JSON)

## Examples

### Creating a Resource Endpoint

```

### Skill Frontmatter Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | string | Skill identifier (lowercase, kebab-case) |
| `description` | string | Description of what the skill does and when to use it |

**Tip:** You can use `/create-skill` in the Cursor agent to help generate skills with proper frontmatter.

## Writing Agents

Agents are markdown files that define custom agent behaviors and prompts. Place them in the `agents/` directory.

Agents require YAML frontmatter with metadata:

```markdown
---
name: security-reviewer
description: Security-focused code reviewer that checks for vulnerabilities and best practices
---

# Security Reviewer

You are a security-focused code reviewer. When reviewing code:

1. Check for injection vulnerabilities (SQL, XSS, command injection)
2. Verify proper authentication and authorization
3. Look for sensitive data exposure (API keys, passwords, PII)
4. Ensure secure cryptographic practices
5. Review dependency security and known vulnerabilities
6. Check for proper input validation and sanitization

## Common Vulnerabilities to Flag

- Unsanitized user input in SQL queries
- innerHTML usage with user-provided content
- Hardcoded secrets or credentials
- Missing CSRF protection
- Insecure direct object references
```

### Agent Frontmatter Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | string | Agent identifier (lowercase, kebab-case) |
| `description` | string | Brief description of the agent's purpose |

**Tip:** You can use `/create-agent` in the Cursor agent to help generate agents with proper frontmatter.

## Selective Installation

Users can choose to install specific components from your plugin rather than everything. For example, if your plugin contains multiple skills, users can install only the ones they need.

When designing your plugin, consider organizing components so they can be used independently when possible.

## Submitting Your Plugin

The Cursor Marketplace is curated to maintain a high quality bar. To submit a plugin:

1. Create your plugin following this guide's structure
2. Host your plugin in a Git repository
3. Send your repo link to Cursor team (slack or kniparko@anysphere.com) 
    - Link to your Git repository
    - SVG logo (optional but recommended)
    - Clear description of what your plugin does

Our team will review your submission and load it into the marketplace.

### Submission Checklist

- Plugin has a valid `.cursor/plugin.json` manifest
- `name` is unique, lowercase, kebab-case (e.g., `my-awesome-plugin`)
- `description` clearly explains the plugin's purpose
- `author` includes `name` and `email`
- All rules/skills/agents have proper frontmatter metadata
- README.md documents usage and any configuration
- All paths in manifest are relative and valid
- Plugin has been tested locally

## Best Practices

1. **Keep plugins focused** — Do one thing well rather than bundling unrelated features
2. **Document thoroughly** — Include a clear README with usage examples
3. **Use semantic versioning** — Follow semver for version numbers
4. **Add proper frontmatter** — All rules, skills, and agents need metadata
5. **Test locally first** — Verify your plugin works before submitting
6. **Use descriptive keywords** — Help users discover your plugin
7. **Provide a logo** — A recognizable SVG logo improves discoverability

##