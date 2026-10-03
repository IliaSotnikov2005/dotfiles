-- ================================================================================================
-- TITLE : nvim-treesitter
-- ABOUT : Treesitter configurations and abstraction layer for Neovim.
-- LINKS :
--   > github : https://github.com/nvim-treesitter/nvim-treesitter
-- ================================================================================================

return {
	"nvim-treesitter/nvim-treesitter",
	commit = "90cd658",
	main = "nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
	init = function()
		local highlight = function(bufnr, lang)
			if not vim.treesitter.language.add(lang) then
				return vim.notify(
					string.format("Treesitter cannot load parser for language: %s", lang),
					vim.log.levels.INFO,
					{ title = "Treesitter" }
				)
			end
			vim.treesitter.start(bufnr)
		end

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local ft = vim.bo.filetype
				local bt = vim.bo.buftype
				local buf = args.buf

				-- scratch-буферы avante (Avante/AvanteInput) грузим ради подсветки code-блоков
				local markdown_scratch = bt ~= "" and vim.tbl_contains({ "markdown", "Avante" }, ft)
				if bt ~= "" and not markdown_scratch then
					return
				end

				local ok, treesitter = pcall(require, "nvim-treesitter")
				if not ok then
					return
				end

				if not markdown_scratch then
					if ft == "javascriptreact" or ft == "typescriptreact" then
						vim.opt_local.foldmethod = "indent"
					else
						vim.opt_local.foldmethod = "expr"
						vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					end

					vim.schedule(function()
						if vim.fn.mode() ~= "t" then
							vim.cmd("silent! normal! zx")
						end
					end)

					if not vim.tbl_contains({ "python", "html", "yaml", "markdown" }, ft) then
						vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
					end
				end

				if vim.fn.executable("tree-sitter") ~= 1 then
					vim.api.nvim_echo({
						{
							"tree-sitter CLI not found. Parsers cannot be installed.",
							"ErrorMsg",
						},
					}, true, {})
					return false
				end

				local lang = vim.treesitter.language.get_lang(ft)
				if not lang then
					return
				end

				if vim.list_contains(treesitter.get_installed(), lang) then
					highlight(buf, lang)
				elseif vim.list_contains(treesitter.get_available(), lang) then
					treesitter.install(lang):await(function()
						highlight(buf, lang)
					end)
				end
			end,
		})
	end,
	opts = {
		install = {
			"bibtex",
			"css",
			"comment",
			"latex",
			"markdown",
			"markdown_inline",
			"prolog",
			"regex",
			"vimdoc",
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["ao"] = "@loop.outer",
					["io"] = "@loop.inner",
					["a?"] = "@conditional.outer",
					["i?"] = "@conditional.inner",
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
					["]o"] = "@loop.outer",
					["]a"] = "@parameter.inner",
				},
				goto_next_end = {
					["]F"] = "@function.outer",
					["]C"] = "@class.outer",
					["]O"] = "@loop.outer",
					["]A"] = "@parameter.inner",
				},
				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[o"] = "@loop.outer",
					["[a"] = "@parameter.inner",
				},
				goto_previous_end = {
					["[F"] = "@function.outer",
					["[C"] = "@class.outer",
					["[O"] = "@loop.outer",
					["[A"] = "@parameter.inner",
				},
			},
		},
	},
	config = function(_, opts)
		local treesitter = require("nvim-treesitter")
		treesitter.setup(opts)
		if vim.fn.executable("tree-sitter") ~= 1 then
			vim.api.nvim_echo({
				{
					"tree-sitter CLI not found. Parsers cannot be installed.",
					"ErrorMsg",
				},
			}, true, {})
			return false
		end
		treesitter.install(opts.install)

		require("treesitter-context").setup({
			enable = true,
			max_lines = 3,
			trim_scope = "outer",
			patterns = {
				lua = { "function", "if_statement", "for_statement", "while_statement" },
				python = { "function_definition", "class_definition" },
				go = { "function_declaration", "method_declaration" },
				typescript = { "function", "arrow_function", "class", "interface" },
				javascript = { "function", "arrow_function", "class" },
				rust = { "function_item", "impl_item", "trait_item" },
			},
		})
	end,
}
