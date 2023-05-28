local M = {}

local wk = require('which-key')
local U = require('settings.util')

local function tabs_keymap(lhs, rhs, desc)
    U.keymap({'n', 'v'}, "<leader><leader>" .. lhs, rhs, desc)
end

function M.register()
    wk.register({
        ["<leader>"] = { name  = "Tab", },
    }, { prefix = "<leader>" })

    local maps = {
        {"1", "1gt", "goto first tab" },
        {"2", "2gt", "goto second tab" },
        {"3", "3gt", "goto third tab" },
        {"4", "4gt", "goto fourth tab" },
        {"5", "5gt", "goto fifth tab" },
        {"c", ":tabclose", "close current tab" },
        {"o", ":tabonly", "close all except current tab" },
    }

    for _, map in pairs(maps) do
        tabs_keymap(unpack(map))
    end
end

return M

