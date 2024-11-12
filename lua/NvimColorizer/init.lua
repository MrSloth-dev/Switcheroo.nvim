local M = {}
M.version = "0.1"

local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local show_preview = true

vim.keymap.set("n", "<leader>r", ":so<CR>") -- for fast dev

local preview_code = {
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
}

local function load_themes()
	local ok, themes = pcall(require, "./theme_list")
	if not ok then
		vim.notify("Could not load Theme List", vim.log.levels.ERROR)
		return {}
	else
		return themes
	end
end

-- local function load_plugins_from_file(filename)
-- 	local plugins = {}
-- 	local content = vim.fn.readfile(filename)
-- 	if not content then
-- 		print("")
-- 	end
-- 	for _, line in ipairs(content) do
-- 		if line ~= "" then
-- 			table.insert(plugins, line)
-- 		end
-- 	end
-- 	return plugins
-- end
--
-- local plugin_list = load_plugins_from_file("./theme_list.lua")
M.select_theme = function(opts)
	opts = opts or {}
	-- local themes = vim.fn.getcompletion("", "color")
	local themes = load_themes()
	local theme_names = vim.tbl_map(function(theme)
		return theme.name
	end, themes)
	-- local themes = vim.tbl_map(function(plugin)
	-- 	return plugin:match("([^/]+)$")
	-- end, plugin_list)
	local initial_colorscheme = vim.g.colors_name
	pickers
		.new(opts, {
			prompt_title = "ColorSchemes",
			finder = finders.new_table({
				entry_maker = function(entry)
					return { value = entry, display = entry, ordinal = entry }
				end,
				results = themes,
			}),
			sorter = sorters.get_fzy_sorter(opts),
			previewer = show_preview and previewers.new_buffer_previewer({
				define_preview = function(self, entry)
					local bufnr = self.state.bufnr
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, preview_code)
					vim.api.nvim_buf_set_option(bufnr, "filetype", "lua")
					vim.cmd("colorscheme " .. entry.value)
				end,
			}) or nil,
			attach_mappings = function(prompt_bufnr, map)
				local function apply_colorscheme()
					local selection = action_state.get_selected_entry()
					if selection then
						vim.cmd("colorscheme " .. selection.value)
					end
				end
				actions.select_default:replace(function()
					apply_colorscheme()
					actions.close(prompt_bufnr)
				end)
				map("i", "<C-c>", function()
					vim.cmd("colorscheme " .. initial_colorscheme)
					actions.close(prompt_bufnr)
				end)
				map("n", "<C-c>", function()
					vim.cmd("colorscheme " .. initial_colorscheme)
					actions.close(prompt_bufnr)
				end)
				map("n", "<ESC>", function()
					vim.cmd("colorscheme " .. initial_colorscheme)
					actions.close(prompt_bufnr)
				end)
				return true
			end,
		})
		:find()
end

M.select_theme()
return M
