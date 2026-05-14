return {
	"akinsho/toggleterm.nvim",
	version = "*", -- используем последнюю стабильную версию
	opts = {
		-- Размер панели снизу (в строках)
		size = 12,
		-- Хоткей для открытия/закрытия (Ctrl + обратный слэш, как в VS Code)
		open_mapping = [[<C-\>]],
		-- Сразу переходить в режим ввода
		start_in_insert = true,
		-- Хоткей работает и в режиме вставки
		insert_mappings = true,
		-- Панель будет СНИЗУ (горизонтальный сплит)
		direction = "horizontal",
		-- Закрывать окно, когда процесс завершён
		close_on_exit = true,
		-- Автоматически скроллить вниз при выводе
		auto_scroll = true,
		-- Скрывать номера строк
		hide_numbers = true,
		-- Затемнять фон терминала (для контраста)
		shade_terminals = true,
		-- Запоминать размер панели
		persist_size = true,
		-- Запоминать режим (Normal/Insert) при закрытии/открытии
		persist_mode = true,
	},
	-- Дополнительные удобные хоткеи (опционально)
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal", mode = { "n", "i" } },
		-- Переключение в обычный режим из терминала (двойное нажатие Esc)
		{ "<Esc><Esc>", "<C-\\><C-n>", desc = "Exit terminal mode", mode = "t" },
	},
}
