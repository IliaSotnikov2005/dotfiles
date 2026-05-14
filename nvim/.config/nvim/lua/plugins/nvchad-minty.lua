-- ================================================================================================
-- TITLE : minty.nvim
-- LINKS :
--   > github : https://github.com/nvzone/minty
-- ABOUT : a color picker and palette generator for Neovim.
-- ================================================================================================

return {
	"nvzone/minty",
	cmd = { "Shades", "Huefy" },
	{
		"nvzone/volt",
		lazy = true,
	},
	config = function()
		require("minty").setup({
			shades = {
				border = "rounded",
				auto_insert = true,
				format = "hex",
			},
			huefy = {
				border = "rounded",
				count = 10,
				auto_insert = true,
			},
		})
	end,
}
