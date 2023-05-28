local M = {}

local wk = require('which-key')
local U = require('settings.util')

local function window_keymap(lhs, rhs, desc)
    U.keymap("n", "<leader>W" .. lhs, rhs, desc)
end

function M.register()
    -- for group description
    wk.register({
        W = {
            name  = "Windows" ,
        },
    }, { prefix = "<leader>" })

    local maps = {
        {"d", "<C-W>c", "delete window"},
        {"h", "<C-W>h", "window left"},
        {"H", "<C-W>5<", "expand window left"},
        {"j", "<C-W>j", "window below"},
        {"J", "<cmd>:resize +5<CR>", "expand window below"},
        {"k", "<C-W>k", "window up"},
        {"K", "<cmd>:resize -5<CR>", "expand window up"},
        {"l", "<C-W>l", "window right"},
        {"L", "<C-W>5>", "expand window right"},
        {"s", "<C-W>s", "split window below"},
        {"v", "<C-W>v", "split window below"},
        {"w", "<C-W>w", "other window"},
        {"-", "<C-W>s", "split window below"},
        {"|", "<C-W>v", "split window right"},
        {"2", "<C-W>v", "layout double columns"},
        {"=", "<C-W>=", "balance window"},
        {"?", "<cmd>:Windows<CR>", "fzf window"},
    }

    for _, map in pairs(maps) do
        window_keymap(unpack(map))
    end
end

return M

