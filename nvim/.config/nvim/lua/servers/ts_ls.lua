-- ================================================================================================
-- TITLE : ts_ls (TypeScript Language Server) LSP Setup
-- LINKS :
--   > github: https://github.com/typescript-language-server/typescript-language-server
-- ================================================================================================

--- @param capabilities table LSP client capabilities (typically from nvim-cmp or similar)
--- @return nil
return function(capabilities)
	local vue_path = vim.fn.stdpath("data") .. "/mason/packages/vue-language-server/node_modules/@vue/typescript-plugin"

	vim.lsp.config("ts_ls", {
		capabilities = capabilities,
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"vue",
		},
		init_options = {
			plugins = {
				{
					name = "@vue/typescript-plugin",
					location = vue_path,
					languages = { "vue" },
				},
			},
		},
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	})
end
