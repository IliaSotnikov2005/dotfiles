-- ================================================================================================
-- TITLE : live-preview.nvim
-- ABOUT : Live preview server for Markdown/HTML files.
-- LINKS :
--   > github: https://github.com/brianhuster/live-preview.nvim
-- ================================================================================================

return {
	"brianhuster/live-preview.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" }, -- удобный выбор файлов
	keys = {
		{ "<leader>lp", "<cmd>LivePreview start <cr>", desc = "Preview Markdown/HTML" },
	},
}
