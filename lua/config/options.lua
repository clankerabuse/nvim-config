-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkon700,i-cr:blinkon100"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "both"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

-- Neovim's built-in ftplugins hardcode PEP8/language-recommended indent
-- style for a few filetypes, which silently overrides the tabs-everywhere
-- settings above:
--   - $VIMRUNTIME/ftplugin/python.vim forces `expandtab tabstop=4
--     softtabstop=4 shiftwidth=4` (i.e. 4 spaces) unless this is set to 0.
--   - Markdown's equivalent knob (`g:markdown_recommended_style`) is
--     already disabled by LazyVim's own defaults.
-- Setting these to 0 keeps tabs (still displayed/indented at width 4)
-- consistent across every filetype, Python included.
vim.g.python_recommended_style = 0

-- General QoL
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = false
vim.opt.smartindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split" -- live preview substitutions
vim.opt.confirm = true -- ask before closing unsaved buffers
vim.opt.breakindent = true
vim.opt.mouse = "a"

-- Global statusline (works well with lualine)
vim.opt.laststatus = 3

-- Auto-reload buffers that changed on disk (e.g. edits made by the
-- avante/opencode agent, git checkouts, formatters run outside Neovim, etc.)
-- Paired with the `auto_read` autocmds in config/autocmds.lua, which poll
-- for changes and run `:checktime` so this actually kicks in.
vim.opt.autoread = true

-- Disable auto-continuation of comments. After pressing Enter (or `o`/`O`)
-- on a comment line, the next line should NOT start with a comment marker.
vim.opt.formatoptions:remove({ "r", "o" })
