local fterm = require("FTerm")

fterm.setup({
    dimensions  = {
        height = 0.9,
        width = 0.9,
        x = 0.5,
        y = 0.5
    },
    auto_close = true,
    border = 'single' -- or 'double'
})

local gitui = fterm:new({
    ft = 'fterm_gitui', -- You can also override the default filetype, if you want
    cmd = "gitui",
    dimensions = {
        height = 0.9,
        width = 0.9
    },
    auto_close = true,
    border = 'double' -- or 'double'
})

-- Use this to toggle gitui in a floating terminal
vim.keymap.set('n', '<A-g>', function()
    gitui:toggle()
end)

