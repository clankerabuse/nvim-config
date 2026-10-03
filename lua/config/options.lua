-- Editor options, applied before lazy.nvim starts.
-- LazyVim already sets sane defaults; these are the personal touches.

local opt = vim.opt

-- Clipboard integration with the system.
opt.clipboard = "unnamedplus"

-- Line numbers.
opt.number = true
opt.relativenumber = true

-- Indentation: 2 spaces, expand tabs (LazyVim's default, made explicit here).
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Search.
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Keep context visible around the cursor.
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Splits feel natural.
opt.splitright = true
opt.splitbelow = true

-- A nicer command line.
opt.cmdheight = 1
opt.showmode = false
opt.signcolumn = "yes"
opt.updatetime = 200
opt.timeoutlen = 400

-- Undo history that survives restarts.
opt.undofile = true
opt.undolevels = 10000

-- Don't wrap code, but do wrap prose/markdown softly.
opt.wrap = false
opt.linebreak = true

-- Persistent cursor line / column highlight.
opt.cursorline = true

-- Reload files changed on disk (OpenCode edits buffers live).
opt.autoread = true

-- Faster completion menu, no slowing on long lines.
opt.completeopt = "menu,menuone,noselect"
opt.pumheight = 12
