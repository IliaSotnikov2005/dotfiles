-- Файл: ~/.config/nvim/lua/plugins/webdev-icons.lua
return {
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		dependencies = {
			"DaikyXendo/nvim-material-icon", -- Убедитесь, что эта строка есть!
		},
	},
}
