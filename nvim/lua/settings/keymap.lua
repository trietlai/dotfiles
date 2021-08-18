--Remap space as leader key
local map = vim.api.nvim_set_keymap
local map_opts = { noremap = true, silent = true }
local map_expr_opts = { expr = true, noremap = true, silent = true }

map('', '<space>', '<Nop>', map_opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Needed when paste from clipboard to avoid formating
vim.pastetoggle = '<F3>'

-- Escaping
map('i', 'jj', '<Esc>', { noremap = true })

-- Center next Vim search matches
map('n', 'n', 'nzz', map_opts)
map('n', 'N', 'Nzz', map_opts)

-- autocomplete with Tab
--map('i', '<Tab>', '<cmd>lua tab_complete()', map_expr_opts)
map('i', '<Tab>',
    'pumvisible() ? "<C-n>" : v:lua.check_backspace() ? "<Tab>" : "<C-r>=compe#complete()<CR>"',
    map_expr_opts)

map('s', '<Tab>',
    'pumvisible() ? "<C-n>" : v:lua.check_backspace() ? "<Tab>" : "<C-r>=compe#complete()<CR>"',
    map_expr_opts)

map('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', map_expr_opts)
map('s', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', map_expr_opts)

map('i', '<c-space>', 'compe#complete()', map_expr_opts)

-- autopairs
-- map('i' , '<CR>',[[<cmd>lua require("plugins/nvim-autopairs").completion_confirm()<CR>]],
--     map_expr_opts)

_G.set_color_theme = function(pkg, color, bg)
    if _G.packer_plugins ~= nil and  _G.packer_plugins[pkg] then
        if not _G.packer_plugins[pkg].loaded then
            require('packer').loader(pkg)
        end
        vim.cmd('set background=' .. bg)
        vim.cmd('colorscheme ' .. color)
        require('feline').reset_highlights()
    end
end

-- which-key configurations
local wk = require("which-key")
wk.setup {
    key_labels = {
        ["<space>"] = "SPC",
        ["<CR>"]    = "RET",
        ["<Tab>"]   = "TAB",
        ["<S-Tab>"] = "S-TAB",
    },
}

local M = {}

-- NOTE: LSP keybindings should be buffer local mappings.
-- Using the following register function should be called in 'on_attach' of lspconfig.
M.register_lsp_keymap = function(bufnr)
    require("which-key").register({
        -- start with 'g'
        g = {
            a = {"<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", "list code actions"},
            -- broken
            --d = {"<cmd>lua require('telescope.builtin').lsp_definitions<CR>", "goto definition"},
            d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "goto definition"},
            D = {"<Cmd>lua vim.lsp.buf.declaration()<CR>", "goto declaration"},
            i = {"<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "goto implementation"},
            k = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "signature help"},
            r = {"<cmd>lua require('telescope.builtin').lsp_references()<CR>", "display references"},
            s = {"<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "list document symbols"},
            S = {"<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", "list workspace symbols"},
            T = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "type definition"},
            x = {"<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>", "list diagnostics"},
            X = {"<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>", "list workspace diagnostics"},
        },
        ["]"] = {
            d = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Move to the next diagnostic"},
        },
        ["["] = {
            d = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Move to the previous diagnostic"},
        },

        K = {"<Cmd>lua vim.lsp.buf.hover()<CR>", "display info of symbol under cursor"},
    }, {
        mode    = "n", -- NORMAL mode
        buffer  = bufnr, -- buffer local normal mode
        prefix  = "",
        silent  = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait  = false, -- use `nowait` when creating keymaps
    })

    require("which-key").register({
        L = {
            name = "Language",
            a = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
            --d = {"<cmd>lua require('telescope.builtin').lsp_definitions<CR>", "goto definition"},
            d = {"<cmd>lua vim.lsp.buf.definition()<CR>", "goto definition"},
            D = {"<Cmd>lua vim.lsp.buf.declaration()<CR>", "goto declaration"},
            e = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "show line diagnostics"},
            f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"},
            i = {"<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", "goto implementation"},
            I = {"<cmd>LspInfo<cr>", "LSP info"},
            j = {"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>", "Next Diagnostic"},
            k = {"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>", "Prev Diagnostic"},
            K = {"<cmd>lua vim.lsp.buf.signature_help()<CR>", "signature help"},
            q = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "set location-list"},
            r = {"<cmd>lua require('telescope.builtin').lsp_references()<CR>", "display references"},
            R = {"<cmd>lua vim.lsp.buf.rename()<CR>", "rename"},
            s = {"<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "list document symbols"},
            S = {"<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>", "list workspace symbols"},
            t = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "type definition"},
            w = {
                name  = "workspace",
                d = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
                a = {"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "add workspace folder"},
                r = {"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "remove workspace folder"},
                l = {"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "list workspace folders"},
            },
            x = {"<cmd>lua require('telescope.builtin').lsp_document_diagnostics()<CR>", "list diagnostics"},
            X = {"<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<CR>", "list workspace diagnostics"},
        }
    }, {
        mode    = "n", -- NORMAL mode
        buffer  = bufnr, -- buffer local normal mode
        prefix  = "<leader>",
        silent  = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait  = false, -- use `nowait` when creating keymaps
    })
end

-- basic mappings
-- global normal mode
wk.register({
    -- start with 'g'
    g = {
        c     = {"<Plug>Commentary", "Commentary"},
        p     = {"<cmd>lua require('telescope').extensions.project.project{}<CR>", "list projects"},
        U     = {"viwU<Esc>", "uppercase word"},
        ["."] = {"<cmd>:normal! `[v`]<CR><LEFT>", "Last inserted text"},
    },
    -- start with ','
    [","] = {
        a = {"<Plug>(EasyAlign)", "Easy align"},
    },

    --K = {"<Cmd>lua vim.lsp.buf.hover()<CR>", "display info of symbol under cursor"},
    s = "jump to next occurrence (lightspeed)",
    S = "jump to previous occurrence (lightspeed)",
    U = {"<C-r>", "redo"},
    Y = {"y$",    "yank until the EOL"},

    -- jump: next & previous
    ["]"] = {
        name = "jump next",
        a    = "next file",
        A    = "last file",
        b    = { "<cmd>:BufferLineCycleNext<CR>", "next buffer"},
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
        b    = { "<cmd>:BufferLineCyclePrev<CR>", "previous buffer"},
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

    -- <tab> / <s-tab> | Circular windows navigation
    ["<Tab>"]   = {"<C-w>w", "next window"},
    ["<S-Tab>"] = {"<C-w>W", "previous window"},

    ["<F4>"]    = {"<cmd>:NvimTreeToggle<CR>", "toggle NvimTree"},
    -- ["<F5>"]    = {"<cmd>:NERDTreeToggle<CR>", "toggle NerdTree"},
    ["<F5>"]    = {"<cmd>:SymbolsOutline<CR>", "toggle symbols-outline"},
    ["<F12>"]   = {"<cmd>lua require('FTerm').toggle()<CR>", "toggle terminal"},

    -- Easier split navigations
    ["<C-j>"]   = {"<C-w><C-j>", "move to window below (horizontal split)"},
    ["<C-k>"]   = {"<C-w><C-k>", "move to window above (horizontal split)"},
    ["<C-l>"]   = {"<C-w><C-l>", "move to right window (vertical split)"},
    ["<C-h>"]   = {"<C-w><C-h>", "move to left window (vertical split)"},

    ["<C-b>"] = "scroll back one full screen",
    ["<C-f>"] = "scroll forward one full screen",
    ["<C-d>"] = "scroll forward 1/2 screen",
    ["<C-u>"] = "scroll back 1/2 screen",
    ["<C-e>"] = "scroll down 1 line",
    ["<C-y>"] = "scroll up 1 line",

    ["<Esc>"] = {":noh<CR>", "no highlight"},
})


-- insert mode
wk.register({
    ["<C-u>"]     = {"<Esc>viwUi", "uppercase word"},

    ["<C-]>"]     = {"<C-x><C-]>", "complete using tags"},
    ["<C-space>"] = {"<C-x><C-o>", "language aware omni-completion"},
    ["<C-b>"]     = {"<C-x><C-p>", "keyword completion from the current buffer"},
    ["<C-d>"]     = {"<C-x><C-k>", "dictionary completion"},
    ["<C-f>"]     = {"<C-x><C-f>", "file path completion"},
    ["<C-l>"]     = {"<C-x><C-l>", "whole-of-line completion"},

    ["<C-^>"]     = {"<C-o><C-^>", "last buffer"},

    -- Readline-style mappings for insert mode
    ["<C-a>"]     = {"<C-o>^",    "begin of line"},
    ["<C-e>"]     = {"<C-o>$",    "end of line"},
    ["<A-b>"]     = {"<C-Left>",  "back to begin of word"},
    ["<A-f>"]     = {"<C-Right>", "forward to begin of word"},
    ["<A-BS>"]    = {"<C-w>",     "delete to begin of word"},
    ["<A-d>"]     = {"<C-o>dw",   "delete to end of word"},
}, { mode = "i" })

-- command mode
wk.register({
    -- Readline-style mappings for command mode
    ["<C-a>"]  = {"<Home>",         "begin of line"},
    ["<C-b>"]  = {"<Left>",         "left one character"},
    ["<C-e>"]  = {"<End>",          "end of line"},
    ["<A-b>"]  = {"<C-Left>",       "back to begin of word"},
    ["<A-f>"]  = {"<C-Right>",      "forward to begin of word"},
    ["<A-BS>"] = {"<C-w>",          "delete to begin of word"},
    ["<A-d>"]  = {"<C-Right><C-w>", "delete to end of word"},
}, { mode = "c" })

-- visual mode
wk.register({
    ga = {"<Plug>(EasyAlign)", "Easy align"},
}, { mode = "x" })

-- visual mode
wk.register({
    ["<F12>"]   = {"<cmd>lua require('FTerm').toggle()<CR>", "toggle terminal"},
}, { mode = "t" })

-- leader
-- single
wk.register({
    -- b = {"<cmd>:Buffers<CR>", "list buffers"},
    b = {"<cmd>lua require('telescope.builtin').buffers()<CR>", "list buffers"},
    c = {"<cmd>cclose<BAR>lclose<CR>", "close quickfix/location window"},
    g = {"<cmd>lua require('telescope.builtin').git_status()<CR>", "Git status"},
    f = {"<cmd>lua require('telescope.builtin').file_browser()<CR>", "file browser"},
    h = {"<cmd>lua require('telescope.builtin').search_history()<CR>", "search history"},
    l = {"<cmd>lua require('telescope.builtin').loclist()<CR>", "quickfix list"},
    m = {"<cmd>lua require('telescope.builtin').keymaps()<CR>", "show keymaps"},
    p = {"<cmd>lua require('extensions.telescope-dotfile').project_files()<CR>", "search project files"},
    q = {"<cmd>lua require('telescope.builtin').quickfix()<CR>", "quickfix list"},
    r = {"<cmd>lua require('telescope.builtin').oldfiles()<CR>", "recent files"},
    t = {"<cmd>lua require('telescope.builtin').tags()<CR>", "tags"},
    w = {"<cmd>:Windows<CR>", "find windows"},

    ["1"] = "goto buffer 1",
    ["2"] = "goto buffer 2",
    ["3"] = "goto buffer 3",
    ["4"] = "goto buffer 4",
    ["5"] = "goto buffer 5",
    ["6"] = "goto buffer 6",
    ["7"] = "goto buffer 7",
    ["8"] = "goto buffer 8",
    ["9"] = "goto buffer 9",
    ["-"] = {"<C-w>s", "split window below"},
    ["|"] = {"<C-w>v", "split window right"},
    ["/"] = {"<cmd>lua require('telescope.builtin').live_grep()<CR>", "search text"},

    ["<Tab>"]   = {"<cmd>:bnext<CR>", "next buffer"},
    ["<S-Tab>"] = {"<cmd>:bprevious<CR>", "previous buffer"},
    [":"]       = {"<cmd>lua require('telescope.builtin').command_history()<CR>", "command history"},
    ["`"]       = {"<cmd>lua require('telescope.builtin').marks()<CR>", "marks"},
    ['"']       = {"<cmd>lua require('telescope.builtin').registers()<CR>", "registers"},
    ["="]       = {"<cmd>lua require('telescope.builtin').spell_suggest()<CR>", "spell suggest"},
    ["."]       = {"<cmd>lua require('extensions.telescope-dotfile').search_dotfiles()<CR>", "search dotfiles"},
}, { prefix = "<leader>" })

wk.register({
    ga          = {"<Plug>(LiveEasyAlign)", "live easy align"},
}, { prefix = "<leader>", mode = "x" })

-- group
wk.register({
    ["<Leader>"] = {
        name  = "Tab",
        ["1"] = {"<cmd>1gt<CR>", "goto first tab"},
        ["2"] = {"<cmd>2gt<CR>", "goto second tab"},
        ["3"] = {"<cmd>3gt<CR>", "goto third tab"},
        ["4"] = {"<cmd>4gt<CR>", "goto fourth tab"},
        ["5"] = {"<cmd>5gt<CR>", "goto fifth tab"},
        c     = {"<cmd>:tabclose<CR>", "close current tab"},
        o     = {"<cmd>:tabonly<CR>", "close all except current tab"},
    },
    ["?"] = {
        name  = "Help",
        b = {"<cmd>:CheatList<CR>", "browse cheatsheet.ch"},
        c = {"<cmd>:Cheatsheet<CR>", "open local cheatsheet"},
        t = {"<cmd>lua require('telescope.builtin').help_tags()<CR>", "help tags"},
        ["/"] = {"<cmd>:Cheat<CR>", "search cheatsheet.ch"},
    },
    B = {
        name  = "Buffer",
        b     = {"<cmd>:bfirst<CR>", "first buffer"},
        B     = {"<cmd>:blast<CR>", "last buffer"},
        --d     = {"<cmd>:Bdelete<CR>", "delete buffer"},
        -- bufferline plugin
        -- D     = {"<cmd>:BufferLineSortByDirectory<cr>", "sort BufferLines automatically by directory"},
        -- e     = {"<cmd>:BufferLineSortByExtension<cr>", "sort buffers automatically by extension"},
        -- h     = {"<cmd>:BufferLineCloseLeft<cr>", "close all buffers to the left"},
        -- j     = {"<cmd>:BufferLinePick<cr>", "jump to buffer" },
        -- l     = {"<cmd>:BufferLineCloseRight<cr>", "close all BufferLines to the right"},
        -- n     = {"<cmd>:BufferLineCycleNext<CR>", "next buffer"},
        -- p     = {"<cmd>:BufferLineCyclePrev<CR>", "previous buffer"},
        -- barbar plugin
        N     = {"<cmd>:BufferOrderByBufferNumber<cr>", "SORT by buffer number"},
        F     = {"<cmd>:BufferOrderByDirectory<cr>", "SORT by directory"},
        E     = {"<cmd>:BufferOrderByLanguage<cr>", "SORT by language"},
        W     = {"<cmd>:BufferOrderByWindowNumber<cr>", "SORT by window number"},
        k     = {"<cmd>:BufferPin<cr>", "toggle PIN" },
        j     = {"<cmd>:BufferPick<cr>", "PICK to buffer" },
        H     = {"<cmd>:BufferCloseBuffersLeft<cr>", "CLOSE all LEFT buffers"},
        L     = {"<cmd>:BufferCloseBuffersRight<cr>", "CLOSE all RIGHT buffers"},
        ["*"] = {"<cmd>:BufferCloseAllButPinned<cr>", "CLOSE all but PINNED"},
        n     = {"<cmd>:BufferNext<CR>", "NEXT buffer"},
        p     = {"<cmd>:BufferPrevious<CR>", "PREVIOUS buffer"},
        o     = {"<cmd>:BufferCloseAllButCurrent<CR>", "CLOSE all but CURRENT"},
        x     = {"<cmd>:BufferWipeout<CR>", "WIPEOUT buffer"},
        d     = {"<cmd>:BufferClose<CR>", "CLOSE buffer"},
        ["/"] = {"<cmd>:Buffers<CR>", "SEARCH buffer (fzf)"},
    },
    F = {
        name      = "FZF",
        a         = {
            name  = "Ag search",
            ["g"] = {"<cmd>:Ag <C-R><C-W><CR>", "Ag search word at point"},
            ["G"] = {"<cmd>:Ag <C-R><C-A><CR>", "Ag search line at point"},
            ['"'] = {'<cmd>:Ag <C-R>"<CR>', "Ag search from register"},
        },
        b         = {"<cmd>:Buffers<CR>", "find buffers"},
        c         = {"<cmd>:Commits<CR>", "find Git commits"},
        C         = {"<cmd>:Colors<CR>", "find colors"},
        f         = {"<cmd>:Files<CR>", "find files"},
        h         = {
            name  = "history",
            ["h"] = {"<cmd>:History<CR>", "find file/buffer history"},
            [":"] = {"<cmd>:History:<CR>", "find command history"},
            ["/"] = {"<cmd>:History/<CR>", "find search history"},
        },
        H         = {"<cmd>:Helptags<CR>", "find Helptags"},
        m         = {"<cmd>:Maps<CR>", "find maps"},
        l         = {"<cmd>:Lines<CR>", "find lines"},
        w         = {"<cmd>:Windows<CR>", "find windows"},
        x         = {"<cmd>:Commands<CR>", "find commands"},
        ["/"]     = {"<cmd>:Rg <C-R><C-W><CR>", "Rg search word at point"},
        ["`"]     = {"<cmd>:Marks<CR>", "fuzzy finder marks"},
    },
    G = {
        name  = "Git",
        b     = {"<cmd>lua require('telescope.builtin').git_branch()<CR>", "list branches"},
        B     = {"<cmd>:Gblame<CR>", "blame"},
        c     = {"<cmd>lua require('telescope.builtin').git_commits()<CR>", "list commits"},
        d     = {"<cmd>:Gvdiff<CR>", "diff"},
        D     = {"<cmd>:DiffviewOpen<CR>", "diff view"},
        f     = {"<cmd>:Gfetch<CR>", "fetch"},
        FP    = {"<cmd>:Gpush --force-with-lease<CR>", "push but force with lease"},
        l     = {"<cmd>:GV!<CR>", "log for current file"},
        L     = {"<cmd>:GV<CR>", "full log"},
        m     = {"<cmd>:Git checkout master<CR>", "checkout master"},
        o     = {"<cmd>:GCheckout<CR>", "checkout"},
        p     = {"<cmd>:Gpull<CR>", "pull"},
        P     = {"<cmd>:Gpush<CR>", "push"},
        r     = {"<cmd>:Grebase -i master<CR>", "rebase -i master"},
        s     = {"<cmd>lua require('telescope.builtin').git_status()<CR>", "list changes"},
        S     = {"<cmd>lua require('telescope.builtin').git_stash()<CR>", "list stashes"},
        ["-"] = {"<cmd>:Git checkout -<CR>", "checkout -"},
    },
    H = {
        name = "git-gutter",
        p    = "preview hunk",
        q    = {"<cmd>Gqf<CR>", "show hunks in quickfix"},
        s    = "stage hunk",
        u    = "undo hunk",
    },
    M = {
        name       = "merge-tool",
        ["1"]      = {"<cmd>:MergetoolToggleLayout mr<CR>", "layout mr: MERGED-REMOTE"},
        ["2"]      = {"<cmd>:MergetoolToggleLayout ml<CR>", "layout ml: MERGED-LOCAL"},
        ["3"]      = {"<cmd>:MergetoolToggleLayout LmR<CR>", "layout LmR: LOCAL-MERGED-REMOTE"},
        ["4"]      = {"<cmd>:MergetoolToggleLayout mr,b<CR>", "layout mr,b: MERGED-REMOTE/BASE"},
        ["5"]      = {"<cmd>:MergetoolToggleLayout LBR<CR>", "layout LBR: LOCAL-BASE-REMOTE"},
        l          = {"<cmd>:MergetoolDiffExchangeLeft<CR>", "get/put from/to RIGHT"},
        h          = {"<cmd>:MergetoolDiffExchangeRight<CR>", "get/put from/to LEFT"},
        k          = {"<cmd>:MergetoolDiffExchangeDown<CR>", "get/put from/to UP"},
        j          = {"<cmd>:MergetoolDiffExchangeUp<CR>", "get/put from/to DOWN"},
        m          = {"<cmd>:MergetoolPreferLocal<CR>", "use MINE/LOCAL for MERGED"},
        q          = {"<cmd>:MergetoolStop<CR>", "quit merge-tool"},
        t          = {"<cmd>:MergetoolPreferRemote<CR>", "use THEIR/REMOTE for MERGED"},
        s          = {"<cmd>:MergetoolStart<CR>", "start merge-tool"},
        z          = {"<Plug>(MergetoolToggle)", "toggle merge-tool"},
    },
    S = {
        name  = "Search",
        a     = {"<cmd>:Ag<CR>", "text Ag"},
        b     = {"<cmd>:BLines<CR>", "current buffer"},
        B     = {"<cmd>:Buffers<CR>", "open buffers"},
        c     = {"<cmd>:Commits<CR>", "commits"},
        C     = {"<cmd>:BCommits<CR>", "buffer commits"},
        f     = {"<cmd>:Files<CR>", "files"},
        g     = {"<cmd>:GFiles<CR>", "git files"},
        G     = {"<cmd>:GFiles?<CR>", "modified git files"},
        h     = {"<cmd>:History<CR>", "file history"},
        H     = {"<cmd>:History:<CR>", "command history"},
        l     = {"<cmd>:Lines<CR>", "lines"},
        m     = {"<cmd>:Marks<CR>", "marks"},
        M     = {"<cmd>:Maps<CR>", "normal maps"},
        p     = {"<cmd>:Helptags<CR>", "help tags"},
        P     = {"<cmd>:Tags<CR>", "project tags"},
        s     = {"<cmd>:Snippets<CR>", "snippets"},
        S     = {"<cmd>:Colors<CR>", "color schemes"},
        t     = {"<cmd>:Rg<CR>", "text Rg"},
        T     = {"<cmd>:BTags<CR>", "buffer tags"},
        w     = {"<cmd>:Windows<CR>", "search windows"},
        y     = {"<cmd>:Filetypes<CR>", "file types"},
        z     = {"<cmd>:FZF<CR>", "FZF"},
        ["/"] = {"<cmd>:History/<CR>", "history"},
        [";"] = {"<cmd>:Commands<CR>", "commands"},
    },
    T = {
        name = "Theme",
        a = {
            function()
                set_color_theme('material.vim', 'material', 'dark')
            end,
            "material dark"
        },
        b = {
            function()
                set_color_theme('papercolor-theme', 'PaperColor', 'dark')
            end,
            "PaperColor dark"
        },
        B = {
            function()
                set_color_theme('papercolor-theme', 'PaperColor', 'light')
            end,
            "PaperColor light"
        },
        c = {
            function()
                set_color_theme('ayu-vim', 'ayu', 'dark')
            end,
            "ayu dark"
        },
        C = {
            function()
                set_color_theme('ayu-vim', 'ayu', 'light')
            end,
            "ayu light"
        },
        d = {
            function()
                set_color_theme('gruvbox-material', 'gruvbox-material', 'dark')
            end,
            "gruvbox-material dark"
        },
        D = {
            function()
                set_color_theme('gruvbox-material', 'gruvbox-material', 'light')
            end,
            "gruvbox-material light"
        },
        e = {
            function()
                set_color_theme('gruvbox', 'gruvbox', 'dark')
            end,
            "gruvbox dark"
        },
        E = {
            function()
                set_color_theme('gruvbox', 'gruvbox', 'light')
            end,
            "gruvbox light"
        },
        f = {
            function()
                set_color_theme('sonokai', 'sonokai', 'dark')
            end,
            "sonokai dark"
        },
        g = {
            function()
                set_color_theme('tokyonight.nvim', 'tokyonight', 'dark')
            end,
            "tokyonight dark"
        },
        G = {
            function()
                set_color_theme('tokyonight.nvim', 'tokyonight', 'light')
            end,
            "tokyonight light"
        },
        h = {
            function()
                set_color_theme('edge', 'edge', 'dark')
            end,
            "edge dark"
        },
        H = {
            function()
                set_color_theme('edge', 'edge', 'light')
            end,
            "edge light"
        },
        i = {
            function()
                set_color_theme('space-nvim', 'space-nvim', 'dark')
            end,
            "space-nvim dark"
        },
        I = {
            function()
                set_color_theme('space-nvim', 'space-nvim', 'light')
            end,
            "space-nvim light"
        },
        j = {
            function()
                set_color_theme('everforest', 'everforest', 'dark')
            end,
            "everforest dark"
        },
        J = {
            function()
                set_color_theme('everforest', 'everforest', 'light')
            end,
            "everforest light"
        },
    },
    W = {
        name  = "Windows" ,
        d     = {"<C-W>c", "delete window"},
        h     = {"<C-W>h", "window left"},
        H     = {"<C-W>5<", "expand window left"},
        j     = {"<C-W>j", "window below"},
        J     = {"<cmd>:resize +5<CR>", "expand window below"},
        k     = {"<C-W>k", "window up"},
        K     = {"<cmd>:resize -5<CR>", "expand window up"},
        l     = {"<C-W>l", "window right"},
        L     = {"<C-W>5>", "expand window right"},
        s     = {"<C-W>s", "split window below"},
        v     = {"<C-W>v", "split window below"},
        w     = {"<C-W>w", "other window"},
        ["-"] = {"<C-W>s", "split window below"},
        ["|"] = {"<C-W>v", "split window right"},
        ["2"] = {"<C-W>v", "layout double columns"},
        ["="] = {"<C-W>=", "balance window"},
        ["?"] = {"<cmd>:Windows<CR>", "fzf window"},
    },
}, { prefix = "<leader>" })

-- vim.cmd 'highlight default link WhichKeyGroup Type'

return M

