local M = {}

-- use which-key plugin mainly for documentation
local wk = require('which-key')

local function register_normal_mode_descriptions()
    wk.register({
        s = "jump to next occurrence (lightspeed)",
        S = "jump to previous occurrence (lightspeed)",
        -- jump: next & previous
        ["]"] = {
            name = "jump next",
            a    = "next file",
            A    = "last file",
            b    = { "<cmd>:BufferLineCycleNext<CR>", "next buffer"}, -- TODO
            B    = "last buffer",
            c    = "Git next hunk",
            l    = "next location-list",
            L    = "last location-list",
            q    = "next quickfix",
            Q    = "last quickfix",
            t    = "next tab",
            T    = "last tab",
        },
        ["["] = {
            name = "jump previous",
            a    = "previous file",
            A    = "first file",
            b    = { "<cmd>:BufferLineCyclePrev<CR>", "previous buffer"}, -- TODO
            B    = "first buffer",
            c    = "Git previous hunk",
            l    = "previous location-list",
            L    = "first location-list",
            q    = "previous quickfix",
            Q    = "first quickfix",
            t    = "previous tab",
            T    = "first tab",
        },

        ["+"] = "expand region",
        ["_"] = "shrink region",

        ["<C-b>"] = "scroll back one full screen",
        ["<C-f>"] = "scroll forward one full screen",
        ["<C-d>"] = "scroll forward 1/2 screen",
        ["<C-u>"] = "scroll back 1/2 screen",
        ["<C-e>"] = "scroll down 1 line",
        ["<C-y>"] = "scroll up 1 line",

    }, {
        mode = "n",
    })
end

function M.register()
    register_normal_mode_descriptions()
    require('plugins.keymaps.tabs').register()
    require('plugins.keymaps.windows').register()
    require('plugins.keymaps.buffers').register()
    require('plugins.keymaps.git').register()
    require('plugins.keymaps.themes').register()

    --require('plugins.keymaps.lsp').register()
    -- NOTE: telescope is slower than fzf so stick with fzf-lua for now
    -- require('plugins.keymaps.telescope').register()
    require('plugins.keymaps.fzf').register()

    -- TODO: move these to proper plugin configurations
    wk.register({
        ["?"] = {
            name  = "Help",
            b = { "<cmd>:CheatList<CR>", "browse cheatsheet.ch" },
            c = { "<cmd>:Cheatsheet<CR>", "open local cheatsheet" },
            t = { function() fzf.help_tags() end, "help tags" },
            ["/"] = {"<cmd>:Cheat<CR>", "search cheatsheet.ch" },
        },
    }, { prefix = "<leader>" })
end

return M

