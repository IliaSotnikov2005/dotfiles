return {
	"ray-x/lsp_signature.nvim",
	event = "VeryLazy",
	opts = {
		bind = true,
		handler_opts = {
			border = "rounded",
		},
		hint_enable = true, -- показывать подсказку в строке
		hint_prefix = "󰛸 ",
	},
	config = function(_, opts)
		require("lsp_signature").setup(opts)
	end,
}
