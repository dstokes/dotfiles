---
name: 5-15
description: Generate a 5-15 weekly report from Bear notes and Todoist tasks.
---

# 5-15 Weekly Report

Generate a concise weekly report (15 minutes to write, 5 minutes to read) for stakeholders including VP of Engineering, CTO, and peers.

## Data Sources

Gather information from:

1. **Bear Daily Notes** - Weekday notes only, Mon-Fri (`YYYY-mm-dd` format)
2. **Bear Weekly Note** - Current week's note (`Week YYYY-ww` format)
3. **Todoist Completed Tasks** - Tasks completed this week (weekdays only)

## Phase 1: Gather Context

### Calculate Date Range

Determine the current ISO week and date range (Monday through Friday only—exclude weekends).

### Fetch Bear Notes

Query daily notes for the current week:

```bash
# Get daily notes for weekdays (Mon-Fri) in current week
sqlite3 -readonly "$HOME/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite" \
  "SELECT ZTEXT FROM ZSFNOTE WHERE ZTITLE IN ('2026-02-03', '2026-02-04', '2026-02-05', '2026-02-06', '2026-02-07') AND ZTRASHED = 0 AND ZARCHIVED = 0"
```

Query the weekly note:

```bash
sqlite3 -readonly "$HOME/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite" \
  "SELECT ZTEXT FROM ZSFNOTE WHERE ZTITLE = 'Week 2026-05' AND ZTRASHED = 0 AND ZARCHIVED = 0 LIMIT 1"
```

### Fetch Todoist Completed Tasks

Use the Todoist MCP tools to retrieve tasks completed during the current week.

## Phase 2: Analyze & Prioritize

From the gathered data:

1. **Extract callouts first** - Content in `[!IMPORTANT]`, `[!WARNING]`, etc. is high-signal (see Bear skill for callout types)
2. **Identify priorities** listed in daily/weekly notes
3. **Extract completed work** that demonstrates progress on priorities
4. **Note blockers or challenges** encountered
5. **Identify upcoming focus areas** for next week

Prioritize details that highlight:
- **Impact** - Business outcomes, user value, risk reduction
- **Progress on stated priorities** - Show momentum on key initiatives
- **Cross-functional collaboration** - Work with other teams
- **Technical achievements** - Significant implementations or fixes

## Phase 3: Generate Report

Format the report for quick consumption. Use outcome-oriented language.

### Report Template

```markdown
# Weekly Update – Week YYYY-WW

## Completed

- **[Priority/Project]**: [Outcome achieved, impact delivered]
- **[Priority/Project]**: [Outcome achieved, impact delivered]

## What I Learned

- [Something I learned that may be relevant to stakeholders]
- [Something I learned that may be relevant to stakeholders]

## Blockers / Needs Attention

- [Any blockers or items needing escalation - omit section if none]

## Focus Next Week

- [Priority and/or task for next week]
- [Priority and/or task for next week]
```

## Guidelines

- **Work-related only**: Include only updates relevant to your role—skip personal thoughts, notes, or non-work content
- **Be concise**: Each bullet should be 1-2 sentences max
- **Lead with outcomes**: "Shipped X" not "Worked on X"
- **Quantify when possible**: Numbers, percentages, dates
- **Skip routine tasks**: Focus on what moves the needle
- **Omit empty sections**: If no blockers, don't include that section

## User Input

Additional context from user: $ARGUMENTS

If the user provides specific items to include, incorporate them into the appropriate sections. If no additional input, generate from gathered data only.
