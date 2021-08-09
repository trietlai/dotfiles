--Remap space as leader key
vim.api.nvim_set_keymap('', '<space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Needed when paste from clipboard to avoid formating
vim.pastetoggle = '<F3>'

-- Escaping
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true })

-- Center next Vim search matches
vim.api.nvim_set_keymap('n', 'n', 'nzz', { noremap = true })
vim.api.nvim_set_keymap('n', 'N', 'Nzz', { noremap = true })

-- some vim functions
vim.cmd([[
function! MyZoom()
    if winnr('$') > 1
        tab split
    elseif len(filter(map(range(tabpagenr('$')), 'tabpagebuflist(v:val + 1)'),
                \ 'index(v:val, '.bufnr('').') >= 0')) > 1
        tabclose
    endif
endfunction

function! MyTmuxSend(content, dest) range
    let dest = empty(a:dest) ? input('To which pane? ') : a:dest
    let tempfile = tempname()
    call writefile(split(a:content, "\n", 1), tempfile, 'b')
    call system(printf('tmux load-buffer -b vim-tmux %s \; paste-buffer -d -b vim-tmux -t %s',
                \ shellescape(tempfile), shellescape(dest)))
    call delete(tempfile)
endfunction

function! MyTmuxMap(key, dest)
    execute printf('nnoremap <silent> %s "tyy:call MyTmuxSend(@t, "%s")<cr>', a:key, a:dest)
    execute printf('xnoremap <silent> %s "ty:call MyTmuxSend(@t, "%s")<cr>gv', a:key, a:dest)
endfunction

call MyTmuxMap('<leader>Tt', '')
call MyTmuxMap('<leader>Th', '.left')
call MyTmuxMap('<leader>Tj', '.bottom')
call MyTmuxMap('<leader>Tk', '.top')
call MyTmuxMap('<leader>Tl', '.right')
call MyTmuxMap('<leader>Ty', '.top-left')
call MyTmuxMap('<leader>To', '.top-right')
call MyTmuxMap('<leader>Tn', '.bottom-left')
call MyTmuxMap('<leader>T.', '.bottom-right')
]])

local wk = require("which-key")
wk.setup {
    key_labels = {
        ["<space>"] = "SPC",
        ["<CR>"]    = "RET",
        ["<Tab>"]   = "TAB",
        ["<S-Tab>"] = "S-TAB",
    },
}
-- basic mappings
-- normal mode
wk.register({
    -- start with 'g'
    g = {
        a     = {"<Plug>(EasyAlign)",    "Easy align"},
        b     = {"<cmd>BufferLinePick<CR>", "pick buffer"},
        c     = {"<Plug>Commentary",     "Commentary"},
        cc    = {"<Plug>CommentaryLine", "Commentary line"},
        d     = {"<Cmd>lua vim.lsp.buf.definition()<CR>",       "goto definition"},
        D     = {"<Cmd>lua vim.lsp.buf.declaration()<CR>",      "goto declaration"},
        i     = {"<cmd>lua vim.lsp.buf.implementation()<CR>",   "goto implementation"},
        k     = {"<cmd>lua vim.lsp.buf.signature_help()<CR>",   "signature help"},
        r     = {"<cmd>lua vim.lsp.buf.references()<CR>",       "display references"},
        T     = {"<cmd>lua vim.lsp.buf.type_definition()<CR>",  "type definition"},
        U     = {"viwU<Esc>", "uppercase word"},
        ["."] = {"<cmd>:normal! `[v`]<CR><LEFT>", "Last inserted text"},
    },

    K = {"<Cmd>lua vim.lsp.buf.hover()<CR>", "display info of symbol under cursor"},
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
        d    = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Move to the next diagnostic"},
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
        d    = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Move to the previous diagnostic"},
        l    = "previous location-list",
        L    = "first location-list",
        q    = "previous quickfix",
        Q    = "first quickfix",
        t    = "previous tab",
        T    = "first tab",
    },

    ["+"] = "expand region",
    ["_"] = "shrink region",

    -- LSP

    -- <tab> / <s-tab> | Circular windows navigation
    ["<Tab>"]   = {"<C-w>w", "next window"},
    ["<S-Tab>"] = {"<C-w>W", "previous window"},

    ["<F4>"]    = {"<cmd>:NvimTreeToggle<CR>", "toggle NvimTree"},
    -- ["<F5>"]    = {"<cmd>:NERDTreeToggle<CR>", "toggle NerdTree"},
    ["<F12>"]   = {"<cmd>:lua require('FTerm').toggle()<CR>", "toggle terminal"},

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
    ["<F12>"]   = {"<cmd>:lua require('FTerm').toggle()<CR>", "toggle terminal"},
}, { mode = "t" })

