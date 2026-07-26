return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	opts = {
		timeout = 3000,
		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
		render = "compact",
		stages = "fade",
	},
	keys = {
		{ "<leader>nc", function() require("notify").dismiss({ silent = true }) end, desc = "Dismiss notifications" },
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify
	end,
}
