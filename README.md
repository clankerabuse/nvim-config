# 💤 LazyVim

A customized LazyVim config with a terminal-native colorscheme, dynamic
language extras, and a tighter IDE-style plugin set.

## Highlights

- **Terminal** colorscheme — a self-contained, high-contrast dark theme
  (`colors/terminal.lua`) with coverage for the plugins below, no
  dependency on an external colorscheme plugin.
- **Auto-reload on external edits** — buffers refresh automatically when
  git, a formatter, or another tool changes a file on disk, with a subtle
  notification. See `autoread` in `lua/config/options.lua` and the
  `auto_read` autocmds in `lua/config/autocmds.lua`.
- **Dynamic language detection** (`lua/config/langdetect.lua`) — scans the
  project for marker files and enables the matching LazyVim language extras
  (and their DAP adapters, linters, formatters, etc.) on the fly.
- **Debugging, tasks & refactors** — `dap.core`, `editor.overseer`, and
  `editor.refactoring` LazyVim extras are enabled (`<leader>d*`,
  `<leader>o*`, `<leader>r*`).
- **Harpoon** (`<leader>m*`) for pinning and jumping between files — kept as
  a hand-rolled spec (see `lua/plugins/harpoon.lua`) so its keys don't clash
  with kulala's `<leader>h*` HTTP-request group.
- **Peek / outline** (`<leader>p*`) via Glance + Navbuddy, kept off the
  LazyVim `<leader>s` search group.
- **Git extras** — Neogit (`<leader>gn`) and Diffview (`<leader>gV` /
  `<leader>gF` / `<leader>gA`) without stealing gitsigns hunk keys.
- **Tabs over spaces** (4-wide).
- Custom cursor styling + a subtle animated cursor smear
  (`ui.smear-cursor`).

## Key groups

| Prefix       | Group                                         |
| ------------ | --------------------------------------------- |
| `<leader>m`  | Harpoon (add/menu/jump)                       |
| `<leader>h`  | Kulala HTTP client                            |
| `<leader>p`  | Peek (Glance definitions/refs + Navbuddy)     |
| `<leader>w`  | Windows (incl. custom split helpers)          |
| `<leader>d`  | Debugging (nvim-dap)                          |
| `<leader>o`  | Overseer tasks                                |
| `<leader>r`  | Refactoring                                   |
| `<leader>g`  | Git (Neogit, Diffview, gitsigns, Snacks)      |
| `<leader>s`  | Search (LazyVim / Snacks picker)              |
| `<leader>cl` | Show detected language extras for the CWD     |

Refer to the [documentation](https://lazyvim.github.io/installation) to get
started, and `<leader>?` / which-key for the full, current keymap list.
