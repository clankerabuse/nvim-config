return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			prettier = {
				prepend_args = { "--use-tabs", "--tab-width", "4" },
			},
			prettierd = {
				prepend_args = { "--use-tabs", "--tab-width", "4" },
			},
		},
		default_format_opts = {
			timeout_ms = 3000,
			async = true,
			quiet = false,
		},
	},
}
