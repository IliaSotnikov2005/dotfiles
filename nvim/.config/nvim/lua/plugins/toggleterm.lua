-- ================================================================================================
-- TITLE : toggleterm.nvim
-- ABOUT : Flexible floating/pane terminal manager.
-- LINKS :
--   > github: https://github.com/akinsho/toggleterm.nvim
-- ================================================================================================

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		start_in_insert = true,
		insert_mappings = true,
		direction = "float",
		float_opts = {
			border = "rounded",
			width = function() return math.floor(vim.o.columns * 0.9) end,
			height = function() return math.floor(vim.o.lines * 0.85) end,
		},
		close_on_exit = true,
		auto_scroll = true,
		hide_numbers = true,
		shade_terminals = true,
		persist_size = true,
		persist_mode = true,
	},
	keys = {
		{ "<C-`>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal (float)", mode = { "n", "i" } },
		{ "<Esc><Esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float terminal" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<CR>", desc = "Horizontal terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", desc = "Vertical terminal" },
		{ "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", desc = "Tab terminal" },
		{
			"<leader>tg",
			function()
				local Term = require("toggleterm.terminal").Terminal
				local lazygit = Term:new({ cmd = "lazygit", direction = "float", close_on_exit = true })
				lazygit:toggle()
			end,
			desc = "LazyGit (float)",
		},
	},
}
