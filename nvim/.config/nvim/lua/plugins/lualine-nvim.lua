return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"tabboud/lualine-lsp-progress",
	},
	config = function()
		require("lualine").setup({
			options = {
				theme = "vscode",
				icons_enabled = true,
				section_separators = { left = "", right = "" },
				component_separators = "",
				globalstatus = true,
			},
			sections = {
				lualine_a = {
					{ "mode", separator = { left = "", right = "" }, right_padding = 2 },
				},
				lualine_b = {
					{
						"branch",
						icon = "",
						color = { bg = "#3b3b3b", fg = "#ffffff" },
						separator = { right = "" },
					},
					{
						"diff",
						color = { bg = "#3b3b3b" },
						separator = { right = "" },
					},
				},
				lualine_c = {
					{ "filename" },
				},

				lualine_x = {
					{
						function()
							local clients = vim.lsp.get_clients({ bufnr = 0 })
							if next(clients) == nil then
								return "No LSP"
							end
							local client_names = {}
							for _, client in ipairs(clients) do
								if client.name ~= "efm" then
									table.insert(client_names, client.name)
								end
							end
							return table.concat(client_names, ",")
						end,
						icon = "",
						color = { fg = "#858585" },
					},
					{ "encoding", color = { fg = "#858585" } },
					{ "filetype", color = { fg = "#858585" } },
				},
				lualine_y = {
					{
						"progress",
						color = { bg = "#3b3b3b", fg = "#ffffff" },
						separator = { left = "" },
					},
				},
				lualine_z = {
					{ "location", separator = { left = "", right = "" }, left_padding = 2 },
				},
			},
		})
	end,
}
