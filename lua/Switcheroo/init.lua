local M = {}
M.dependencies = { "rktjmp/lush.nvim", "nvim-telescope/telescope.nvim" }
M.version = "0.2"

local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local filesystem = require("Switcheroo.filesystem")
M.show_preview = true

local function CheckTheme()
	if not filesystem.path then
		filesystem.CreateDir()
		return
	end
	local file = io.open(filesystem.file, "r")
	if not file then
		file = io.open(filesystem.file, "w")
		if not file then
			error("Error config")
		end
	end
	local colorscheme = file:read()
	if colorscheme then
		if pcall(vim.cmd.colorscheme, colorscheme) then
			vim.cmd("colorscheme " .. colorscheme)
		else
			vim.notify("Colorscheme " .. colorscheme .. " not found! Falling back to default.", vim.log.levels.WARN)
		end
	end
	file:close()
end

local has_lush = pcall(require, "lush")
if not has_lush then
	vim.notify("Some colorschemes requires lush.nvim. Please install it to use this plugin.", vim.log.levels.ERROR)
end

--Check and init telescope
local has_telescope = pcall(require, "telescope")
if not has_telescope then
	error("This Plugin requires telescope.nvim.")
end

local preview_code = {
	"local function example(input_list)",
	"    -- This function processes a list of numbers",
	"    local total_sum = 0",
	"",
	"    for i, value in ipairs(input_list) do",
	"        if value > 0 then",
	"            total_sum = total_sum + value",
	"        else",
	"            print('Skipping negative value:', value)",
	"        end",
	"    end",
	"",
	"    local product = 1",
	"    for i, value in ipairs(input_list) do",
	"        -- Multiplying only positive values",
	"        if value > 0 then",
	"            product = product * value",
	"        end",
	"    end",
	"",
	"    local result_table = {",
	"        sum = total_sum,",
	"        product = product,",
	"        average = #input_list > 0 and (total_sum / #input_list) or 0",
	"    }",
	"    return result_table",
	"end",
	"",
	"example(numbers)",
}

local function get_avaiable_colorschemes()
	return vim.fn.getcompletion("", "color")
end

local function attach_map(map, prompt_bufnr, initial_colorscheme)
	local function reset_colorscheme()
		vim.cmd("colorscheme " .. initial_colorscheme)
		actions.close(prompt_bufnr)
	end
	map("i", "<C-c>", function()
		reset_colorscheme()
	end)
	map("n", "<C-c>", function()
		reset_colorscheme()
	end)
	map("n", "<ESC>", function()
		reset_colorscheme()
	end)
end

M.select_theme = function(opts)
	local themes = get_avaiable_colorschemes()
	local initial_colorscheme = vim.g.colors_name

	pickers
		.new(opts, {
			prompt_title = "ColorSchemes",
			finder = finders.new_table({
				results = themes,
				entry_maker = function(entry)
					return {
						value = entry,
						display = entry,
						ordinal = entry,
						url = entry.url,
						description = entry.description,
					}
				end,
			}),
			sorter = sorters.get_fzy_sorter(opts),
			previewer = previewers.new_buffer_previewer({
				define_preview = function(self, entry)
					local bufnr = self.state.bufnr
					local preview_content = {
						"Current Theme: " .. entry.value,
						"_____________________",
						"",
					}
					for _, line in ipairs(preview_code) do
						table.insert(preview_content, line)
					end
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, preview_content)
					vim.api.nvim_buf_set_option(bufnr, "filetype", "lua")
					vim.cmd("colorscheme " .. entry.value)
				end,
			}) or nil,
			attach_mappings = function(prompt_bufnr, map)
				local function apply_colorscheme()
					local selection = action_state.get_selected_entry()
					if selection then
						local file = io.open(filesystem.file, "w")
						if file then
							file:write(selection.value)
							file:close()
						end
						vim.cmd("colorscheme " .. selection.value)
					end
				end
				actions.select_default:replace(function()
					apply_colorscheme()
					actions.close(prompt_bufnr)
				end)
				attach_map(map, prompt_bufnr, initial_colorscheme)
				return true
			end,
		})
		:find()
end
function M.setup(opts)
	opts = opts or {}
	local defaults_opts = {}
	for key, value in pairs(defaults_opts) do
		if opts[key] == nil then
			opts[key] = value
		end
	end
	M.show_preview = opts.show_preview
	CheckTheme()
	vim.api.nvim_create_user_command("Switcheroo", function()
		M.select_theme(opts)
	end, {})
end
return M
