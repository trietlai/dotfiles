if vim.fn.has("termguicolors") == 1 then
    -- true color
    vim.go.t_8f = "[[38;2;%lu;%lu;%lum"
    vim.go.t_8b = "[[48;2;%lu;%lu;%lum"
    vim.opt.termguicolors = true
end

vim.opt.background = 'dark'

-- colorscheme
-- gruvbox material
-- vim.g.gruvbox_material_enable_italic = 1
-- vim.g.gruvbox_material_sign_column_background = 'none'
-- vim.g.gruvbox_contrast_dark = 'hard'
-- vim.cmd 'color gruvbox-material'

-- vim.cmd 'color sonokai'

vim.g.material_terminal_italics = 1
vim.g.material_theme_style = 'ocean'
vim.cmd 'color material'

-- these settings below override the colorscheme setting
-- vim.cmd 'hi CursorLine cterm=NONE ctermbg=DarkGrey ctermfg=NONE gui=NONE guifg=NONE guibg=grey18'

