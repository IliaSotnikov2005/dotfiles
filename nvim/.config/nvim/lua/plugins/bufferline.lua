return {
	{
		"tiagovla/scope.nvim",
		config = true,
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "tiagovla/scope.nvim" },
		event = "VeryLazy",
		opts = {
			options = {
				mode = "buffers",
				-- СКРЫВАТЬ, если открыт всего 1 буфер
				always_show_bufferline = false,

				-- Исправляет "налезание" друг на друга
				separator_style = "thin",

				-- Улучшает читаемость в tmux
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
				-- Автоматическая фильтрация через scope.nvim
				groups = { items = {}, options = { fill_hl = "TabLineFill" } },

				custom_filter = function(buf_number)
					local bufname = vim.api.nvim_buf_get_name(buf_number)
					local buftype = vim.bo[buf_number].buftype

					-- Только реальные файлы (не терминал, не help, не quickfix)
					if buftype ~= "" then
						return false
					end
					-- Исключаем буферы без имени (например, [No Name])
					if bufname == "" then
						return false
					end
					-- Убираем dashboard, lazy и т.д.
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
					-- Файл должен существовать на диске
					return vim.fn.filereadable(bufname) == 1
				end,
			},
		},
	},
}
