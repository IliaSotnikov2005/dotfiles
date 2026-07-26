return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				dockerls = {},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "dockerfile" } },
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				docker = { "hadolint" },
			},
		},
	},
}