-- leader
-- single
wk.register({
    b = {"<cmd>:Buffers<CR>", "list buffers"},
    c = {"<cmd>:cclose<BAR>lclose<CR>", "close quickfix/location window"},
    d = {'"_d', "delete to black-hole register"},
    g = {"<cmd>:Git<CR>", "Git status"},
    H = {"<cmd>:History<CR>", "search history"},
    m = {"<cmd>:Maps<CR>", "show keybindings"},
    p = {'"yp', "paste from 'y' register"},
    P = {'"yP', "paste from 'y' register"},
    r = {"<cmd>:Files<CR>", "recent files"},
    w = {"<cmd>:Windows<CR>", "find windows"},
    x = {'"_x', "delete char to black-hole register"},
    y = {'"yy', "copy to 'y' register"},
    z = {"<cmd>:call MyZoom()<CR>", "zoom: window <-> tab"},

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
    ["/"] = {"<cmd>:Rg<CR>", "search text with Rg"},

    ["<Tab>"]   = {"<cmd>:bnext<CR>", "next buffer"},
    ["<S-Tab>"] = {"<cmd>:bprevious<CR>", "previous buffer"},
    ["?"]       = {"<cmd>:Helptags<CR>", "help tags"},
    [":"]       = {"<cmd>:History:<CR>", "command history"},
    ["`"]       = {"<cmd>:Marks<CR>", "marks"},
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
    h = { -- TODO: remap to 'H'
        name = "git-gutter",
        p    = "preview hunk",
        q    = {"<cmd>Gqf<CR>", "show hunks in quickfix"},
        s    = "stage hunk",
        u    = "undo hunk",
    },
    B = {
        name  = "Buffer",
        b     = {"<cmd>:bfirst<CR>", "first buffer"},
        B     = {"<cmd>:blast<CR>", "last buffer"},
        d     = {"<cmd>:bdelete<CR>", "delete buffer"},
        D     = {"<cmd>BufferOrderByDirectory<cr>", "sort BufferLines automatically by directory"},
        h     = {"<cmd>BufferCloseBuffersLeft<cr>", "close all buffers to the left"},
        j     = {"<cmd>BufferPick<cr>", "jump to buffer" },
        l     = {"<cmd>BufferCloseBuffersRight<cr>", "close all BufferLines to the right"},
        L     = {"<cmd>BufferOrderByLanguage<cr>", "sort BufferLines automatically by language"},
        n     = {"<cmd>:bnext<CR>", "next buffer"},
        o     = {"<cmd>BufferCloseAllButCurrent<cr>", "close all but current buffer"},
        p     = {"<cmd>:bprevious<CR>", "previous buffer"},
        x     = {"<cmd>BufferWipeout<cr>", "wipeout buffer" },
        ["/"] = {"<cmd>:Buffers<CR>", "search buffer (fzf)"},

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
        b     = {"<cmd>:Gblame<CR>", "blame"},
        c     = {"<cmd>:Gcommit<CR>", "commit"},
        C     = {"<cmd>:Gcommit -n<CR>", "commit but ignore hooks"},
        d     = {"<cmd>:Gvdiff<CR>", "diff"},
        f     = {"<cmd>:Gfetch<CR>", "fetch"},
        FP    = {"<cmd>:Gpush --force-with-lease<CR>", "push but force with lease"},
        l     = {"<cmd>:GV!<CR>", "log for current file"},
        L     = {"<cmd>:GV<CR>", "full log"},
        m     = {"<cmd>:Git checkout master<CR>", "checkout master"},
        o     = {"<cmd>:GCheckout<CR>", "checkout"},
        p     = {"<cmd>:Gpull<CR>", "pull"},
        P     = {"<cmd>:Gpush<CR>", "push"},
        r     = {"<cmd>:Grebase -i master<CR>", "rebase -i master"},
        s     = {"<cmd>:Gstatus<CR>", "status"},
        ["-"] = {"<cmd>:Git checkout -<CR>", "checkout -"},
    },
    L = {
        name = "Language",
        -- LSP
        a    = {"<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action"},
        d    = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "type definition"},
        D    = {"<cmd>Telescope lsp_document_diagnostics<cr>", "Document Diagnostics"},
        e    = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "show line diagnostics"},
        f    = {"<cmd>lua vim.lsp.buf.formatting()<cr>", "Format"},
        i    = {"<cmd>LspInfo<cr>", "LSP info"},
        j    = {"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>", "Next Diagnostic"},
        k    = {"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>", "Prev Diagnostic"},
        p    = {
            name = "Peek",
            d    = {"<cmd>lua require('lsp.peek').Peek('definition')<cr>", "Definition"},
            t    = {"<cmd>lua require('lsp.peek').Peek('typeDefinition')<cr>", "Type Definition"},
            i    = {"<cmd>lua require('lsp.peek').Peek('implementation')<cr>", "Implementation"},
        },
        q    = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "set location-list"},
        r    = {"<cmd>lua vim.lsp.buf.rename()<CR>", "rename"},
        s    = {"<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S    = {"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace Symbols"},
        w    = {
            name  = "workspace",
            d     = {"<cmd>Telescope lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
            a     = {"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "add workspace folder"},
            r     = {"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "remove workspace folder"},
            l     = {"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "list workspace folders"},
        },
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
    T = { -- description only
        name  = "Tmux",
        h     = "send to left pane",
        j     = "send to bottom pane",
        k     = "send to top pane",
        l     = "send to right pane",
        n     = "send to bottom-left pane",
        o     = "send to top-right pane",
        t     = "send to pane?",
        y     = "send to top-left pane",
        ["."] = "send to bottom-right pane",
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

