return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = { "ConformInfo" },
	keys = {
		{ "<Leader>lf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format buffer" },
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			go = { "gofumpt", "goimports", "golines" },
			javascript = { "prettierd", "eslint_d" },
			typescript = { "prettierd", "eslint_d" },
			javascriptreact = { "prettierd", "eslint_d" },
			typescriptreact = { "prettierd", "eslint_d" },
			json = { "prettierd", "fixjson" },
			jsonc = { "prettierd", "fixjson" },
			css = { "prettierd" },
			html = { "prettierd" },
			markdown = { "prettierd" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			solidity = { "prettierd" },
			svelte = { "prettierd" },
			vue = { "prettierd" },
			yaml = { "prettierd" },
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
