-- ================================================================================================
-- TITLE : vscode.nvim
-- LINKS :
--   > github : https://github.com/Mofiqul/vscode.nvim
-- ABOUT : a Neovim theme that mimics the default dark theme of Visual Studio Code.
-- ================================================================================================

return {
	{
		"Mofiqul/vscode.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("vscode").setup({
				transparent = false,
				theme = "dark",
				disable_nvim_tree_hl = false,
				italic_comments = true,
			})

			vim.cmd("colorscheme vscode")
		end,
	},
}
