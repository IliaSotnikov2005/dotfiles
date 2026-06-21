-- ================================================================================================
-- TITLE : html_lsp (HTML Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/hrsh7th/vscode-langservers-extracted
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("html_lsp", {
		cmd = { "vscode-html-language-server", "--stdio" },
		filetypes = { "html" },
		settings = {
			html = {
				suggest = { html5 = true },
				format = { tabSize = 2, wrapLineLength = 120 },
			},
		},
		capabilities = capabilities,
	})
end
