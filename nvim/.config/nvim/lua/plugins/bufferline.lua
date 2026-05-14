-- ================================================================================================
-- TITLE : scope.nvim & bufferline.nvim
-- LINKS :
--   > github (scope) : https://github.com/tiagovla/scope.nvim
--   > github (bufferline) : https://github.com/akinsho/bufferline.nvim
-- ABOUT : scope.nvim - highlights currently visible buffer sections based on scope.
--         bufferline.nvim - a sleek, customizable tabline/buffer line with scope integration.
-- ================================================================================================

return {
	{
		"tiagovla/scope.nvim",
		config = true,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"tiagovla/scope.nvim",
		},
		event = "VeryLazy",
		opts = {
			options = {
				mode = "buffers",
				always_show_bufferline = false,

				separator_style = "thin",

				buffer_close_icons = true,
				show_buffer_icons = true,

				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "left",
						separator = true,
					},
				},
				groups = {
					items = {},
					options = { fill_hl = "TabLineFill" },
				},

				custom_filter = function(buf_number)
					local bufname = vim.api.nvim_buf_get_name(buf_number)
					local buftype = vim.bo[buf_number].buftype

					if buftype ~= "" then
						return false
					end
					if bufname == "" then
						return false
					end

					local exclude_ft = {
						"alpha",
						"dashboard",
						"lazy",
						"mason",
						"help",
						"qf",
					}
					if vim.tbl_contains(exclude_ft, vim.bo[buf_number].filetype) then
						return false
					end

					return vim.fn.filereadable(bufname) == 1
				end,
			},
		},
	},
}
