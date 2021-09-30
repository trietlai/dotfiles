--Remap space as leader key
local map = vim.api.nvim_set_keymap
local map_opts = { noremap = true, silent = true }
local map_expr_opts = { expr = true, noremap = true, silent = true }
local tbuiltin = require('telescope.builtin')
local fzf = require('fzf-lua')

map('', '<space>', '<Nop>', map_opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Needed when paste from clipboard to avoid formating
vim.pastetoggle = '<F3>'

-- Escaping
map('i', 'jj', '<Esc>', { noremap = true })

-- Center next Vim search matches
map('n', 'n', 'nzz', map_opts)
map('n', 'N', 'Nzz', map_opts)

-- auto-completion using compe
map('i', '<C-Space', "compe#complete()", map_expr_opts)
map('i', '<CR>', "compe#confirm('<CR>')", map_expr_opts)
map('i', '<C-e>', "compe#close('<C-e>')", map_expr_opts)
map('i', '<C-f>', "compe#scroll({ 'delta': +4 })", map_expr_opts)
map('i', '<C-d>', "compe#scroll({ 'delta': -4 })", map_expr_opts)
-- auto-completion with TAB: `tab_complete()` and `s_tab_complete()` take `luasnip`
-- completion into account.
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

--map("i", "<C-E>", "<Plug>luasnip-next-choice", {})
--map("s", "<C-E>", "<Plug>luasnip-next-choice", {})

-- autopairs
-- map('i' , '<CR>',[[<cmd>lua require("plugins/nvim-autopairs").completion_confirm()<CR>]],
--     map_expr_opts)

local set_color_theme = function(pkg, color, bg)
    if packer_plugins ~= nil and  packer_plugins[pkg] then
        if not packer_plugins[pkg].loaded then
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
            a = { function() fzf.lsp_code_actions() end, "list code actions" },
            d = { function() fzf.lsp_definitions() end, "goto definition"},
            D = { function() fzf.lsp_declarations() end, "goto declaration" },
            i = { function() fzf.lsp_implementations() end, "goto implementation" },
            k = { function() vim.lsp.buf.signature_help() end, "signature help" },
            r = { function() fzf.lsp_references() end, "display references" },
            s = { function() fzf.lsp_document_symbols() end, "list document symbols" },
            S = { function() fzf.lsp_workspace_symbols() end, "list workspace symbols" },
            T = { function() fzf.lsp_typedefs() end, "type definition" },
            x = { function() fzf.lsp_document_diagnostics() end, "list diagnostics" },
            X = { function() fzf.lsp_workspace_diagnostics() end, "list workspace diagnostics" },
        },
        ["]"] = {
            d = { function() vim.lsp.diagnostic.goto_next() end, "Move to the next diagnostic" },
        },
        ["["] = {
            d = { function() vim.lsp.diagnostic.goto_prev() end, "Move to the previous diagnostic" },
        },

        K = { function() vim.lsp.buf.hover() end, "display info of symbol under cursor" },
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
            a = { function() fzf.lsp_code_action() end, "Code Action" },
            d = { function() fzf.lsp_definitions() end, "goto definition" },
            D = { function() fzf.lsp_declaration() end, "goto declaration" },
            e = { function() vim.lsp.diagnostic.show_line_diagnostics() end, "show line diagnostics" },
            f = { function() vim.lsp.buf.formatting() end, "Format" },
            i = { function() fzf.lsp_implementations() end, "goto implementation" },
            I = {"<cmd>LspInfo<CR>", "LSP info"},
            j = {
                function()
                    vim.lsp.diagnostic.goto_next({
                        popup_opts = { border = vim.lsp.popup_border }
                    })
                end, "Next Diagnostic" },
            k = {
                function()
                    vim.lsp.diagnostic.goto_prev({
                        popup_opts = { border = vim.lsp.popup_border}
                    })
                end, "Prev Diagnostic" },
            K = { function() vim.lsp.buf.signature_help() end, "signature help" },
            q = { function() vim.lsp.diagnostic.set_loclist() end, "set location-list" },
            r = { function() fzf.lsp_references() end, "display references" },
            R = { function() vim.lsp.buf.rename() end, "rename" },
            s = { function() fzf.lsp_document_symbols() end, "list document symbols" },
            S = { function() fzf.lsp_workspace_symbols() end, "list workspace symbols" },
            t = { function() fzf.lsp_typedefs() end, "type definition" },
            w = {
                name  = "workspace",
                d = { "<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
                a = { function() vim.lsp.buf.add_workspace_folder() end, "add workspace folder" },
                r = { function() vim.lsp.buf.remove_workspace_folder() end, "remove workspace folder" },
                l = {
                    function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, "list workspace folders" },
            },
            x = { function() fzf.lsp_document_diagnostics() end, "list diagnostics" },
            X = { function() fzf.lsp_workspace_diagnostics() end, "list workspace diagnostics" },
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
        c     = { "<Plug>Commentary", "Commentary" },
        p     = { function() require('telescope').extensions.project.project{} end, "list projects" },
        U     = { "viwU<Esc>", "uppercase word" },
        ["."] = { "<cmd>:normal! `[v`]<CR><LEFT>", "Last inserted text" },
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

    ["<F4>"]    = {"<cmd>lua require'nvim-tree'.toggle()<CR>", "toggle NvimTree"},
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
    -- b = {"<cmd>:Buffers<CR>", "list buffers" },
    b = { function() fzf.buffers() end, "list buffers" },
    c = { "<cmd>cclose<BAR>lclose<CR>", "close quickfix/location window" },
    --f = { function() tbuiltin.file_browser() end, "file browser" },
    f = { "<cmd>:NnnPicker %:p:h<CR>", "file browser" },
    g = { function() fzf.git_status() end, "Git status" },
    h = { function() fzf.search_history() end, "search history" },
    j = { function() tbuiltin.jumplist() end, "jump list" },
    l = { function() fzf.loclist() end, "location list" },
    m = { function() fzf.keymaps() end, "show keymaps" },
    p = {
        function() require('extensions.telescope-dotfile').project_files() end,
        "search project files"
    },
    q = { function() fzf.quickfix() end, "quickfix list" },
    r = { function() fzf.oldfiles() end, "recent files" },
    t = { function() fzf.tags() end, "tags" },
    w = { "<cmd>:Windows<CR>", "find windows" },

    ["1"] = "goto buffer 1",
    ["2"] = "goto buffer 2",
    ["3"] = "goto buffer 3",
    ["4"] = "goto buffer 4",
    ["5"] = "goto buffer 5",
    ["6"] = "goto buffer 6",
    ["7"] = "goto buffer 7",
    ["8"] = "goto buffer 8",
    ["9"] = "goto buffer 9",
    ["-"] = { "<C-w>s", "split window below" },
    ["|"] = { "<C-w>v", "split window right" },
    ["/"] = { function() fzf.live_grep() end, "search text" },
    --["/"] = {"<cmd>:Rg<CR>", "search text"},

    ["<Tab>"]   = { "<cmd>:bnext<CR>", "next buffer" },
    ["<S-Tab>"] = { "<cmd>:bprevious<CR>", "previous buffer" },
    [":"]       = { function() fzf.command_history() end, "command history" },
    ["`"]       = { function() fzf.marks() end, "marks" },
    ['"']       = { function() fzf.registers() end, "registers" },
    ["="]       = { function() fzf.spell_suggest() end, "spell suggest" },
    ["."]       = {
        function()
            require('extensions.telescope-dotfile').search_dotfiles()
        end, "search dotfiles"
    },
}, { prefix = "<leader>" })

