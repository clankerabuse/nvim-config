return {
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			indent = {
				enable = true,
				-- nvim-treesitter's indent module is still experimental and is
				-- especially rough on Python: it routinely mis-indents new lines
				-- after colons, elif/else, multi-line calls, decorators, etc.
				-- Neovim ships a mature, purpose-built PEP 8 indent script for
				-- Python (indent/python.vim); let that handle it instead of
				-- treesitter guessing from the (sometimes incomplete) parse tree.
				disable = { "python" },
			},
		},
	},
}
