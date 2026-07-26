return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			lua = { "luacheck" },
			python = { "flake8" },
			go = { "golangci-lint" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			json = { "eslint_d" },
			solidity = { "solhint" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			c = { "cpplint" },
			cpp = { "cpplint" },
			docker = { "hadolint" },
			markdown = { "markdownlint" },
		}

		local function get_available_linters()
			local ft = vim.bo.filetype
			local linters = lint.linters_by_ft[ft]
			if not linters then
				return {}
			end
			local available = {}
			for _, linter_name in ipairs(linters) do
				local linter = lint.linters[linter_name]
				if linter and linter.cmd and vim.fn.executable(linter.cmd) == 1 then
					table.insert(available, linter_name)
				end
			end
			return available
		end

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			callback = function()
				local available = get_available_linters()
				if #available > 0 then
					lint.try_lint(available)
				end
			end,
		})
	end,
}
