
local M = {}

local wk = require('which-key')

local U = require('settings.util')

local function barbar_keymap(lhs, rhs, desc)
    U.keymap("n", "<leader>B" .. lhs, rhs, desc)
end

function M.register()
    wk.register({
        B = {
            name  = "Buffer",
        },
    }, { prefix = "<leader>" })

    local maps = {
        {"1", ":BufferGoto 1", "goto buffer 1"},
        {"2", ":BufferGoto 2", "goto buffer 2"},
        {"3", ":BufferGoto 3", "goto buffer 3"},
        {"4", ":BufferGoto 4", "goto buffer 4"},
        {"5", ":BufferGoto 5", "goto buffer 5"},
        {"6", ":BufferGoto 6", "goto buffer 6"},
        {"7", ":BufferGoto 7", "goto buffer 7"},
        {"8", ":BufferGoto 8", "goto buffer 8"},
        {"9", ":BufferGoto 9", "goto buffer 9"},
        {"0", ":BufferLast", "goto last buffer"},
        {"b", ":bfirst", "first buffer" },
        {"B", ":blast", "last buffer" },
        {"N", ":BufferOrderByBufferNumber", "SORT by buffer number" },
        {"F", ":BufferOrderByDirectory", "SORT by directory" },
        {"E", ":BufferOrderByLanguage", "SORT by language" },
        {"W", ":BufferOrderByWindowNumber", "SORT by window number" },
        {"k", ":BufferPin", "toggle PIN" },
        {"j", ":BufferPick", "PICK to buffer" },
        {"H", ":BufferCloseBuffersLeft", "CLOSE all LEFT buffers" },
        {"L", ":BufferCloseBuffersRight", "CLOSE all RIGHT buffers" },
        {"*", ":BufferCloseAllButPinned", "CLOSE all but PINNED" },
        {"n", ":BufferNext", "NEXT buffer" },
        {"p", ":BufferPrevious", "PREVIOUS buffer" },
        {"o", ":BufferCloseAllButCurrent", "CLOSE all but CURRENT" },
        {"x", ":BufferWipeout", "WIPEOUT buffer" },
        {"d", ":BufferClose", "CLOSE buffer" },
        {"/", ":Buffers", "SEARCH buffer (fzf)" },
    }

    for _, map in pairs(maps) do
        barbar_keymap(unpack(map))
    end
end

return M

