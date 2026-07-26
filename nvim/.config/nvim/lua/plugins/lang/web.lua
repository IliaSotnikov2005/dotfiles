return {
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				emmet_ls = {
					filetypes = {
						"css",
						"eruby",
						"html",
						"javascriptreact",
						"less",
						"sass",
						"scss",
						"svelte",
						"typescriptreact",
						"vue",
					},
				},
				html_lsp = {},
				tailwindcss = {},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "html", "css", "scss" } },
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				css = { "prettierd" },
				html = { "prettierd" },
				scss = { "prettierd" },
			},
		},
	},
}
