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

-- key bindings
local U = require('settings.util')

U.keymap({"n", "t"}, "<F12>", function() fterm.toggle() end, "toggle terminal")

-- toggle gitui in a floating terminal
U.keymap("n", "<A-g>", function() gitui:toggle() end, "toggle GitUI")

