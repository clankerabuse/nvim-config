-- Personal keymaps, layered on top of LazyVim's defaults.
--
-- Challenging the "everything on <leader>" default: LazyVim ships several
-- hundred Space-menu bindings, so this config WIPES every default leader
-- keymap at the end of startup and keeps only a small, hand-picked set.
-- We add them back deliberately as they earn their place.
--
-- Kept set:
--   <leader>bd/bo/bl/bh/bb  buffers (the only "family" we keep)
--   <leader>oa/ao/oi/oI/os/op/oV/od/oc/aq  OpenCode (see plugins/opencode.lua)
--   <leader>e              file tree (alias of `\`)
--   <leader>ff/fr/fg/fb    finders
--   <leader>cf             format
--   <leader>p              paste without clobbering
--   <leader>qq/qQ          quit
--
-- The tree and OpenCode bindings live in lua/plugins/explorer.lua and
-- lua/plugins/opencode.lua.

local map = vim.keymap.set

--------------------------------------------------------------------------------
-- Handy, high-frequency maps (NOT on <leader> -- these survive the purge)
--------------------------------------------------------------------------------

-- Quick save / quit like a normal editor.
map({ "n", "i", "v" }, "<C-s>", "<cmd>silent! w<cr>", { desc = "Save file" })
map("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit window" })

-- Better window navigation with a single Ctrl-hjkl.
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Resize windows with the arrow keys.
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Stay centered during jumps and searches.
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll Down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll Up (centered)" })
map("n", "n", "nzzzv", { desc = "Next Search Result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous Search Result (centered)" })

-- Move selected lines up/down (Visual mode).
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move Selection Down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move Selection Up" })

--------------------------------------------------------------------------------
-- Curated Space menu (the only <leader> maps that are allowed to exist)
--------------------------------------------------------------------------------

-- File tree. `<leader>e` is the main one; `\` / `|` also work (see explorer.lua).
map("n", "<leader>e", function()
  Snacks.explorer({ cwd = LazyVim.root() })
end, { desc = "File Explorer" })

-- Buffer management: the one family worth keeping.
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })
map("n", "<leader>bo", "<cmd>%bd|e#|bd#<cr>", { desc = "Delete Other Buffers" })
map("n", "<leader>bl", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bh", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Finders.
map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Find Files (root)" })
map("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Recent Files" })
map("n", "<leader>fg", function()
  Snacks.picker.grep()
end, { desc = "Grep (root)" })
map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Buffers" })

-- Format / lint.
map({ "n", "v" }, "<leader>cf", function()
  LazyVim.format({ force = true })
end, { desc = "Format File" })

-- Paste over a selection without clobbering the unnamed register.
map("x", "<leader>p", [["_dP]], { desc = "Paste (don't yank selection)" })

-- Close things.
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>qQ", "<cmd>qa!<cr>", { desc = "Quit All (force)" })

--------------------------------------------------------------------------------
-- Wipe every remaining default <leader> keymap.
--
-- Runs after startup so it sees maps registered lazily by plugins on
-- VeryLazy / plugin load. We keep the curated set above by name, plus
-- <leader>e (the tree). Anything else on <leader> is deleted recursively,
-- so disabling a parent (e.g. <leader>o) also removes its children.
--------------------------------------------------------------------------------

local KEEP = {
  ["<leader>e"] = true,

  -- buffers
  ["<leader>bd"] = true,
  ["<leader>bo"] = true,
  ["<leader>bl"] = true,
  ["<leader>bh"] = true,
  ["<leader>bb"] = true,

  -- finders
  ["<leader>ff"] = true,
  ["<leader>fr"] = true,
  ["<leader>fg"] = true,
  ["<leader>fb"] = true,

  -- misc
  ["<leader>cf"] = true,
  ["<leader>p"] = true,
  ["<leader>qq"] = true,
  ["<leader>qQ"] = true,
}

-- OpenCode maps are defined in plugins/opencode.lua, including the <leader>o*
-- and <leader>a* families. Keep every one of them.
local OPENCODE_PREFIXES = { "<leader>o", "<leader>a" }

local function is_kept(lhs)
  if KEEP[lhs] then
    return true
  end
  for _, prefix in ipairs(OPENCODE_PREFIXES) do
    if vim.startswith(lhs, prefix) then
      return true
    end
  end
  return false
end

-- Neovim stores the leader key literally (e.g. a space), so expand "<leader>"
-- to the real leader before comparing against a buffer's lhs.
local function normalize(lhs)
  local leader = vim.g.mapleader or "\\"
  if type(leader) == "string" and leader ~= "" and leader ~= " " then
    lhs = lhs:gsub("<leader>", leader, 1)
  end
  -- Space leaders come back as a literal leading space.
  if leader == " " then
    lhs = lhs:gsub("^ ", "<leader>", 1)
  end
  lhs = lhs:gsub("^<Space>", "<leader>", 1)
  return lhs
end

local function purge_leader_maps()
  local modes = { "n", "v", "x", "s", "o", "i", "t", "c" }
  local removed = {}

  for _, mode in ipairs(modes) do
    for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do
      local lhs = m.lhs
      local normalized = normalize(lhs)
      if vim.startswith(normalized, "<leader>") and not is_kept(normalized) then
        pcall(vim.keymap.del, mode, lhs)
        removed[normalized] = true
      end
    end
  end

  local count = vim.tbl_count(removed)
  if count > 0 then
    vim.notify(("Trimmed %d default leader keymaps"):format(count), vim.log.levels.INFO)
  end
end

-- LazyVim loads this file from inside its own VeryLazy callback, so registering
-- another VeryLazy handler here would be too late to fire. Instead schedule the
-- purge; vim.schedule runs after the current event callback (and all plugin
-- keymap registration) completes. A second deferred pass catches any lazy
-- keymaps that land on a later tick.
local group = vim.api.nvim_create_augroup("UserLeaderPurge", { clear = true })
vim.schedule(purge_leader_maps)
vim.defer_fn(purge_leader_maps, 500)
