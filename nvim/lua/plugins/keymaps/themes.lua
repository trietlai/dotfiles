local M = {}

local packer = require('packer')
local wk = require('which-key')
local U = require('settings.util')

local set_color_theme = function(pkg, color, bg)
    if packer_plugins ~= nil and  packer_plugins[pkg] then
        if not packer_plugins[pkg].loaded then
            packer.loader(pkg)
        end
        vim.cmd('set background=' .. bg)
        vim.cmd('colorscheme ' .. color)
        -- require('feline').reset_highlights()
    end
end

local function theme_keymap(lhs, pkg, color, bg, desc)
    U.keymap("n", "<leader>T" .. lhs,
        function() set_color_theme(pkg, color, bg) end, desc)
end

function M.register()
    local maps = {
        {"a", 'material.vim', 'material', 'dark', "material dark"},
        {"b", 'papercolor-theme', 'PaperColor', 'dark', "PaperColor dark"},
        {"B", 'papercolor-theme', 'PaperColor', 'light', "PaperColor light"},
        {"c", 'ayu-vim', 'ayu', 'dark', "ayu dark"},
        {"C", 'ayu-vim', 'ayu', 'light', "ayu light"},
        {"d", 'gruvbox-material', 'gruvbox-material', 'dark', "gruvbox-material dark"},
        {"D", 'gruvbox-material', 'gruvbox-material', 'light', "gruvbox-material light"},
        {"e", 'gruvbox', 'gruvbox', 'dark', "gruvbox dark"},
        {"E", 'gruvbox', 'gruvbox', 'light', "gruvbox light"},
        {"f", 'sonokai', 'sonokai', 'dark', "sonokai dark"},
        {"g", 'tokyonight.nvim', 'tokyonight', 'dark', "tokyonight dark"},
        {"G", 'tokyonight.nvim', 'tokyonight', 'light', "tokyonight light"},
        {"h", 'edge', 'edge', 'dark', "edge dark"},
        {"H", 'edge', 'edge', 'light', "edge light"},
        {"i", 'space-nvim', 'space-nvim', 'dark', "space-nvim dark"},
        {"I", 'space-nvim', 'space-nvim', 'light', "space-nvim light"},
        {"j", 'everforest', 'everforest', 'dark', "everforest dark"},
        {"J", 'everforest', 'everforest', 'light', "everforest light"},
    }

    for _, map in pairs(maps) do
        theme_keymap(unpack(map))
    end

    wk.register({
        T = {
            name = "Theme",
        },
    }, { prefix = "<leader>" })

end

return M

