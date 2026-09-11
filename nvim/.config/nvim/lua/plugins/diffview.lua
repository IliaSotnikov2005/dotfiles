return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	keys = {
		{ "<leader>dv", "<cmd>DiffviewOpen<CR>", desc = "Open diffview" },
		{ "<leader>dV", "<cmd>DiffviewClose<CR>", desc = "Close diffview" },
		{ "<leader>df", "<cmd>DiffviewFileHistory %<CR>", desc = "File history" },
		{ "<leader>dF", "<cmd>DiffviewFileHistory<CR>", desc = "Repo history" },
		{
			"<leader>dB",
			function()
				vim.ui.input({ prompt = "Branch: " }, function(branch)
					if branch and branch ~= "" then
						vim.cmd("DiffviewOpen " .. branch)
					end
				end)
			end,
			desc = "Diffview vs branch (input)",
		},
		{
			"<leader>db",
			function()
				local fzf = require("fzf-lua")
				fzf.fzf_exec("git branch --format='%(refname:short)'", {
					prompt = "Branch> ",
					actions = {
						["default"] = function(selected)
							if selected and selected[1] then
								vim.cmd("DiffviewOpen " .. selected[1])
							end
						end,
					},
				})
			end,
			desc = "Diffview vs branch (pick)",
		},
	},
	opts = {
		view = {
			merge_tool = {
				layout = "diff3_mixed",
			},
		},
	},
}
