local M = {}
M.version = "0.1"

M.dependencies = { "rktjmp/lush.nvim" }
local has_lush = pcall(require, "lush")
if not has_lush then
	error("Some colorschemes requires lush.nvim. Please install it to use this plugin.")
end

local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
M.show_preview = true

vim.keymap.set("n", "<leader>r", ":so<CR>") -- for fast dev

local function install_all_themes()
	local lazy_ok, lazy = pcall(require, "lazy")
	if not lazy_ok then
		vim.notify(
			"Lazy.nvim not installed. Please install lazy.nvim or install the themes manually",
			vim.log.levels.WARN
		)
		return {}
	end
	local theme_specs = require("theme_list")
	for _, theme_spec in ipairs(theme_specs) do
		print(theme_spec.spec)
		if theme_spec.spec then
			lazy.load({ spec = "https://github.com/calind/selenized.nvim" })
		end
	end
	-- lazy.install()
end

local function uninstall_unused_themes()
	local lazy_ok, lazy = pcall(require, "lazy")
	if not lazy_ok then
		vim.notify(
			"Lazy.nvim not installed. Please install lazy.nvim or install the themes manually",
			vim.log.levels.WARN
		)
		return {}
	end
	local installed_themes = vim.fn.getcompletion("", "color")
	local theme_specs = {}
	for _, theme_spec in ipairs(theme_specs) do
		local theme_name = theme_spec:match("([^/]+)$"):gsub("%.git$", "")
		if not vim.tbl_contains(installed_themes, theme_name) then
			lazy.unload({ spec = theme_spec })
		end
	end
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
		uninstall_unused_themes()
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
	install_all_themes()
	local themes = get_avaiable_colorschemes()
	-- local themes = load_themes()
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
			previewer = M.show_preview
					and previewers.new_buffer_previewer({
						define_preview = function(self, entry)
							local bufnr = self.state.bufnr
							print(entry.value)
							local preview_content = {
								"Theme:" .. entry.value,
								"",
								"_____________________",
								"",
							}
							for _, line in ipairs(preview_code) do
								table.insert(preview_content, line)
							end
							vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, preview_code)
							vim.api.nvim_buf_set_option(bufnr, "filetype", "lua")
							vim.cmd("colorscheme " .. entry.value)
							-- end
						end,
					})
				or nil,
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
				attach_map(map, prompt_bufnr, initial_colorscheme)
				return true
			end,
		})
		:find()
end

M.select_theme()
function M.setup(opts)
	opts = opts or {}
	local defaults_opts = {
		show_preview = true,
	}
	for key, value in pairs(default_opts) do
		if opts[key] == nil then
			opts[key] = value
		end
	end
	M.show_preview = opts.show_preview
	vim.api.nvim_create_user_command("Switcheroo", function()
		M.select_theme(opts)
	end, {})
end
return M
