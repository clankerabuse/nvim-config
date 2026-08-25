-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Center cursor after jumping with search
map("n", "n", "nzzzv", { desc = "Next match and center" })
map("n", "N", "Nzzzv", { desc = "Prev match and center" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Move lines in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Better paste (don't overwrite register when pasting over selection)
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Quick save and quit (avoid conflicts with LazyVim quit/window groups)
map("n", "<leader><leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader><leader>q", "<cmd>q<cr>", { desc = "Quit window" })

-- Clear search highlight (LazyVim already owns most of <leader>u*)
map("n", "<leader>uH", "<cmd>noh<cr>", { desc = "Clear search highlight" })

-- Manually check for (and reload) changes made on disk.
-- Usually unnecessary thanks to the `auto_read` autocmds, but handy as an
-- explicit "did it pick that up yet?" escape hatch.
map("n", "<leader>uR", "<cmd>checktime<cr>", { desc = "Reload buffer from disk" })

-- Window management under LazyVim's <leader>w group (NOT <leader>s — that is search)
map("n", "<leader>wv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>we", "<C-w>=", { desc = "Equal splits" })
map("n", "<leader>wx", "<cmd>close<cr>", { desc = "Close split" })

-- Buffer switching (LazyVim also sets these; keep the familiar Shift-h/l)
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Prefill :lua= so an expression can be typed (the old <cmd>lua =<cr> evaluated nothing)
map("n", "<leader>uL", ":lua=", { desc = "Evaluate Lua expression" })

-- Show dynamic language extras detected for this project
map("n", "<leader>cl", function()
	local info = require("config.langdetect").info()
	local msg = string.format("Project root: %s\nDetected extras (%d):", info.root, info.count)
	if info.count == 0 then
		msg = msg .. " none"
	else
		for _, extra in ipairs(info.extras) do
			msg = msg .. "\n  - " .. extra
		end
	end
	vim.notify(msg, vim.log.levels.INFO, { title = "LangDetect" })
end, { desc = "Show detected language extras" })
