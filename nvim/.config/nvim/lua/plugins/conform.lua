return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = { "ConformInfo" },
	keys = {
		{ "<Leader>lf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format buffer" },
	},
	opts = {
		formatters_by_ft = {
			markdown = { "prettierd" },
			svelte = { "prettierd" },
		},
		formatters = {
			golines = {
				prepend_args = { "--max-len=120" },
			},
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				if vim.b[args.buf].disable_autoformat then
					return
				end
				require("mini.trailspace").trim()
				require("conform").format({
					bufnr = args.buf,
					timeout_ms = 500,
					lsp_fallback = true,
				})
			end,
		})
	end,
}
