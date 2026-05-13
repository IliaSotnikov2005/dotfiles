-- ================================================================================================
-- TITLE : nvim-colorizer.lua
-- LINKS :
--   > github : https://github.com/NvChad/nvim-colorizer.lua
-- ABOUT : a high-performance color highlighter for Neovim.
-- ================================================================================================

return {
	"NvChad/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			options = {
				names = false,
				RGB = true,
				RRGGBB = true,
				AARRGGBB = true,
				rgb_fn = true,
				hsl_fn = true,
				css = true,
				css_fn = true,
				mode = "virtualtext",
				tailwind = true,
				sass = { enable = true, parsers = { "css" } },
			},
		})
	end,
}
