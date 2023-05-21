local db = require('dashboard')
db.setup({
	theme = 'hyper',
	config = {
		week_header = {
			enable = true,
		},
		disable_move = true,
		shortcut = {
			{ desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
			{
				icon = ' ',
				icon_hl = '@variable',
				desc = 'Files',
				group = 'Label',
				action = 'Telescope find_files',
				key = 'f',
			},
			{
				desc = ' Apps',
				group = 'DiagnosticHint',
				action = 'Telescope app',
				key = 'a',
			},
			{
				desc = ' dotfiles',
				group = 'Number',
				action = 'Telescope dotfiles',
				key = 'd',
			},
		},
		packages = { enable = true }, -- show how many plugins neovim loaded
		project = {
			enable = true,
			limit = 8,
			--icon = ' ',
			--label = 'Projects',
			action = function(path)
                vim.cmd('Telescope find_files cwd=' .. path)
            end
        },
	},
})

