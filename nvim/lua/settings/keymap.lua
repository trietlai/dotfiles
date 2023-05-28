-- NOTE: remap the builtin keybindings. The keybindings for plugins can be
-- found in lua/plugins/keymaps folder

vim.g.mapleader = ' '
vim.g.maplocalleader = ','
--map('', '<space>', '<Nop>', map_opts)

-- Needed when paste from clipboard to avoid formating
vim.pastetoggle = '<F3>'

local U = require('settings.util')

local function register_insert_mode()
    local insert_maps = {
        {"jj",        "<Esc>", "escaping to normal mode" },
        {"<C-u>",     "<Esc>viwUi", "uppercase word"},
        {"<C-]>",     "<C-x><C-]>", "complete using tags"},
        {"<C-space>", "<C-x><C-o>", "language aware omni-completion"},
        {"<C-b>",     "<C-x><C-p>", "keyword completion from the current buffer"},
        {"<C-d>",     "<C-x><C-k>", "dictionary completion"},
        {"<C-f>",     "<C-x><C-f>", "file path completion"},
        {"<C-l>",     "<C-x><C-l>", "whole-of-line completion"},
        {"<C-^>",     "<C-o><C-^>", "last buffer"},
        -- Readline-style mappings for insert mode
        {"<C-a>",     "<C-o>^",    "begin of line"},
        {"<C-e>",     "<C-o>$",    "end of line"},
        {"<A-b>",     "<C-Left>",  "back to begin of word"},
        {"<A-f>",     "<C-Right>", "forward to begin of word"},
        {"<A-BS>",    "<C-w>",     "delete to begin of word"},
        {"<A-d>",     "<C-o>dw",   "delete to end of word"},
    }

    for _, map in pairs(insert_maps) do
        U.keymap("i", unpack(map))
    end
end


local function register_normal_mode()
    local normal_maps = {
        {"gU", "viwU<Esc>", "uppercase word" },
        {"g.", "<cmd>:normal! `[v`]<CR><LEFT>", "Last inserted text" },
        {"U",  "<C-r>", "redo" },
        {"Y",  "y$",    "yank until the EOL" },
        {"n",  "nzz", "next search matches" },
        {"N",  "Nzz", "previous search matches" },
        --{"<Tab>", "<C-w>w", "next window" },
        --{"<S-Tab>", "<C-w>W", "previous window" },
        {"<C-j>", "<C-w><C-j>", "move to window below (horizontal split)"},
        {"<C-k>", "<C-w><C-k>", "move to window above (horizontal split)"},
        {"<C-l>", "<C-w><C-l>", "move to right window (vertical split)"},
        {"<C-h>", "<C-w><C-h>", "move to left window (vertical split)"},
        {"<Esc>", ":noh<CR>", "no highlight"},

        {"<leader>c", "<cmd>cclose<BAR>lclose<CR>", "close quickfix/location window"},
        {"<leader>-", "<C-w>s", "split window below"},
        {"<leader>|", "<C-w>v", "split window right"},
    }
    for _, map in pairs(normal_maps) do
        U.keymap("n", unpack(map))
    end
end

local function register_command_mode()
    local command_maps = {
        -- Readline-style mappings for command mode
        {"<C-a>",  "<Home>",         "begin of line"},
        {"<C-b>",  "<Left>",         "left one character"},
        {"<C-e>",  "<End>",          "end of line"},
        {"<A-b>",  "<C-Left>",       "back to begin of word"},
        {"<A-f>",  "<C-Right>",      "forward to begin of word"},
        {"<A-BS>", "<C-w>",          "delete to begin of word"},
        {"<A-d>",  "<C-Right><C-w>", "delete to end of word"},
    }
    for _, map in pairs(command_maps) do
        U.keymap("c", unpack(map))
    end
end

local M = {}

function M.register()
    register_insert_mode()
    register_normal_mode()
    register_command_mode()
end

return M

