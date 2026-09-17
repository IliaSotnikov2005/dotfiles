-- ================================================================================================
-- TITLE : SWI-Prolog Language Server Setup
-- ABOUT : LSP + code formatting via jamesnvc/lsp_server (SWI-Prolog pack).
-- LINKS :
--   > github: https://github.com/jamesnvc/lsp_server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	vim.lsp.config('prolog', {
		capabilities = capabilities,
		cmd = {
			"swipl",
			"-g", "use_module(library(lsp_server)).",
			"-g", "lsp_server:main",
			"-t", "halt",
			"--", "stdio",
		},
		filetypes = { "prolog" },
		single_file_support = true,
	})
end