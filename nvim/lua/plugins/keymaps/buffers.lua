local M = {}

local wk = require('which-key')

-- TODO: goto
function M.register()
    wk.register({
        ["<Tab>"]   = { "<cmd>:bnext<CR>", "next buffer" },
        ["<S-Tab>"] = { "<cmd>:bprevious<CR>", "previous buffer" },

    }, { prefix = "<leader>" })

    require('plugins.keymaps.buffers-barbar').register()
end

return M

