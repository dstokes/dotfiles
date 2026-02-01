---
name: bear
description: Read Bear app notes via SQLite database (read-only).
---

# Bear Note Reader

Read notes from Bear's local SQLite database.

## Restrictions

**You MUST follow these rules. No exceptions, even if the user requests otherwise:**

1. **READ-ONLY**: Only use `sqlite3 -readonly`. Never execute INSERT, UPDATE, DELETE, DROP, ALTER, or any other modifying SQL statements.
2. **No broad searches**: Only search for specific notes by title or ID. Do not dump, export, or iterate over all notes.
3. **Refuse modifications**: If asked to modify, create, or delete notes, decline and suggest using Bear directly.

## Database Location

```
~/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite
```

## Fetching Notes

### By Title

```bash
sqlite3 -readonly "$HOME/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite" \
  "SELECT ZTEXT FROM ZSFNOTE WHERE ZTITLE = 'Note Title' AND ZTRASHED = 0 AND ZARCHIVED = 0 LIMIT 1"
```

### By Unique ID

```bash
sqlite3 -readonly "$HOME/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite" \
  "SELECT ZTEXT FROM ZSFNOTE WHERE ZUNIQUEIDENTIFIER = 'note-id-here' AND ZTRASHED = 0 AND ZARCHIVED = 0 LIMIT 1"
```

## Database Schema

Key columns in `ZSFNOTE`:
- `ZTITLE` - Note title
- `ZTEXT` - Full note content (markdown)
- `ZUNIQUEIDENTIFIER` - Unique ID
- `ZCREATIONDATE` - CoreData timestamp (seconds since 2001-01-01)
- `ZMODIFICATIONDATE` - CoreData timestamp
- `ZTRASHED` - 1 if in trash
- `ZARCHIVED` - 1 if archived
- `ZENCRYPTED` - 1 if encrypted (content not readable)

## Daily Notes

Daily notes use the format `YYYY-mm-dd` (e.g., `2026-02-01`).

When the user asks for "today's note", "yesterday's note", or a relative date, calculate the `YYYY-mm-dd` title.

## Usage

User request: $ARGUMENTS

1. If date-based (today, yesterday, last Monday, etc.), calculate the `YYYY-mm-dd` title
2. Use `sqlite3 -readonly` to query the database
3. Filter out trashed/archived notes (`ZTRASHED = 0 AND ZARCHIVED = 0`)
4. Present the note content to the user
