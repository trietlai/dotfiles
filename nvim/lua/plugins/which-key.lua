local wk = require('which-key')
wk.setup {
    key_labels = {
        ["<space>"] = "SPC",
        ["<CR>"]    = "RET",
        ["<Tab>"]   = "TAB",
        ["<S-Tab>"] = "S-TAB",
    },
	window = {
		border = "single", -- none, single, double, shadow
		position = "top", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
		padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
		zindex = 1000, -- positive value to position WhichKey above other floating windows.
	},
	layout = {
		height = { min = 4, max = 33 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 2, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
}

wk.register({

    -- start with 'g'
    g = {
        c     = { "<Plug>Commentary", "Commentary" },
        -- p     = { function() require('telescope').extensions.project.project{} end, "list projects" },
    },

    -- start with ','
    [","] = {
        a = {"<Plug>(EasyAlign)", "Easy align"},
    },
}, {
    mode = "n",
})

