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

-- Quick save and quit (avoid conflicts with LazyVim quit group)
map("n", "<leader><leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader><leader>q", "<cmd>q<cr>", { desc = "Quit window" })

-- Clear search highlight
map("n", "<leader>uh", "<cmd>noh<cr>", { desc = "Clear search highlight" })

-- Manually check for (and reload) changes made on disk, e.g. by avante/opencode.
-- Usually unnecessary thanks to the `auto_read` autocmds, but handy as an
-- explicit "did it pick that up yet?" escape hatch.
map("n", "<leader>uR", "<cmd>checktime<cr>", { desc = "Reload buffer from disk" })

-- Window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertical" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Equal splits" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Close split" })

-- Diagnostic quick navigation
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })

-- Buffer switching
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Toggle wrap
map("n", "<leader>uw", "<cmd>set wrap!<cr>", { desc = "Toggle wrap" })

-- Evaluate lua expression
map("n", "<leader>uL", "<cmd>lua =<cr>", { desc = "Evaluate Lua expression" })

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
