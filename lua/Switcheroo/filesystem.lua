local persistence_path = vim.fn.stdpath("data") .. "/Switcheroo"
local persistence_file = persistence_path .. "/SelectedTheme"

local function CreateDir()
	local success = os.execute('mkdir -p "' .. persistence_path .. '"')
	if not success then
		error("Problem with creating directory" .. persistence_path)
	end
end

return {
	CreateDir = CreateDir(),
	path = persistence_path,
	file = persistence_file,
}
