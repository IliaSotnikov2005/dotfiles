return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				pyright = {
					settings = {
						pyright = {
							disableOrganizeImports = false,
							analysis = {
								useLibraryCodeForTypes = true,
								autoSearchPaths = true,
								diagnosticMode = "workspace",
								autoImportCompletions = true,
							},
						},
					},
				},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "python" } },
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				python = { "isort", "black" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				python = { "flake8" },
			},
		},
	},
}
