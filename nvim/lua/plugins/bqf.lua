require('bqf').setup({
    auto_enable = true,
    preview = {
        win_height = 25,
        win_vheight = 25,
        delay_syntax = 80,
        border_chars = {'│', '│', '─', '─', '╭', '╮', '╰', '╯', '█'},
    },
})

vim.cmd("hi default link BqfPreviewBorder Type")

