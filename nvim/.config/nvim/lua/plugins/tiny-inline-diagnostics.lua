-- ================================================================================================
-- TITLE : tiny-inline-diagnostic.nvim
-- ABOUT : Beautiful inline diagnostics display (replaces float windows).
-- LINKS :
--   > github: https://github.com/rachartier/tiny-inline-diagnostic.nvim
-- ================================================================================================

return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	opts = {
		preset = "modern",
		options = {
			show_source = { enabled = true, if_many = true },
			throttle = 20,
		},
	},
}
