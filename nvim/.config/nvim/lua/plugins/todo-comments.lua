return {
	"folke/todo-comments.nvim",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		signs = true,
		keywords = {
			FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "HACK" } },
			TODO = { icon = " ", color = "info", alt = { "TOCHECK" } },
			HACK = { icon = " ", color = "warning" },
			WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
			NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
		},
	},
	keys = {
		{ "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
		{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
		{ "<leader>xt", "<cmd>Trouble todo<CR>", desc = "Todo (Trouble)" },
	},
}
