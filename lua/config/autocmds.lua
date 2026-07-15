-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Close special buffers with `q`
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("close_with_q", { clear = true }),
	pattern = { "help", "qf", "man", "lspinfo", "startuptime", "checkhealth", "git" },
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, nowait = true })
	end,
})

-- Auto-resize splits when the terminal window is resized
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
	callback = function()
		vim.cmd("wincmd =")
	end,
})

-- Disable diagnostics in some files where they are rarely useful
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("disable_diagnostics", { clear = true }),
	pattern = { "lazy", "mason", "noice" },
	callback = function()
		vim.diagnostic.enable(false)
	end,
})

-- Auto-reload files changed on disk. This is what makes edits from the
-- avante/opencode agent (or git, formatters, other external tools) show up
-- immediately in any open buffer, without needing to manually `:e` it.
-- `FocusGained`/`TermClose`/`TermLeave` catch the "left and came back" case,
-- while `CursorHold`/`CursorHoldI`/`BufEnter` catch changes that happen while
-- you're still sitting in the same window watching the agent work (e.g. the
-- avante sidebar is streaming edits into a file you already have open).
local auto_read_group = vim.api.nvim_create_augroup("auto_read", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave", "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = auto_read_group,
	callback = function()
		if vim.bo.buftype == "" then
			vim.cmd("checktime")
		end
	end,
})

-- Force 4-space tabs on ALL filetypes (overrides ftplugin defaults)
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("force_tabs", { clear = true }),
	callback = function()
		vim.bo.tabstop = 4
		vim.bo.shiftwidth = 4
		vim.bo.expandtab = false
	end,
})

-- Let the user know when a buffer was silently refreshed from disk, so a
-- file changing underneath them (e.g. mid-edit by the agent) doesn't go
-- unnoticed.
vim.api.nvim_create_autocmd("FileChangedShellPost", {
	group = auto_read_group,
	callback = function()
		vim.notify(
			string.format("Reloaded from disk: %s", vim.fn.expand("<afile>:t")),
			vim.log.levels.INFO,
			{ title = "Auto-reload" }
		)
	end,
})
