return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	keys = {
		{ "<leader>dv", "<cmd>DiffviewOpen<CR>", desc = "Open diffview" },
		{ "<leader>dV", "<cmd>DiffviewClose<CR>", desc = "Close diffview" },
		{ "<leader>df", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
		{ "<leader>dF", "<cmd>DiffviewFileHistory<CR>", desc = "Repo history" },
	},
	opts = {
		view = {
			merge_tool = {
				layout = "diff3_mixed",
			},
		},
	},
}
