return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				solidity_ls_nomicfoundation = {},
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				solidity = { "prettierd" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				solidity = { "solhint" },
			},
		},
	},
}
