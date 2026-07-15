return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			javascriptreact = { "prettierd", "prettier", stop_after_first = true },
			typescriptreact = { "prettierd", "prettier", stop_after_first = true },
		},
		formatters = {
			prettier = {
				prepend_args = { "--use-tabs", "--tab-width", "4" },
			},
			prettierd = {
				prepend_args = { "--use-tabs", "--tab-width", "4" },
			},
		},
	},
}
