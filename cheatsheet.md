# Navigation
| Motion | Description |
|----|-------|
| `h` / `j` / `k` / `l` | Move cursor: Left / Down / Up / Right |
| `w` / `b` / `e` / `ge` | Word Motions: next / previous word / End of word / backward |
| `0` / `^` / `$` | Line start / first char / end |
| `gg` / `G` | Top / bottom of file |
| `<C-d>` / `<C-u>` | Half-page down / up |
| `<C-f>` / `<C-b>` | Page down / up |
| `f{c}`  | Jump to character     |
| `t{c}`  | Jump until character  |
| `; ,`   | Repeat / reverse      |
| `%`     | Matching bracket      |
| `H M L` | Top / middle / bottom |


---

# Insert mode
| Motion | Description |
|----|-------|
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Line start / end |
| `o` / `O` | New line below / above |
| `Esc` | Normal mode |


---

# Visual mode
| Motion | Description |
|----|-------|
| `v` / `V` / `<C-v>` | Character / line / block (rows and columns) |
| `>` / `<` | indent / unindent |
| `y` / `d` / `p` | Yank / delete / paste |
| `U` / `u` / `~` | Uppercase / lowercase / switch casing |


---

# Editing
| Motion | Description |
|----|-------|
| `x` | Delete character |
| `dd` / `D` | Delete line / to end |
| `yy` | Yank line |
| `p` / `P` | Paste after / before |
| `u` / `<C-r>` | Undo / redo |
| `.` | Repeat last change |
| <C-a> | Increment number under cursor |
| <C-x> | Decrement number under cursor |


---

# Windows
| Motion             | Description                      |
| ---------------- | --------------------------- |
| `<C-w>s` / `<C-w>v`   | Split: horizontal / vertical |
| `<C-w>q`       | Close window                |
| `<C-w>h j k l` | Navigate between windows                    |


---

# Buffers
| Command           | Description        |
| ----------------- | ------------- |
| `:ls`             | List buffers  |
| `:bnext` / `:bprev` | Cycle: Next / previous buffer |
| `:bd` | Delete buffer |
| `:q` | Quit the current buffer if there are no unsaved changes |
| `:q!` | Force quit the current buffer even if there is unsaved changes |
| `:qa` | Quits all buffers except those that have unsaved changes |
| `:qa!` | Force quit all buffers even if there unsaved changes |
| `:w` | Write buffer even if there are no changes |
| `:wq` | Write and quit buffer even if there are no changes |
| `:wqa` | Write and quit all buffers even if there are no changes |
| `:x` | Write buffer if there are unsaved changes and then quit the current buffer |
| `:xa` / `ZZ` | Write all buffers with unsaved changes and then quit them all |


---

# Search

| Motion       | Description            |
| --------- | ----------------- |
| `/` / `?` | Search forward / backward |
| `n` / `N`   | Next / previous match   |
| `gn` / `gN` | Select next / previous match      |
| `*` / `#`   | Word under cursor |


---

# Text Objects
| Motion         | Description              |
| -------------- | ------------------------ |
| `iw` / `aw`      | Inner / a word           |
| `ip` / `ap`      | Inner / a paragraph      |
| `i(` / `i[` / `i{` | Inside delimiters        |
| `it` / `at`      | Inside / around HTML tag |


---

# Registers

| Register | Purpose          |
| -------- | ---------------- |
| `"`      | Default          |
| `0`      | Last yank        |
| `_`      | Black hole       |
| `+`      | System clipboard |


---


| Example | Description |
| ------- | ----------- |
|`_dd`   | Delete without yanking |
|`+y`    | Copy to clipboard |


---

# Macros
| Motion  | Description         |
| ---- | -------------- |
| `qa` | Record macro in register a |
| `q`  | Stop           |
| `@a` | Play           |
| `@@` | Repeat         |


---

# Marks

| Command            | Description        |
| ------------------ | ------------- |
| `:copen` `:cclose` | Quickfix      |
| `:cnext` `:cprev`  | Navigate      |
| `:lopen`           | Location list |


---

# Search Patterns

## Words & Text

| Pattern | Description | Suggested Use Case |
| ------ | ----------- | -------- |
| `/\<word\>` | Match a whole word only (no partial matches) | Useful when searching identifiers or variables. |
| `/\v(\w+)\s+\1` | Find repeated consecutive words | Useful for catching typos like `the the`. |


---

## Lines

| Pattern | Description | Suggested Use Case |
| ------ | ----------- | -------- |
| `/^\s*$/` | Match lines containing only whitespace | Useful for cleanup and formatting. |
| `/^\%(.*foo\)\@!` | Match lines NOT containing the word `foo` | Useful when looking for non-conformant records in a known structure  |


---

