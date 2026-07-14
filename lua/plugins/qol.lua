return {
	-- Better word motions (camelCase, snake_case, etc.)
	{
		"chrisgrieser/nvim-spider",
		keys = {
			{ "w", "<cmd>lua require('spider').motion('w')<cr>", mode = { "n", "o", "x" }, desc = "Spider-w" },
			{ "e", "<cmd>lua require('spider').motion('e')<cr>", mode = { "n", "o", "x" }, desc = "Spider-e" },
			{ "b", "<cmd>lua require('spider').motion('b')<cr>", mode = { "n", "o", "x" }, desc = "Spider-b" },
			{ "ge", "<cmd>lua require('spider').motion('ge')<cr>", mode = { "n", "o", "x" }, desc = "Spider-ge" },
		},
	},

	-- Split/join code blocks
	{
		"Wansmer/treesj",
		keys = {
			{ "gJ", "<cmd>TSJJoin<cr>", desc = "Join code block" },
			{ "gS", "<cmd>TSJSplit<cr>", desc = "Split code block" },
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({ use_default_keymaps = false })
		end,
	},

	-- Inline diagnostics at end of line
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		config = function()
			require("tiny-inline-diagnostic").setup({
				preset = "minimal",
				transparent_bg = true,
				hi = {
					error = "DiagnosticError",
					warn = "DiagnosticWarn",
					info = "DiagnosticInfo",
					hint = "DiagnosticHint",
				},
			})
			vim.diagnostic.config({ virtual_text = false })
		end,
	},

	-- Magit-style git interface
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		keys = {
			{ "<leader>gn", "<cmd>Neogit<cr>", desc = "Neogit" },
			{ "<leader>gc", "<cmd>Neogit commit<cr>", desc = "Neogit commit" },
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim", -- optional, provides better pickers
		},
		config = true,
	},

	-- Side-by-side diff view
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose", "DiffviewToggleFiles" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
			{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
		},
	},

	-- HTTP client
	{
		"mistweaverco/kulala.nvim",
		ft = { "http", "rest" },
		keys = {
			{ "<leader>hr", "<cmd>lua require('kulala').run()<cr>", desc = "Run HTTP request" },
			{ "<leader>ha", "<cmd>lua require('kulala').run_all()<cr>", desc = "Run all HTTP requests" },
			{ "<leader>hp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Prev HTTP request" },
			{ "<leader>hn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Next HTTP request" },
		},
		config = function()
			require("kulala").setup()
		end,
	},

	-- Open URLs with gx
	{
		"chrishrb/gx.nvim",
		keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" }, desc = "Open URL" } },
		cmd = { "Browse" },
		init = function()
			vim.g.netrw_nogx = 1
		end,
		config = true,
	},

	-- Distraction-free writing/coding
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen mode" } },
		opts = {
			window = {
				width = 120,
				options = {
					signcolumn = "no",
					number = false,
					relativenumber = false,
					cursorline = false,
				},
			},
		},
	},

	-- LSP go-to preview window
	{
		"dnlhc/glance.nvim",
		cmd = "Glance",
		keys = {
			{ "<leader>sg", "<cmd>Glance definitions<cr>", desc = "Glance definitions" },
			{ "<leader>sr", "<cmd>Glance references<cr>", desc = "Glance references" },
			{ "<leader>sy", "<cmd>Glance type_definitions<cr>", desc = "Glance type definitions" },
			{ "<leader>sm", "<cmd>Glance implementations<cr>", desc = "Glance implementations" },
		},
		config = function()
			require("glance").setup({
				border = {
					enable = true,
				},
			})
		end,
	},

	-- Interactive symbol outline/navigation
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		keys = {
			{
				"<leader>sn",
				function()
					require("nvim-navbuddy").open()
				end,
				desc = "Navbuddy outline",
			},
		},
		config = function()
			require("nvim-navbuddy").setup({
				lsp = { auto_attach = true },
			})
		end,
	},
}
