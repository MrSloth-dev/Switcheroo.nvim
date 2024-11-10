local M = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local config = require("telescope.config")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

vim.keymap.set("n", "<leader>r", ":so<CR>")

M.select_theme = function(opts)
	local themes = vim.fn.getcompletion("", "color")
	pickers
		.new(opts, {
			prompt_title = "ColorSchemes",
			finder = finders.new_table({
				results = themes,
			}),
			sorter = config.generic_sorter,
			previewers = previewers.new_buffer_previewer({
				define_preview = function(self, entry)
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, {
						"local function example()",
						"    -- This is a sample code for preview",
						"    local count = 0",
						"    for i = 1, 10 do",
						"        count = count + i",
						'        print("Count:", count)',
						"    end",
						"    return count",
						"end",
						"",
						"class Example:",
						"    def __init__(self):",
						"        self.value = 42",
						"",
						"    def calculate(self):",
						"        return self.value * 2",
					})
					vim.cmd("colorscheme " .. entry.value)
				end,
			}),
			attach_mappings = function(prompt_bufnr, map)
				actions.select_default:replace(function()
					local selection = action_state.get_selected_entry()
					vim.cmd("colorscheme " .. selection.value)
					actions.close(prompt_bufnr)
				end)
				return true
			end,
		})
		:find()
	local current_colorscheme = vim.g.colors_name
	vim.cmd("colorscheme " .. current_colorscheme)
end

M.select_theme()
return M
