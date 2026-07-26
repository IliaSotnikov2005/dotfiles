return {
	"MagicDuck/grug-far.nvim",
	opts = {},
	keys = {
		{ "<leader>ss", "<cmd>GrugFar<CR>", desc = "Search & Replace (workspace)" },
		{
			"<leader>sw",
			function()
				local grug = require("grug-far")
				local prefills = grug.get_prefills()
				prefills.search = vim.fn.expand("<cword>")
				grug.open({ prefills = prefills })
			end,
			mode = "n",
			desc = "Search & Replace word under cursor",
		},
		{
			"<leader>sw",
			function()
				local grug = require("grug-far")
				vim.cmd('normal! "zy')
				local prefills = grug.get_prefills()
				prefills.search = vim.fn.getreg("z")
				grug.open({ prefills = prefills })
			end,
			mode = "v",
			desc = "Search & Replace selection",
		},
		{
			"<leader>sf",
			function()
				local grug = require("grug-far")
				local prefills = grug.get_prefills()
				prefills.paths = vim.fn.expand("%")
				grug.open({ prefills = prefills })
			end,
			mode = "n",
			desc = "Search & Replace in current file",
		},
	},
}
