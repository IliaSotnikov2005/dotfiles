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
--         Блок "Thoughts:" (мысли агента) подсвечивается серым фоном на всю ширину строки
--         через extmark в namespace avante_thinking; маркер ">" заменён на "»" (не ломает
--         markdown) и красится бледно-синим ярче текста мыслей; реплики пользователя "> …"
--         остаются как есть.
--         Хинт у поля ввода свой: только "Tokens: N" (без "<CR>: submit"), слово Tokens зелёное.
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
local THINKING_BG = "#2b2d33"
local THINKING_FG = "#8fb6d9"
local THINKING_MARKER_FG = "#a9cdf0"
local THINKING_MARKER = "» "
local TOKENS_FG = "#7fd18c"

return {
	"yetone/avante.nvim",
	build = "make",
	event = "VeryLazy",
	version = false,
	config = function(_, opts)
		require("avante").setup(opts)
		local group = vim.api.nvim_create_augroup("AvanteUi", { clear = true })
		local apply_highlights = function()
			vim.api.nvim_set_hl(0, "AvanteSidebarWinSeparator", { fg = BORDER })
			vim.api.nvim_set_hl(0, "AvanteSidebarWinHorizontalSeparator", { fg = BORDER })
			vim.api.nvim_set_hl(0, "AvanteThinkingBlock", { fg = THINKING_FG, bg = THINKING_BG })
			vim.api.nvim_set_hl(0, "AvanteThinkingMarker", { fg = THINKING_MARKER_FG, bg = THINKING_BG })
			vim.api.nvim_set_hl(0, "AvanteTokensHint", { fg = TOKENS_FG })
		end
		apply_highlights()
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = group,
			callback = function()
				vim.schedule(apply_highlights)
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
			local lines = message_lines(self, ctx, message, messages, ignore_record_prefix)
			-- маркер мыслей ">" -> "» ": не пересекается с синтаксисом markdown
			local in_thinking = false
			for _, line in ipairs(lines) do
				local trimmed = vim.trim(tostring(line))
				if trimmed == "Thoughts:" then
					in_thinking = true
				elseif in_thinking and trimmed ~= "" and not trimmed:match("^>") then
					in_thinking = false
				end
				if in_thinking and trimmed:match("^>") then
					for _, section in ipairs(line.sections) do
						if type(section) == "table" then section[1] = (section[1]:gsub("^%s*>%s?", THINKING_MARKER, 1)) end
					end
				end
			end
			return lines
		end

		-- avante добавляет две пустые строки перед каждой репликой агента
		-- (sidebar.lua:2166); отдаём ему первую пустую строку сами — тогда его проверка
		-- tostring(lines[1]) ~= "" не добавит вторую
		local Line = require("avante.ui.line")
		local get_message_lines = sidebar.get_message_lines
		sidebar.get_message_lines = function(self, ctx, message, messages, ignore_record_prefix)
			local lines = get_message_lines(self, ctx, message, messages, ignore_record_prefix)
			if #lines == 0 or message.message.role ~= "assistant" then return lines end
			if tostring(lines[1]) == "" then return lines end
			local res = { Line:new({ { "" } }) }
			vim.list_extend(res, lines)
			return res
		end

		-- после отправки (Enter) курсор остаётся в окне ввода, а не прыгает в ответ
		local think_ns = vim.api.nvim_create_namespace("avante_thinking")
		local function highlight_thinking(bufnr)
			if not bufnr or not vim.api.nvim_buf_is_valid(bufnr) then return end
			vim.api.nvim_buf_clear_namespace(bufnr, think_ns, 0, -1)
			local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
			local in_thinking = false
			for i, text in ipairs(lines) do
				local trimmed = vim.trim(text)
				local marked = false
				if trimmed == "Thoughts:" then
					in_thinking, marked = true, true
				elseif in_thinking then
					if trimmed == "" then
						-- пустая строка закрывает блок, если дальше мыслей нет
						local next_idx = i + 1
						while next_idx <= #lines and vim.trim(lines[next_idx]) == "" do next_idx = next_idx + 1 end
						local next_text = next_idx <= #lines and vim.trim(lines[next_idx]) or ""
						if vim.startswith(next_text, "»") then
							marked = true
						else
							in_thinking = false
						end
					elseif vim.startswith(trimmed, "»") then
						marked = true
					else
						in_thinking = false
					end
				end
				if marked then
					vim.api.nvim_buf_set_extmark(bufnr, think_ns, i - 1, 0, {
						line_hl_group = "AvanteThinkingBlock",
						priority = 200,
					})
					if vim.startswith(trimmed, "»") then
						vim.api.nvim_buf_set_extmark(bufnr, think_ns, i - 1, 0, {
							end_row = i - 1,
							end_col = #THINKING_MARKER,
							hl_group = "AvanteThinkingMarker",
							priority = 201,
						})
					end
				end
			end
		end

		local update_content = sidebar.update_content
		sidebar.update_content = function(self, content, opts)
			if opts and opts.focus then opts = vim.tbl_extend("force", opts, { focus = false }) end
			local result = update_content(self, content, opts)
			highlight_thinking(self.containers and self.containers.result and self.containers.result.bufnr)
			return result
		end

		-- хинт у поля ввода: только "Tokens: N" без "<CR>: submit", слово Tokens зелёное
		local hint_ns = vim.api.nvim_create_namespace("avante_input_hint")
		local function show_tokens_hint(self)
			self:close_input_hint()
			if not self.containers.input or not vim.api.nvim_win_is_valid(self.containers.input.winid) then return end
			local input_value = table.concat(vim.api.nvim_buf_get_lines(self.containers.input.bufnr, 0, -1, false), "\n")
			if self.token_count == nil then self:initialize_token_count() end
			local tokens = self.token_count + require("avante.utils").tokens.calculate_tokens(input_value)
			local hint_text = "Tokens: " .. tostring(tokens)
			local buf = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, { hint_text })
			vim.api.nvim_buf_set_extmark(buf, hint_ns, 0, 0, { hl_group = "AvantePopupHint", end_col = #hint_text })
			vim.api.nvim_buf_set_extmark(buf, hint_ns, 0, 0, { hl_group = "AvanteTokensHint", end_col = #"Tokens", priority = 201 })
			local win_width = vim.api.nvim_win_get_width(self.containers.input.winid)
			local width = #hint_text
			self.input_hint_window = vim.api.nvim_open_win(buf, false, {
				relative = "win",
				win = self.containers.input.winid,
				width = width,
				height = 1,
				row = self:get_input_float_window_row(),
				col = math.max(win_width - width, 0),
				style = "minimal",
				border = "none",
				focusable = false,
				zindex = 100,
			})
		end
		sidebar.show_input_hint = show_tokens_hint

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
