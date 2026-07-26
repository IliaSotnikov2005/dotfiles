return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		dashboard.section.header.val = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
			"                                                     ",
		}

		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find file", ":FzfLua files<CR>"),
			dashboard.button("r", "  Recent files", ":FzfLua oldfiles<CR>"),
			dashboard.button("g", "  Live grep", ":FzfLua live_grep<CR>"),
			dashboard.button("c", "  Config", ":e $MYVIMRC<CR>"),
			dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooter"

		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = { "LazyVimStarted" },
			callback = function()
				local stats = require("lazy").stats()
				dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins"
				pcall(vim.cmd.AlphaRedraw)
			end,
		})

		alpha.setup(dashboard.config)
	end,
}
