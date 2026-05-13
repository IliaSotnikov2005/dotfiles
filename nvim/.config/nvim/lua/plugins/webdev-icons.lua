-- ================================================================================================
-- TITLE : nvim-web-devicons & nvim-material-icon
-- LINKS :
--   > github (devicons) : https://github.com/nvim-tree/nvim-web-devicons
--   > github (material-icon) : https://github.com/DaikyXendo/nvim-material-icon
-- ABOUT : nvim-web-devicons provides file-type icons for Neovim plugins.
--         nvim-material-icon extends it with Material Design icons.
-- ================================================================================================

return {
	{
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		dependencies = {
			"DaikyXendo/nvim-material-icon",
		},
	},
}
