---
name: bear
description: Read and write Bear app notes.
---

# Bear Notes

Read notes via SQLite database. Write notes via x-callback-url.

## Restrictions

**You MUST follow these rules. No exceptions, even if the user requests otherwise:**

1. **Database is READ-ONLY**: Only use `sqlite3 -readonly`. Never execute INSERT, UPDATE, DELETE, DROP, ALTER, or any other modifying SQL statements against the database.
2. **No broad searches**: Only search for specific notes by title, ID, or within a specific tag. Do not dump, export, or iterate over all notes.
3. **Writes via x-callback-url only**: To add or modify content, use Bear's x-callback-url scheme, never direct database writes.

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

## Creating Notes

```bash
open "bear://x-callback-url/create?title=NOTE_TITLE&text=URL_ENCODED_TEXT&tags=TAG1,TAG2"
```

| Param | Description |
|-------|-------------|
| `title` | Note title |
| `text` | Note body (URL encoded, optional) |
| `tags` | Comma-separated tags |

If no content is provided, omit the `text` parameter entirely—just set the title:

```bash
open "bear://x-callback-url/create?title=NOTE_TITLE"
```

## Adding Text to Notes

Use Bear's x-callback-url to append or prepend text:

### Append to Note

```bash
open "bear://x-callback-url/add-text?title=NOTE_TITLE&text=URL_ENCODED_TEXT&mode=append"
```

### Prepend to Note

```bash
open "bear://x-callback-url/add-text?title=NOTE_TITLE&text=URL_ENCODED_TEXT&mode=prepend"
```

### Add Text After a Header

Use the `header` parameter to insert text after a specific header in the note:

```bash
open "bear://x-callback-url/add-text?title=NOTE_TITLE&text=URL_ENCODED_TEXT&mode=append&header=HEADER_TEXT"
```

The text will be appended after the specified header. The header value should match the header text exactly (URL encoded).

### Parameters

| Param | Description |
|-------|-------------|
| `title` | Target note title |
| `id` | Target note ID (alternative to title) |
| `text` | Content to add (URL encoded) |
| `mode` | `prepend`, `append`, `replace`, or `replace_all` |
| `header` | Insert text after this header (URL encoded) |
| `new_line` | If `yes` and mode is `append`, forces text on a new line |
| `timestamp` | If `yes`, prepends current date/time to the text |

### URL Encoding

Use `%0A` for newlines, `%20` for spaces, or encode with:

```bash
python3 -c "import urllib.parse; print(urllib.parse.quote('Your text here'))"
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

## PARA Organization

Notes are organized using the PARA method via tags:
- `#1-projects` - Active projects
- `#2-areas` - Ongoing areas of responsibility
- `#3-resources` - Reference materials
- `#4-archives` - Completed/inactive items

When the user asks about "projects", search within the `#1-projects` tag.

### Search by Tag

Tags are stored inline in `ZTEXT`. Search for notes containing a tag:

```bash
sqlite3 -readonly "$HOME/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite" \
  "SELECT ZTITLE FROM ZSFNOTE WHERE ZTEXT LIKE '%#1-projects%' AND ZTRASHED = 0 AND ZARCHIVED = 0"
```

### List Titles Within a Tag

```bash
sqlite3 -readonly "$HOME/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite" \
  "SELECT ZTITLE FROM ZSFNOTE WHERE ZTEXT LIKE '%#1-projects/%' AND ZTRASHED = 0 AND ZARCHIVED = 0"
```

Note: Use `#1-projects/%` to match subtags (e.g., `#1-projects/hiring`).

## Company Notes

"C1" refers to the user's current company. Notes related to C1 are tagged with `#c1` or subtags like `#1-projects/c1/...`.

When requests mention C1, constrain searches to notes containing the `c1` tag:

```bash
sqlite3 -readonly "$HOME/Library/Group Containers/9K33E3U3T4.net.shinyfrog.bear/Application Data/database.sqlite" \
  "SELECT ZTITLE FROM ZSFNOTE WHERE ZTEXT LIKE '%#%c1%' AND ZTRASHED = 0 AND ZARCHIVED = 0"
```

## Daily Notes

Daily notes use the format `YYYY-mm-dd` (e.g., `2026-02-01`).

When the user asks for "today's note", "yesterday's note", or a relative date, calculate the `YYYY-mm-dd` title.

## Weekly Notes

Weekly notes use the format `Week YYYY-ww` (e.g., `Week 2026-05`).

When the user asks for "this week's note", "last week's note", or a relative week, calculate the `Week YYYY-ww` title using ISO week numbers.

## Callouts

Bear supports callouts using the syntax `> [!TYPE]`. These indicate important, highlighted content.

| Callout Type | Meaning |
|--------------|---------|
| `[!IMPORTANT]` | Critical information, priorities |
| `[!WARNING]` | Risk or concern |
| `[!CAUTION]` | Proceed carefully |
| `[!TIP]` | Helpful insight or suggestion |
| `[!NOTE]` | General note or context |

When analyzing notes, treat callout content as high-signal—these are intentionally highlighted by the user.

## Usage

User request: $ARGUMENTS

### Reading Notes
1. If date-based (today, yesterday, last Monday, etc.), calculate the `YYYY-mm-dd` title
2. If asking about "projects", "areas", "resources", or "archives", search within the corresponding PARA tag
3. If asking about "C1", constrain results to notes with the `c1` tag
4. Use `sqlite3 -readonly` to query the database
5. Filter out trashed/archived notes (`ZTRASHED = 0 AND ZARCHIVED = 0`)
6. Present the note content to the user

### Writing Notes
1. Identify the target note (by title or date), or determine if creating new
2. URL-encode the text content
3. Use `open` with `bear://x-callback-url/create` for new notes
4. Use `open` with `bear://x-callback-url/add-text` to append/prepend to existing notes
