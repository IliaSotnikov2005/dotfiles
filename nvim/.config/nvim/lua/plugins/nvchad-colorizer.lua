-- #ffffff
return {
	"NvChad/nvim-colorizer.lua",
	config = function()
		require("colorizer").setup({
			options = {
				names = false, -- Не подсвечивать слова типа "Blue"
				RGB = true,
				RRGGBB = true,
				AARRGGBB = true,
				rgb_fn = true, -- Поддержка rgb() и rgba()
				hsl_fn = true, -- Поддержка hsl()
				css = true,
				css_fn = true,
				mode = "virtualtext", -- "foreground", "background" или "virtualtext"
				-- Важно для тебя: поддержка OKLCH
				tailwind = true,
				sass = { enable = true, parsers = { "css" } },
			},
		})
	end,
}
