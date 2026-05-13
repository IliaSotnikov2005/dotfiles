-- ================================================================================================
-- TITLE : lsp_signature.nvim
-- LINKS :
--   > github : https://github.com/ray-x/lsp_signature.nvim
-- ABOUT : show function signature help as you type.
-- ================================================================================================

return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	opts = {
		bind = true,
		handler_opts = {
			border = "rounded",
		},
		hint_enable = true,
		hint_prefix = "󰛸 ",
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)
	end,
}
