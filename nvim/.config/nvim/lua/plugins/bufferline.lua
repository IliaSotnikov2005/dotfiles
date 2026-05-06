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
			},
		},
	},
}
