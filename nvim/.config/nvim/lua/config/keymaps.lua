-- ================================================================================================
-- TITLE: NeoVim keymaps
-- ABOUT: sets some quality-of-life keymaps
-- ================================================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Quick config editing
vim.keymap.set("n", "<leader>rc", "<Cmd>e ~/.config/nvim/init.lua<CR>", { desc = "Edit config" })

vim.keymap.set("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

vim.keymap.set("n", "<leader>c", ":nohlsearch<CR>", { desc = "Clear search highlights" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Black hole register — d/c/x не затирают буфер обмена
vim.keymap.set("n", "d", '"_d', { desc = "Delete (black hole)" })
vim.keymap.set("n", "dd", '"_dd', { desc = "Delete line (black hole)" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete char (black hole)" })
vim.keymap.set("n", "c", '"_c', { desc = "Change (black hole)" })
vim.keymap.set("n", "cc", '"_cc', { desc = "Change line (black hole)" })
vim.keymap.set("x", "d", '"_d', { desc = "Delete selection (black hole)" })
vim.keymap.set("x", "p", '"_dP', { desc = "Paste without yanking" })
vim.keymap.set({ "n", "v" }, "<leader>x", '"_d', { desc = "Delete without yanking" })

vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Быстрое перемещение по буферам
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })

vim.keymap.set("n", "<leader>x", function()
	require("mini.bufremove").delete(0, false)
end, { desc = "Delete buffer (close)" })

-- Fast save
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

vim.keymap.set("n", "<leader>pa", function()
	local path = vim.fn.expand("%:p")
	vim.fn.setreg("+", path)
	print("file:", path)
end, { desc = "Copy full file path" })

vim.keymap.set("n", "<leader>e", function()
	if require("zen-mode.view").is_open() then
		require("zen-mode").close()
	end

	local api = require("nvim-tree.api")

	if api.tree.is_visible() then
		api.tree.close()
	else
		api.tree.open()
	end
end, { desc = "Toggle NvimTree (close Zen if active)" })

-- Insert mode mappings
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode with jj" })

-- Color picker binds
vim.keymap.set("n", "<leader>cp", "<cmd>Shades<cr>", { desc = "ColorPicker" })
vim.keymap.set("n", "<leader>cg", "<cmd>Huefy<cr>", { desc = "Generate palette" })
vim.keymap.set("i", "<C-c>p", "<cmd>Shades<cr>", { desc = "ColorPicker" })

-- LSP restart
vim.keymap.set("n", "<leader>lr", function()
	vim.cmd("LspStop")
	vim.defer_fn(function()
		vim.cmd("LspStart")
		vim.notify("LSP restarted", vim.log.levels.INFO, { title = "LSP" })
	end, 500)
end, { desc = "Restart LSP" })

-- Copy full file path to clipboard
vim.keymap.set("n", "<leader>fp", function()
	local path = vim.fn.expand("%:p")
	if path == "" then
		vim.notify("No file path", vim.log.levels.WARN)
		return
	end
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy full file path" })
