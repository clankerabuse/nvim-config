local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

local langdetect = require("config.langdetect")

-- Disable netrw before it loads (we use mini-files and other pickers)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- NOTE: build this as a real list rather than `unpack(...)`-ing it inline
-- inside the `spec` table literal below. A multi-value expression like
-- `unpack(x)` is only expanded to multiple entries when it's the *last*
-- item in a table constructor; in the middle of one (as it would be here,
-- with `{ import = "plugins" }` following it) Lua silently truncates it to
-- a single value. That would mean at most one dynamically detected
-- language extra ever gets loaded (and none at all, i.e. a crash, when a
-- project matches zero of them) instead of the full, variable-length list
-- `langdetect.specs()` actually returns.
local plugin_spec = {
	-- add LazyVim and import its plugins
	{ "LazyVim/LazyVim", import = "lazyvim.plugins" },
}
-- dynamically import language extras based on project files
vim.list_extend(plugin_spec, langdetect.specs())
-- import/override with your plugins
table.insert(plugin_spec, { import = "plugins" })

require("lazy").setup({
	spec = plugin_spec,
	defaults = {
		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
		lazy = false,
		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
		-- have outdated releases, which may break your Neovim install.
		version = false, -- always use the latest git commit
		-- version = "*", -- try installing the latest stable version for plugins that support semver
	},
	install = { colorscheme = { "tokyonight", "habamax" } },
	checker = {
		enabled = true, -- check for plugin updates periodically
		notify = false, -- notify on update
	}, -- automatically check for plugin updates
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
