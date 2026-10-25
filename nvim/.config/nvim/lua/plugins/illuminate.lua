return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		require("illuminate").configure({
			delay = 100,
			filetypes_denylist = {
				"dirbuf",
				"dirvish",
				"fugitive",
				"alpha",
				"nvim-tree",
				"lazy",
				"mason",
			},
		})
	end,
}
