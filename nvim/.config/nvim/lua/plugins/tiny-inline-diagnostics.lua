-- Плагин для красивого отображения ошибок в строке
return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach", -- Загружаем только когда LSP прикрепляется к файлу
	opts = {
		preset = "modern", -- Современный стиль с иконками
		options = {
			show_source = { enabled = true, if_many = true }, -- Показывать источник ошибки (eslint, pyright и т.д.)
			throttle = 20, -- Задержка для плавности при быстром движении курсора
		},
	},
}
