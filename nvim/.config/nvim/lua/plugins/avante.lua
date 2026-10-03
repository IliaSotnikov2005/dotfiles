-- ================================================================================================
-- TITLE : avante.nvim
-- LINKS :
--   > github : https://github.com/yetone/avante.nvim
-- ABOUT : сайдбар-чат с агентом. Провайдер — локальный opencode через ACP, поэтому ключи не
--         нужны и агент видит все MCP-серверы из opencode.jsonc. Avante сам подставляет
--         текущий файл и визуальное выделение, @file открывает fzf-lua пикер (без ручных путей).
--         Заголовок окна ввода отключён (render_input заглушен), заголовок чата с моделью оставлен.
--         Блок "- Datetime / - Model / - Selected files" рисуется только у первого сообщения
--         сессии (_get_message_lines обёрнут), дальше голое "> запрос".
--         На VimLeavePre acp-процесс убивается, acp_session_id сбрасывается — при следующем
--         запуске nvim агент стартует с новой сессии (история чата в панели сохраняется,
--         чистая панель — /new или <leader>ah).
--         После Enter фокус остаётся в окне ввода: update_content с focus=true перехвачен.
--         Левая граница панели и разделители рисуются через fillchars (vert:│, wbr:─) и hl-группы.
--         windows.ask.start_insert = false — фокус на поле ввода (мышь, <C-w>w, <leader>af) не
--         включает insert mode; в insert попадаешь сам через i.
-- KEYS (дефолты avante, кроме submit.insert):
--   > <leader>at : toggle sidebar
--   > <leader>af : toggle focus (chat <-> редактор)
--   > <leader>aa : ask (выбор файла/выделения -> чат)
--   > <leader>ac : add current buffer to chat
--   > <leader>ah : chat history
--   > <leader>aM : select acp model
--   > <leader>am : select acp mode
--   > <leader>aR : repomap, <leader>as : suggestion, <leader>aS : stop
--   > в окне ввода: <CR> отправить, <S-Enter> перенос строки, <C-c> остановить агента
--   > в сайдбаре: @ добавить файл, <Tab> переключить окно кода, q закрыть
-- ================================================================================================

local opencode = vim.fn.exepath("opencode")
if opencode == "" then
	opencode = vim.fn.expand("~/.opencode/bin/opencode")
end

local BORDER = "#3c3c3c"

return {
	"yetone/avante.nvim",
	build = "make",
	event = "VeryLazy",
	version = false,
	config = function(_, opts)
		require("avante").setup(opts)
		local group = vim.api.nvim_create_augroup("AvanteUi", { clear = true })
		local border = function()
			vim.api.nvim_set_hl(0, "AvanteSidebarWinSeparator", { fg = BORDER })
			vim.api.nvim_set_hl(0, "AvanteSidebarWinHorizontalSeparator", { fg = BORDER })
		end
		border()
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = group,
			callback = function()
				vim.schedule(border)
			end,
		})

		-- заголовок окна ввода ("Ask (Tab: switch focus)") не нужен
		require("avante.sidebar").render_input = function() end

		-- блок "- Datetime / - Model / - Selected files" только у первого сообщения сессии
		local sidebar = require("avante.sidebar")
		local message_lines = sidebar._get_message_lines
		sidebar._get_message_lines = function(self, ctx, message, messages, ignore_record_prefix)
			if message.is_user_submission then
				ignore_record_prefix = true
				for _, item in ipairs(messages or {}) do
					if item.is_user_submission then
						ignore_record_prefix = item.uuid ~= message.uuid
						break
					end
				end
			end
			return message_lines(self, ctx, message, messages, ignore_record_prefix)
		end

		-- после отправки (Enter) курсор остаётся в окне ввода, а не прыгает в ответ
		local update_content = sidebar.update_content
		sidebar.update_content = function(self, content, opts)
			if opts and opts.focus then opts = vim.tbl_extend("force", opts, { focus = false }) end
			return update_content(self, content, opts)
		end

		-- <S-Enter> = перенос строки в окне ввода агента (локальный маппинг буфера)
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = { "AvanteInput", "AvantePromptInput" },
			callback = function(args)
				vim.keymap.set("i", "<S-Enter>", "<CR>", { buffer = args.buf, noremap = true, silent = true })
				vim.keymap.set({ "n", "i" }, "<C-c>", function()
					require("avante.api").stop()
				end, { buffer = args.buf, silent = true })
			end,
		})

		-- при выходе из nvim убиваем acp-агента и забываем session_id: следующий запуск
		-- открывает панель с новой сессией, а не продолжает старую (session/load)
		vim.api.nvim_create_autocmd("VimLeavePre", {
			group = group,
			callback = function()
				local ok, avante = pcall(require, "avante")
				local current = ok and pcall(avante.get) and avante.get() or nil
				if not current then return end
				pcall(function() current:stop_acp_client() end)
				local bufnr = current.code and current.code.bufnr
				local history = current.chat_history
				if not history or not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end
				history.acp_session_id = nil
				pcall(function() require("avante.path").history.save(bufnr, history) end)
			end,
		})
	end,
	opts = {
		provider = "opencode",
		acp_providers = {
			opencode = {
				command = opencode,
				args = { "acp" },
			},
		},
		behaviour = {
			auto_suggestions = false,
			auto_add_current_file = true,
			support_paste_from_clipboard = true,
		},
		mappings = {
			submit = {
				insert = "<CR>",
			},
		},
		selector = {
			provider = "fzf_lua",
		},
		selection = {
			enabled = true,
			hint_display = "delayed",
		},
		history = {
			max_tokens = 4096,
		},
		windows = {
			position = "right",
			wrap = true,
			width = 40,
			fillchars = "eob: ,vert:│,wbr:─",
			ask = {
				start_insert = false,
			},
			sidebar_header = {
				enabled = true,
				align = "center",
				rounded = true,
				include_model = true,
			},
			spinner = {
				generating = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
				thinking = { "◐", "◓", "◑", "◒" },
			},
			input = {
				height = 8,
			},
			selected_files = {
				height = 6,
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		{ "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } },
		"nvim-tree/nvim-web-devicons",
		"hrsh7th/nvim-cmp",
		"ibhagwan/fzf-lua",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
				},
			},
		},
	},
}
