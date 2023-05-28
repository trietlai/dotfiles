local nnn = require("nnn")
local builtin = nnn.builtin
nnn.setup({
	-- picker = {
	-- 	cmd = "tmux new-session nnn -Pp",
	-- 	style = { border = "rounded" },
	-- 	session = "shared",
	-- },
	-- replace_netrw = "picker",
	-- windownav = "<C-l>",
	mappings = {
		{ "<C-t>", builtin.open_in_tab },       -- open file(s) in tab
		{ "<C-s>", builtin.open_in_split },     -- open file(s) in split
		{ "<C-v>", builtin.open_in_vsplit },    -- open file(s) in vertical split
		{ "<C-p>", builtin.open_in_preview },   -- open file in preview split keeping nnn focused
		{ "<C-y>", builtin.copy_to_clipboard }, -- copy file(s) to clipboard
		{ "<C-w>", builtin.cd_to_path },        -- cd to file directory
		{ "<C-e>", builtin.populate_cmdline },  -- populate cmdline (:) with file(s)
	},
})

local U = require('settings.util')
U.keymap({"n", "t"}, "<leader>f", ":NnnPicker %:p:h", "NNN file browser")
U.keymap({"n", "t"}, "<leader>e", ":NnnExplorer %:p:h", "NNN file explorer")
U.keymap({"n", "t"}, "<C-A-p>", ":NnnPicker %:p:h", "NNN file browser")
U.keymap({"n", "t"}, "<C-A-n>", ":NnnExplorer %:p:h", "NNN file explorer")

