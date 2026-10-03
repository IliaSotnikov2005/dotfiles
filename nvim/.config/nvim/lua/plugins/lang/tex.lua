return {
	{
		"lervag/vimtex",
		ft = { "tex", "bib" },
		init = function()
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				options = {
					"-xelatex",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
					"-shell-escape",
				},
			}
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_view_automatic = 1
			vim.g.vimtex_quickfix_mode = 0
			vim.g.vimtex_mappings_disable = { n = { "textoc" } }
		end,
		config = function()
			vim.keymap.set("n", "<Space>lo", "<plug>(vimtex-toc-open)", { desc = "Open TOC" })
		end,
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				tex = { "latexindent" },
			},
		},
	},
}