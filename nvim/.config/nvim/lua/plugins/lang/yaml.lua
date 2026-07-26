return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				yamlls = {},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "yaml" } },
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				yaml = { "prettierd" },
			},
		},
	},
}
