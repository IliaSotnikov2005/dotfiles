return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				jsonls = {
					filetypes = { "json", "jsonc" },
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "json" } },
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				json = { "prettierd", "fixjson" },
				jsonc = { "prettierd", "fixjson" },
			},
		},
	},
}
