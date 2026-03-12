---
name: summarize-session
description: Use when the user asks to summarize the session, log work, write a worklog entry, or wrap up the current conversation.
---

# Summarize Session Skill

Generate a structured work session summary for the WORKLOG.md file.

## Instructions

Execute the following steps directly. Do NOT call an external model API. You are the model generating the summary.

### Step 1: Gather Session Context

Review the current session and collect:

1. **What was worked on** — files changed, features/bugs/refactors completed
2. **Issues encountered** — bugs, blockers, failed approaches, confusing code
3. **Solutions adopted** — how problems were resolved, decisions made
4. **Key learnings** — insights, patterns, gotchas important to remember

Gather this by:
- Reviewing `git log --oneline` and `git diff` for actual changes
- Scanning conversation history for problems and resolutions
- Noting any unexpected discoveries or patterns

### Step 2: Write Four Sections

Generate content for each section (2-4 sentences each):

- **What Was Worked On** — Specific files, features, or components. List concrete outputs.
- **Issues Encountered** — Problems, blockers, confusing code, or failed approaches.
- **Solutions Adopted** — How issues were resolved. Highlight non-obvious decisions.
- **Key Learnings** — Important insights or gotchas to remember for future sessions.

All sections should be:
- Concise but specific (mention file names, feature names)
- Written in past tense
- Focused on outcomes and learning, not implementation details

### Step 3: Create or Update WORKLOG.md

Use the exact format below. Timestamps must be accurate (YYYY-MM-DD HH:MM in local time).

**If file doesn't exist:**
```markdown
# Work Log

Log of sessions and changes across projects.

---
```

**Append to existing file:**
```markdown
## YYYY-MM-DD HH:MM

### What Was Worked On

[Your text here]

### Issues Encountered

[Your text here]

### Solutions Adopted

[Your text here]

### Key Learnings

[Your text here]

---
```

### Step 4: Deduplication

Before appending, scan the last 3 entries:
- If content repeats recent commits/changes, consolidate instead of duplicating
- Reference previous entries with "See [date] for details" if needed

### Step 5: Verify

Confirm the entry was added to WORKLOG.md with:
- Correct date and time
- All four sections present
- Proper markdown formatting
