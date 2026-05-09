return {
	"nvzone/minty",
	cmd = { "Shades", "Huefy" },
	keys = {
		{ "<leader>cg", "<cmd>Huefy<cr>", desc = "Minty: Generate palette (Huefy)" },
		{ "<C-c>p", "<cmd>Shades<cr>", mode = "i", desc = "Minty: Color picker (insert)" },
	},
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

--test #6552d8
