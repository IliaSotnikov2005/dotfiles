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
		size = 12,
		open_mapping = [[<C-\>]],
		start_in_insert = true,
		insert_mappings = true,
		direction = "horizontal",
		close_on_exit = true,
		auto_scroll = true,
		hide_numbers = true,
		shade_terminals = true,
		persist_size = true,
		persist_mode = true,
	},
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal", mode = { "n", "i" } },
		{ "<Esc><Esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },
	},
}
