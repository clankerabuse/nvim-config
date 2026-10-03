-- Autocmds, loaded on the VeryLazy event.
-- Defaults live in lua/lazyvim/config/autocmds.lua; these are additions.

local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- OpenCode's panel and output buffers should feel like normal, readable text.
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = { "opencode", "opencode_output" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = false
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Highlight yanked text briefly so you can see what was captured.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  desc = "Highlight on yank",
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Restore the cursor to the last known position when reopening a file.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  desc = "Restore last cursor position",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

--------------------------------------------------------------------------------
-- Live-reload files changed on disk (e.g. by the OpenCode agent).
--
-- Neovim only re-reads a changed file when `checktime` runs, and only on
-- specific events, so an edit made while you sit in the same window can go
-- unnoticed. These autocmds call `checktime` whenever it makes sense, and keep
-- the cursor in place across the reload. A buffer with unsaved changes is
-- intentionally NOT reloaded (Vim's W12 guard) so you never lose work.
--------------------------------------------------------------------------------

local function reload_changed_buffers()
  -- Skip while a prompt/message is up so we don't trigger dialogs mid-action.
  if vim.fn.getcmdwintype() ~= "" then
    return
  end
  vim.cmd("checktime")
end

-- Regaining focus (e.g. coming back from the browser or a terminal) is the most
-- common moment for external edits to have landed.
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup,
  desc = "Reload files changed on disk on focus",
  callback = reload_changed_buffers,
})

-- Also check when entering a buffer or when the cursor rests, so an edit made
-- while the OpenCode panel has focus shows up as soon as you look at the file.
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI" }, {
  group = augroup,
  desc = "Reload files changed on disk while idle",
  callback = reload_changed_buffers,
})

-- Vim's default FileChangedShell handling can prompt (`W12`) or abandon the
-- reload. For an unmodified buffer we want a silent, automatic reload; when the
-- buffer IS modified we keep it and let the user decide.
vim.api.nvim_create_autocmd("FileChangedShell", {
  group = augroup,
  desc = "Auto-reload unmodified buffers changed on disk",
  callback = function(args)
    local buf = args.buf
    -- Modified buffers keep their unsaved content; show the usual warning.
    if vim.bo[buf].modified then
      vim.v.fcs_choice = ""
      return
    end
    -- Preserve cursor and view around the silent reload.
    local win = vim.api.nvim_get_current_win()
    local view = vim.fn.winsaveview()
    vim.v.fcs_choice = "reload"
    vim.schedule(function()
      if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
        vim.fn.winrestview(view)
      end
    end)
  end,
})

-- After a reload completes, restore the cursor once more (e.g. when the reload
-- was triggered by the OpenCode panel writing the file).
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  group = augroup,
  desc = "Restore cursor after external reload",
  callback = function()
    vim.schedule(function()
      vim.cmd("normal! zz")
    end)
  end,
})
