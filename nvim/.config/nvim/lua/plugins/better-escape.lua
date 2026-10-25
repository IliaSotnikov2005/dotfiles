return {
	"max397574/better-escape.nvim",
	event = "InsertEnter",
	opts = {
		mapping = { "jk", "jj", "kj" },
		timeout = vim.o.timeoutlen,
		clear_empty_lines = false,
		keys = "<Esc>",
	},
}
