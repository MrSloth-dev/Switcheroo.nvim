local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function theme_picker()
	local themes = vim.fn.getcompletion("", "color")
	pickers
		.new({}, {
			prompt_title = "Select Theme",
			finder = finders.new_table(themes),
			sorter = require("telescope.config").values.generic_sorter({}),
			attach_mappings = function(_, map)
				map("i", "<CR>", function(bufnr)
					local selection = action_state.get_selected_entry()
					vim.cmd("colorscheme " .. selection[1])
					-- Code for preview window here
				end)
				map("i", "<Esc>", function()
					actions.close(bufnr)
				end)
				return true
			end,
		})
		:find()
end

return {
	theme_picker = theme_picker,
}
