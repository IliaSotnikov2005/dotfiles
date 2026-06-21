-- ================================================================================================
-- TITLE : Diagnostics Configuration
-- ABOUT : Configures diagnostic signs with custom icons for Error, Warn, Hint, and Info.
-- LINKS :
--   > neovim docs: https://neovim.io/doc/user/diagnostic.html
-- ================================================================================================

local M = {}

local diagnostic_signs = {
	Error = " ",
	Warn = " ",
	Hint = "",
	Info = "",
}

--- @return nil
M.setup = function()
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
				[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
				[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
				[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
			},
		},
	})
end

return M

