-- ================================================================================================
-- TITLE : nvim-tree.lua
-- ABOUT : A file explorer tree for Neovim, written in Lua.
-- LINKS :
--   > github : https://github.com/nvim-tree/nvim-tree.lua
-- ================================================================================================

return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	config = function()
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				vim.api.nvim_set_hl(0, "NvimTreeDiagnosticError", { fg = "#E06C75" })
				vim.api.nvim_set_hl(0, "NvimTreeDiagnosticWarn", { fg = "#E5C07B" })
				vim.api.nvim_set_hl(0, "NvimTreeDiagnosticHint", {})
			end,
		})

		require("nvim-tree").setup({
			sync_root_with_cwd = true,
			actions = {
				change_dir = {
					enable = true,
					global = true, -- использовать :cd (глобально), не :lcd (локально)
				},
			},
			diagnostics = {
				enable = true,
				show_on_dirs = true,
				icons = {
					error = " ",
					warning = " ",
					hint = " ",
					info = " ",
				},
			},
			filters = {
				dotfiles = false,   -- show hidden files (dotfiles)
				git_ignored = false, -- show gitignored files (like .env)
			},
			renderer = {
				highlight_diagnostics = true,
				icons = {
					glyphs = {
						git = {
							unstaged = "M",
							staged = "+",
							untracked = "?",
							renamed = "R",
							deleted = "D",
							ignored = "◌",
							unmerged = "!",
						},
					},
				},
			},
			view = {
				adaptive_size = true,
			},
		})
	end,
}
