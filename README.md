# 💤 LazyVim

A customized LazyVim config, tuned for agentic coding with avante.nvim +
opencode and a fuller IDE feature set.

## Highlights

- **Terminal** colorscheme — a self-contained, high-contrast dark theme
  (`colors/terminal.lua`) with coverage for every plugin below, no
  dependency on an external colorscheme plugin.
- **avante.nvim + opencode** — agentic AI editing via the ACP bridge
  (`opencode acp`). Full keymaps under `<leader>a*`, image pasting
  (img-clip.nvim), markdown-rendered chat, and a blink.cmp `@avante` source.
  See [`lua/plugins/ai.lua`](lua/plugins/ai.lua).
- **Auto-reload on external edits** — buffers refresh automatically when the
  agent (or git, a formatter, etc.) changes a file on disk, with a subtle
  notification so it's never a surprise. See `autoread` in
  `lua/config/options.lua` and the `auto_read` autocmds in
  `lua/config/autocmds.lua`.
- **supermaven-nvim** for inline ghost-text completions (kept independent of
  avante's own suggestion engine).
- **Dynamic language detection** (`lua/config/langdetect.lua`) — scans the
  project for marker files and enables the matching LazyVim language extras
  (and their DAP adapters, linters, formatters, etc.) on the fly, so one
  config adapts to whatever repo you open it in.
- **Debugging, tasks & refactors** — `dap.core`, `editor.overseer`, and
  `editor.refactoring` LazyVim extras are enabled, so debugging (`<leader>d*`),
  task running (`<leader>o*`), and extract-function/variable refactors
  (`<leader>r*`) work out of the box for any detected language.
- **Harpoon** (`<leader>m*`) for pinning and jumping between files — kept as
  a hand-rolled spec (see `lua/plugins/harpoon.lua`) so its keys don't clash
  with kulala's `<leader>h*` HTTP-request group.
- **Project switching** (`<leader>fp`) via project.nvim + Telescope.
- **Tabs over spaces** (4-wide).
- Custom cursor styling + a subtle animated cursor smear
  (`ui.smear-cursor`).

## Key groups

| Prefix        | Group                                    |
| ------------- | ----------------------------------------- |
| `<leader>a`   | Avante (ask/chat/edit/history/...)        |
| `<leader>m`   | Harpoon (add/menu/jump)                   |
| `<leader>h`   | Kulala HTTP client                        |
| `<leader>d`   | Debugging (nvim-dap)                      |
| `<leader>o`   | Overseer tasks                            |
| `<leader>r`   | Refactoring                               |
| `<leader>g`   | Git (Neogit, Diffview, gitsigns)          |
| `<leader>s`   | Split/window management + Glance/Navbuddy |
| `<leader>cl`  | Show detected language extras for the CWD |

Refer to the [documentation](https://lazyvim.github.io/installation) to get
started, and `<leader>?` / which-key for the full, current keymap list.