wk.register({
    ga          = {"<Plug>(LiveEasyAlign)", "live easy align"},
}, { prefix = "<leader>", mode = "x" })

-- group
wk.register({
    ["<Leader>"] = {
        name  = "Tab",
        ["1"] = { "<cmd>1gt<CR>", "goto first tab" },
        ["2"] = { "<cmd>2gt<CR>", "goto second tab" },
        ["3"] = { "<cmd>3gt<CR>", "goto third tab" },
        ["4"] = { "<cmd>4gt<CR>", "goto fourth tab" },
        ["5"] = { "<cmd>5gt<CR>", "goto fifth tab" },
        c     = { "<cmd>:tabclose<CR>", "close current tab" },
        o     = { "<cmd>:tabonly<CR>", "close all except current tab" },
    },
    ["?"] = {
        name  = "Help",
        b = { "<cmd>:CheatList<CR>", "browse cheatsheet.ch" },
        c = { "<cmd>:Cheatsheet<CR>", "open local cheatsheet" },
        t = { function() fzf.help_tags() end, "help tags" },
        ["/"] = {"<cmd>:Cheat<CR>", "search cheatsheet.ch" },
    },
    A = { -- TODO: temporary mappings for testing purpose
        name = "FzfLua",
        -- LSP
        a = { -- code analysis
            name = "LSP",
            a = { function() fzf.lsp_code_actions() end, "code actions" },
            i = { function() fzf.lsp_implementations() end, "implementations" },
            d = { function() fzf.lsp_definitions() end, "definitions" },
            D = { function() fzf.lsp_declarations() end, "declarations" },
            r = { function() fzf.lsp_references() end, "references" },
            s = { function() fzf.lsp_document_symbols() end, "document symbols" },
            S = { function() fzf.lsp_workspace_symbols() end, "workspace symbols" },
            t = { function() fzf.lsp_typedefs() end, "type definitions" },
            w = { function() fzf.lsp_document_diagnostics() end, "document diagnostics" },
            W = { function() fzf.lsp_workspace_diagnostics() end, "workspace diagnostics" },
        },
        -- Buffers & Files
        b = { function() fzf.buffers() end, "buffers" },
        f = { function() fzf.files() end, "files" },
        r = { function() fzf.oldfiles() end, "recent files" },
        q = { function() fzf.quickfix() end, "quickfix list" },
        l = { function() fzf.loclist() end, "location list" },
        -- Git
        g = {
            name = "git",
            b = { function() fzf.git_branches() end, "git branches" },
            c = { function() fzf.git_commits() end, "git commit log (project)" },
            C = { function() fzf.git_bcommits() end, "git commit log (buffer)" },
            f = { function() fzf.git_files() end, "git files" },
            s = { function() fzf.git_status() end, "git status" },
        },
        -- Misc
        k     = { function() fzf.keymaps() end, "key mappings" },
        m     = { function() fzf.man_pages() end, "man pages" },
        s     = { function() fzf.search_history() end, "search history" },
        t     = { function() fzf.btags() end, "buffer tags" },
        T     = { function() fzf.tags() end, "project tags" },
        x     = { function() fzf.commands() end, "neovim commands" },
        ["?"] = { function() fzf.help_tags() end, "help tags" },
        [":"] = { function() fzf.command_history() end, "command history" },
        ["`"] = { function() fzf.marks() end, "marks" },
        ['"'] = { function() fzf.registers() end, "registers" },
        ['='] = { function() fzf.spell_suggest() end, "spelling suggestions" },
        -- Search
        ["/"] = {
            name = "search",
            b = { function() fzf.grep_curbuf() end, "live grep current buffer" },
            g = { function() fzf.grep() end, "search pattern" },
            l = { function() fzf.grep_last() end, "search last pattern" },
            p = { function() fzf.live_grep() end, "live grep current project" },
            v = { function() fzf.grep_visual() end, "search visual selection" },
            w = { function() fzf.grep_cword() end, "search word under cursor" },
            W = { function() fzf.grep_cWORD() end, "search WORD under cursor" },
        },
    },
    B = {
        name  = "Buffer",
        b     = { "<cmd>:bfirst<CR>", "first buffer" },
        B     = { "<cmd>:blast<CR>", "last buffer" },
        --d     = { "<cmd>:Bdelete<CR>", "delete buffer" },
        -- bufferline plugin
        -- D     = { "<cmd>:BufferLineSortByDirectory<cr>", "sort BufferLines automatically by directory" },
        -- e     = { "<cmd>:BufferLineSortByExtension<cr>", "sort buffers automatically by extension" },
        -- h     = { "<cmd>:BufferLineCloseLeft<cr>", "close all buffers to the left" },
        -- j     = { "<cmd>:BufferLinePick<cr>", "jump to buffer" },
        -- l     = { "<cmd>:BufferLineCloseRight<cr>", "close all BufferLines to the right" },
        -- n     = { "<cmd>:BufferLineCycleNext<CR>", "next buffer" },
        -- p     = { "<cmd>:BufferLineCyclePrev<CR>", "previous buffer" },
        -- barbar plugin
        N     = { "<cmd>:BufferOrderByBufferNumber<cr>", "SORT by buffer number" },
        F     = { "<cmd>:BufferOrderByDirectory<cr>", "SORT by directory" },
        E     = { "<cmd>:BufferOrderByLanguage<cr>", "SORT by language" },
        W     = { "<cmd>:BufferOrderByWindowNumber<cr>", "SORT by window number" },
        k     = { "<cmd>:BufferPin<cr>", "toggle PIN" },
        j     = { "<cmd>:BufferPick<cr>", "PICK to buffer" },
        H     = { "<cmd>:BufferCloseBuffersLeft<cr>", "CLOSE all LEFT buffers" },
        L     = { "<cmd>:BufferCloseBuffersRight<cr>", "CLOSE all RIGHT buffers" },
        ["*"] = { "<cmd>:BufferCloseAllButPinned<cr>", "CLOSE all but PINNED" },
        n     = { "<cmd>:BufferNext<CR>", "NEXT buffer" },
        p     = { "<cmd>:BufferPrevious<CR>", "PREVIOUS buffer" },
        o     = { "<cmd>:BufferCloseAllButCurrent<CR>", "CLOSE all but CURRENT" },
        x     = { "<cmd>:BufferWipeout<CR>", "WIPEOUT buffer" },
        d     = { "<cmd>:BufferClose<CR>", "CLOSE buffer" },
        ["/"] = { "<cmd>:Buffers<CR>", "SEARCH buffer (fzf)" },
    },
    F = {
        name      = "FZF",
        a         = { "<cmd>:Ag<CR>", "Ag search" },
        b         = { "<cmd>:Buffers<CR>", "find buffers" },
        c         = { "<cmd>:Commits<CR>", "find Git commits" },
        C         = { "<cmd>:Colors<CR>", "find colors" },
        f         = { "<cmd>:Files<CR>", "find files" },
        h         = {
            name  = "history",
            ["h"] = { "<cmd>:History<CR>", "find file/buffer history" },
            [":"] = { "<cmd>:History:<CR>", "find command history" },
            ["/"] = { "<cmd>:History/<CR>", "find search history" },
        },
        H         = { "<cmd>:Helptags<CR>", "find Helptags" },
        m         = { "<cmd>:Maps<CR>", "find maps" },
        l         = { "<cmd>:Lines<CR>", "find lines" },
        w         = { "<cmd>:Windows<CR>", "find windows" },
        x         = { "<cmd>:Commands<CR>", "find commands" },
        ["/"]     = { "<cmd>:Rg<CR>", "Rg search" },
        ["`"]     = { "<cmd>:Marks<CR>", "fuzzy finder marks" },
    },
    G = {
        name  = "Git",
        b     = { function() fzf.git_branch() end, "list branches" },
        B     = { "<cmd>:Gblame<CR>", "blame" },
        c     = { function() fzf.git_commits() end, "list commits" },
        d     = { "<cmd>:Gvdiff<CR>", "diff" },
        D     = { "<cmd>:DiffviewOpen<CR>", "diff view" },
        f     = { "<cmd>:Gfetch<CR>", "fetch" },
        FP    = { "<cmd>:Gpush --force-with-lease<CR>", "push but force with lease" },
        l     = { "<cmd>:GV!<CR>", "log for current file" },
        L     = { "<cmd>:GV<CR>", "full log" },
        m     = { "<cmd>:Git checkout master<CR>", "checkout master" },
        o     = { "<cmd>:GCheckout<CR>", "checkout" },
        p     = { "<cmd>:Gpull<CR>", "pull" },
        P     = { "<cmd>:Gpush<CR>", "push" },
        r     = { "<cmd>:Grebase -i master<CR>", "rebase -i master" },
        s     = { function() fzf.git_status() end, "list changes" },
        S     = { function() tbuiltin.git_stash() end, "list stashes" },
        ["-"] = { "<cmd>:Git checkout -<CR>", "checkout -" },
    },
    H = {
        name = "git-gutter",
        p    = "preview hunk",
        q    = { "<cmd>Gqf<CR>", "show hunks in quickfix" },
        s    = "stage hunk",
        u    = "undo hunk",
    },
    M = {
        name       = "merge-tool",
        ["1"]      = { "<cmd>:MergetoolToggleLayout mr<CR>", "layout mr: MERGED-REMOTE" },
        ["2"]      = { "<cmd>:MergetoolToggleLayout ml<CR>", "layout ml: MERGED-LOCAL" },
        ["3"]      = { "<cmd>:MergetoolToggleLayout LmR<CR>", "layout LmR: LOCAL-MERGED-REMOTE" },
        ["4"]      = { "<cmd>:MergetoolToggleLayout mr,b<CR>", "layout mr,b: MERGED-REMOTE/BASE" },
        ["5"]      = { "<cmd>:MergetoolToggleLayout LBR<CR>", "layout LBR: LOCAL-BASE-REMOTE" },
        l          = { "<cmd>:MergetoolDiffExchangeLeft<CR>", "get/put from/to RIGHT" },
        h          = { "<cmd>:MergetoolDiffExchangeRight<CR>", "get/put from/to LEFT" },
        k          = { "<cmd>:MergetoolDiffExchangeDown<CR>", "get/put from/to UP" },
        j          = { "<cmd>:MergetoolDiffExchangeUp<CR>", "get/put from/to DOWN" },
        m          = { "<cmd>:MergetoolPreferLocal<CR>", "use MINE/LOCAL for MERGED" },
        q          = { "<cmd>:MergetoolStop<CR>", "quit merge-tool" },
        t          = { "<cmd>:MergetoolPreferRemote<CR>", "use THEIR/REMOTE for MERGED" },
        s          = { "<cmd>:MergetoolStart<CR>", "start merge-tool" },
        z          = { "<Plug>(MergetoolToggle)", "toggle merge-tool" },
    },
    S = {
        name  = "Search",
        a     = { "<cmd>:Ag<CR>", "text Ag" },
        b     = { "<cmd>:BLines<CR>", "current buffer" },
        B     = { "<cmd>:Buffers<CR>", "open buffers" },
        c     = { "<cmd>:Commits<CR>", "commits" },
        C     = { "<cmd>:BCommits<CR>", "buffer commits" },
        f     = { "<cmd>:Files<CR>", "files" },
        g     = { "<cmd>:GFiles<CR>", "git files" },
        G     = { "<cmd>:GFiles?<CR>", "modified git files" },
        h     = { "<cmd>:History<CR>", "file history" },
        H     = { "<cmd>:History:<CR>", "command history" },
        l     = { "<cmd>:Lines<CR>", "lines" },
        m     = { "<cmd>:Marks<CR>", "marks" },
        M     = { "<cmd>:Maps<CR>", "normal maps" },
        p     = { "<cmd>:Helptags<CR>", "help tags" },
        P     = { "<cmd>:Tags<CR>", "project tags" },
        s     = { "<cmd>:Snippets<CR>", "snippets" },
        S     = { "<cmd>:Colors<CR>", "color schemes" },
        t     = { "<cmd>:Rg<CR>", "text Rg" },
        T     = { "<cmd>:BTags<CR>", "buffer tags" },
        w     = { "<cmd>:Windows<CR>", "search windows" },
        y     = { "<cmd>:Filetypes<CR>", "file types" },
        z     = { "<cmd>:FZF<CR>", "FZF" },
        ["/"] = { "<cmd>:History/<CR>", "history" },
        [";"] = { "<cmd>:Commands<CR>", "commands" },
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
        d     = { "<C-W>c", "delete window" },
        h     = { "<C-W>h", "window left" },
        H     = { "<C-W>5<", "expand window left" },
        j     = { "<C-W>j", "window below" },
        J     = { "<cmd>:resize +5<CR>", "expand window below" },
        k     = { "<C-W>k", "window up" },
        K     = { "<cmd>:resize -5<CR>", "expand window up" },
        l     = { "<C-W>l", "window right" },
        L     = { "<C-W>5>", "expand window right" },
        s     = { "<C-W>s", "split window below" },
        v     = { "<C-W>v", "split window below" },
        w     = { "<C-W>w", "other window" },
        ["-"] = { "<C-W>s", "split window below" },
        ["|"] = { "<C-W>v", "split window right" },
        ["2"] = { "<C-W>v", "layout double columns" },
        ["="] = { "<C-W>=", "balance window" },
        ["?"] = { "<cmd>:Windows<CR>", "fzf window" },
    },
}, { prefix = "<leader>" })

-- vim.cmd 'highlight default link WhichKeyGroup Type'

return M

