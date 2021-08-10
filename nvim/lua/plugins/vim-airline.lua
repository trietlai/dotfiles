-- Disable displaying buffer-line as using akinsho/nvim-bufferline.lua plugin instead
vim.g['airline#extensions#tabline#enabled'] = 0
vim.g['airline#extensions#branch#enabled'] = 1
vim.g['airline#extensions#hunks#enabled'] = 1
vim.g['airline#extensions#fugitiveline#enabled'] = 1
vim.g.airline_enabled = 1
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'badwolf'
-- powerline symbols
vim.g.airline_left_sep = ''
vim.g.airline_left_alt_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_right_alt_sep = ''
vim.g['airline_symbols.branch'] = ''
vim.g['airline_symbols.readonly'] = ''
vim.g['airline_symbols.linenr'] = ''

