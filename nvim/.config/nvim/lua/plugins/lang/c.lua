return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = {},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "c", "cpp" } },
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				c = { "cpplint" },
				cpp = { "cpplint" },
			},
		},
	},
}
