-- ================================================================================================
-- TITLE : LSP Server Initializer
-- ABOUT : Loads all language server configurations and enables them via vim.lsp.enable.
-- LINKS :
--   > neovim docs: https://neovim.io/doc/user/lsp.html
-- ================================================================================================

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Language Server Protocol (LSP)
require("servers.lua_ls")(capabilities)
require("servers.pyright")(capabilities)
require("servers.gopls")(capabilities)
require("servers.jsonls")(capabilities)
require("servers.ts_ls")(capabilities)
require("servers.fishls")(capabilities)
require("servers.clangd")(capabilities)
require("servers.dockerls")(capabilities)
require("servers.emmet_ls")(capabilities)
require("servers.html_lsp")(capabilities)
require("servers.yamlls")(capabilities)
require("servers.tailwindcss")(capabilities)
require("servers.solidity_ls_nomicfoundation")(capabilities)

-- Linters & Formatters
require("servers.efm-langserver")(capabilities)

vim.lsp.enable({
	"lua_ls",
	"pyright",
	"gopls",
	"jsonls",
	"ts_ls",
	"vue_ls",
	"fishls",
	"clangd",
	"dockerls",
	"emmet_ls",
	"html_lsp",
	"yamlls",
	"tailwindcss",
	"solidity_ls_nomicfoundation",
	"efm",
})
