-- ================================================================================================
-- TITLE : fish-lsp LSP Setup
-- LINKS :
--   > github: https://github.com/ndonfris/fish-lsp
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config('fish-lsp', {
		capabilities = capabilities,
		filetypes = { "fish" },
		cmd = { "fish-lsp", "start" },
		settings = {
			fish = {
				enable = true,
				completion = { enable = true },
				hover = { enable = true },
				references = { enable = true },
				signatureHelp = { enable = true },
			},
		},
	})
end