## Whitespace & Formatting

| Pattern | Description | Suggested Use Case |
| ------ | ----------- | -------- |
| `/\s\+$/` | Find trailing whitespace | Useful before commits |
| `/\v^.{81,}$` | Find lines longer than `80` characters | Useful for style enforcement |


---

## Numbers & Strings

| Pattern | Description | Suggested Use Case |
| ------ | ----------- | -------- |
| `/\v\d+` | Match integers | Useful when looking for magic numbers |
| `/"[^"]*"` | Match double-quoted strings | Useful for cleanup and formatting |
| `/'[^']*'` | Match single-quoted strings | Useful for cleanup and formatting |


---

## Between Delimiters

| Pattern | Description | Suggested Use Case |
| ------ | ----------- | -------- |
| `/\v\([^)]*\)` | Text inside parentheses | Selecting a block of text |
| `/\v\[[^\]]*\]` | Text inside brackets | Finding initialised lists / vectors |


--- 

## Code-Oriented Searches

```vim
/\v(TODO|FIXME|NOTE) " Find TODO-style comments - Useful navigate to code labelled by TODO-style comment 
/\v^\s*(function|def|fn)\s+\w+ " Find common function definitions - Useful to cycle through function definitions
```

--- 

## Regex
Neovim uses Vim regex, not PCRE
Use \v (very magic) to reduce escaping

--- 

### Character Classes

| Pattern    | Meaning                   |
| ---------- | ------------------------- |
| `.`        | Any char except newline   |
| `\w \d \s` | Word / digit / whitespace |
| `\W \D \S` | Negated versions          |
| `[abc]`    | a, b, or c                |
| `[^abc]`   | Not a, b, or c            |
| `[a-g]`    | Range                     |


--- 

### Anchors

| Pattern | Meaning             |
| ------- | ------------------- |
| `^ $`   | Start / end of line |
| `\b`    | Word boundary       |
| `\B`    | Not word boundary   |


--- 

### Escaped Characters

| Pattern        | Meaning                         |
| -------------- | ------------------------------- |
| `\.` `\*` `\\` | Escaped specials                |
| `\t \n \r`     | Tab / newline / carriage return |


--- 

### Groups & Lookarounds
| Pattern   | Meaning                 |
| --------- | ----------------------- |
| `(abc)`   | Capture group           |
| `\1`      | Backreference           |
| `(?:abc)` | Non-capturing           |
| `(?=abc)` | Lookahead               |
| `(?!abc)` | Negative lookahead      |
| `(?<=abc)` | Lookbehind |
| `(?<!abc)` | Negative lookbehind |


---


| Example | Description |
| ------- | ----------- |
| ```vim /foo\@<=bar```| Match `bar` if preceded by `foo` |
| ```/foo\@<!bar``` | Match bar NOT preceded by foo |


---

### Quantifiers & Alternation

| Pattern | Meaning          |    |
| ------- | ---------------- | -- |
| `* + ?` | 0+, 1+, optional |    |
| `{5}`   | Exactly five     |    |
| `{2,}`  | Two or more      |    |
| `{1,3}` | One to three     |    |
| `+?`    | Lazy             |    |
| `ab     | cd`              | Or |


---

### Tips & Tricks

| Pattern | Description |
|------|-------------|
| `\v` | **Very magic mode** — treats most characters as special, drastically reducing escaping. Use this first in complex regex. |
| `\zs` | **Start match here** — excludes everything before it from the final match. Useful in replacements. |
| `\ze` | **End match here** — excludes everything after it from the final match. |
| `(?=)` | **Positive lookahead** — assert that a pattern follows, without consuming it. |
| `(?!)` | **Negative lookahead** — assert that a pattern does *not* follow. |
| `(?<=)` | **Positive lookbehind** — assert that a pattern precedes the match. |
| `(?<!)` | **Negative lookbehind** — assert that a pattern does *not* precede the match. |

```vim 
\v(foo|bar)\d+ " Match foo or bar followed by digits |
```

---


| Example | Description |
| ------- | ----------- |
| `/foo\zsbar` | Match only part of a word: matches bar in foobar (but not foo). |
| `/foo\zebar` | Exlude part of a match: Matches foo in foobar. |
| `/foo\@=bar` | Match foo only if followed by bar. |
| `/foo\@!bar` | Match foo only if **not** followed by bar. |
| `/foo\@<=bar` | Match bar only if preceded by foo. |
| `/foo\@<!bar ` | Match bar only if NOT preceded by foo. |


---

# Shell Commands

| Command | Description |
| ------- | ----------- |
| `:!<cmd>` | Executes `<cmd>` on visual selection |


---

# Help
- `:help {topic}` — Help for topic

---
Press `q` or `<Esc>` to close
