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
	-- your configuration comes here
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
    U           = {"<C-r>", "redo"},
    Y           = {"y$",    "yank until the EOL"},
    -- start with 'g'
    ga          = {"<Plug>(EasyAlign)",    "Easy align"},
    gc          = {"<Plug>Commentary",     "Commentary"},
    gcc         = {"<Plug>CommentaryLine", "Commentary line"},
    ["g."]      = {"<cmd>:normal! `[v`]<CR><LEFT>", "Last inserted text"},
    -- LSP
    ["gD"]      = {"<Cmd>lua vim.lsp.buf.declaration()<CR>",      "goto declaration"},
    ["gd"]      = {"<Cmd>lua vim.lsp.buf.definition()<CR>",       "goto definition"},
    ["gT"]      = {"<cmd>lua vim.lsp.buf.type_definition()<CR>",  "type definition"},
    ["K"]       = {"<Cmd>lua vim.lsp.buf.hover()<CR>",            "display info of symbol under cursor"},
    ["gi"]      = {"<cmd>lua vim.lsp.buf.implementation()<CR>",   "goto implementation"},
    ["gr"]      = {"<cmd>lua vim.lsp.buf.references()<CR>",       "display references"},
    ["[d"]      = {"<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", "Move to the previous diagnostic"},
    ["]d"]      = {"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", "Move to the next diagnostic"},
    ["<C-k>"]   = {"<cmd>lua vim.lsp.buf.signature_help()<CR>",   "signature help"},

    -- <tab> / <s-tab> | Circular windows navigation
    ["<Tab>"]   = {"<C-w>w", "next window"},
    ["<S-Tab>"] = {"<C-w>W", "previous window"},

    ["<F4>"]    = {"<cmd>:NvimTreeToggle<CR>", "toggle NvimTree"},
    ["<F5>"]    = {"<cmd>:NERDTreeToggle<CR>", "toggle NerdTree"},

    ["]q"]      = {"<cmd>:cnext<CR>zz", "next quickfix"},
    ["[q"]      = {"<cmd>:cprev<CR>zz", "previous quickfix"},
    ["]l"]      = {"<cmd>:lnext<CR>zz", "next location-list"},
    ["[l"]      = {"<cmd>:lprev<CR>zz", "previous location-list"},
    ["]b"]      = {"<cmd>:bnext<CR>",   "next buffer"},
    ["[b"]      = {"<cmd>:bprev<CR>",   "previous buffer"},
    ["]t"]      = {"<cmd>:tabn<CR>",    "next tab"},
    ["[t"]      = {"<cmd>:tabp<CR>",    "previous tab"},

    -- Easier split navigations
    ["<C-j>"]   = {"<C-w><C-j>", "move to window below (horizontal split)"},
    ["<C-k>"]   = {"<C-w><C-k>", "move to window above (horizontal split)"},
    ["<C-l>"]   = {"<C-w><C-l>", "move to right window (vertical split)"},
    ["<C-h>"]   = {"<C-w><C-h>", "move to left window (vertical split)"},

    ["<C-u>"]   = {"viwU<Esc>", "uppercase word"},
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

	["<C-h>"]     = {"<C-o>h",     "move cursor left"},
	["<C-l>"]     = {"<C-o>a",     "move cursor right"},
	["<C-j>"]     = {"<C-o>j",     "move cursor down"},
	["<C-k>"]     = {"<C-o>k",     "move cursor up"},
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

-- leader
-- single
wk.register({
    b = {"<cmd>:Buffers<CR>", "list buffers"},
    c = {"<cmd>:cclose<BAR>lclose<CR>", "close quickfix/location window"},
    d = {'"_d', "delete to black-hole register"},
    f = {"<cmd>:Files<CR>", "search files"},
    h = {"<cmd>:History<CR>", "search history"},
    m = {"<cmd>:Maps<CR>", "search mapping"},
    p = {'"yp', "paste from 'y' register"},
    P = {'"yP', "paste from 'y' register"},
    r = {"<cmd>:RnvimrToggle<CR>", "toggle Ranger Vim"},
    x = {'"_x', "delete char to black-hole register"},
    y = {'"yy', "copy to 'y' register"},
    z = {"<cmd>:call MyZoom()<CR>", "zoom: window <-> tab"},

    ["-"] = {"<C-w>s", "split window below"},
    ["|"] = {"<C-w>v", "split window right"},
    ["/"] = {"<cmd>:Rg<CR>", "search text with Rg"},

    ["<Tab>"]   = {"<cmd>:bnext<CR>", "next buffer"},
    ["<S-Tab>"] = {"<cmd>:bprevious<CR>", "previous buffer"},
    ["?"]       = {"<cmd>:Maps<CR>", "show keybindings"},
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
    B = {
        name  = "Buffer",
        d     = {"<cmd>:bdelete<CR>", "delete buffer"},
        f     = {"<cmd>:bfirst<CR>", "first buffer"},
        l     = {"<cmd>:blast<CR>", "last buffer"},
        n     = {"<cmd>:bnext<CR>", "next buffer"},
        p     = {"<cmd>:bprevious<CR>", "previous buffer"},
        ["?"] = {"<cmd>:Buffers<CR>", "fzf buffer"}
    },
    F = {
        name   = "FZF",
        f      = {"<cmd>:Files<CR>", "fuzzy finder files"},
        b      = {"<cmd>:Buffers<CR>", "fuzzy finder buffers"},
        c      = {"<cmd>:Commits<CR>", "fuzzy finder Git commits"},
        C      = {"<cmd>:Colors<CR>", "fuzzy finder colors"},
        x      = {"<cmd>:Commands<CR>", "fuzzy finder commands"},
        m      = {"<cmd>:Maps<CR>", "fuzzy finder maps"},
        w      = {"<cmd>:Windows<CR>", "fuzzy finder windows"},
        H      = {"<cmd>:Helptags<CR>", "fuzzy finder Helptags"},
        l      = {"<cmd>:Lines<CR>", "fuzzy finder lines"},
        ["hh"] = {"<cmd>:History<CR>", "fuzzy finder file/buffer history"},
        ["h:"] = {"<cmd>:History:<CR>", "fuzzy finder command history"},
        ["h/"] = {"<cmd>:History/<CR>", "fuzzy finder search history"},
        ["ag"] = {"<cmd>:Ag <C-R><C-W><CR>", "Ag search word at point"},
        ["AG"] = {"<cmd>:Ag <C-R><C-A><CR>", "Ag search line at point"},
        ['a"'] = {'<cmd>:Ag <C-R>"<CR>', "Ag search from register"},
        ["rg"] = {"<cmd>:Rg <C-R><C-W><CR>", "Rg search word at point"},
        ["`"]  = {"<cmd>:Marks<CR>", "fuzzy finder marks"},
    },
    G = {
        name  = "Git",
        s     = {"<cmd>:Gstatus<CR>", "status"},
        o     = {"<cmd>:GCheckout<CR>", "checkout"},
        c     = {"<cmd>:Gcommit<CR>", "commit"},
        C     = {"<cmd>:Gcommit -n<CR>", "commit but ignore hooks"},
        P     = {"<cmd>:Gpush<CR>", "push"},
        FP    = {"<cmd>:Gpush --force-with-lease<CR>", "push but force with lease"},
        p     = {"<cmd>:Gpull<CR>", "pull"},
        f     = {"<cmd>:Gfetch<CR>", "fetch"},
        l     = {"<cmd>:GV!<CR>", "log for current file"},
        L     = {"<cmd>:GV<CR>", "full log"},
        d     = {"<cmd>:Gvdiff<CR>", "diff"},
        b     = {"<cmd>:Gblame<CR>", "blame"},
        m     = {"<cmd>:Git checkout master<CR>", "checkout master"},
        rm    = {"<cmd>:Grebase -i master<CR>", "rebase -i master"},
        ["-"] = {"<cmd>:Git checkout -<CR>", "checkout -"},
    },
    L = {
        name   = "Language",
        -- LSP: see above
        wa = {"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", "add workspace folder"},
        wr = {"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", "remove workspace folder"},
        wl = {"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "list workspace folders"},
        D  = {"<cmd>lua vim.lsp.buf.type_definition()<CR>", "type definition"},
        rn = {"<cmd>lua vim.lsp.buf.rename()<CR>", "rename"},
        ca = {"<cmd>lua vim.lsp.buf.code_action()<CR>", "code action"},
        e  = {"<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", "show line diagnostics"},
        q  = {"<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "set location-list"},
        f  = {"<cmd>lua vim.lsp.buf.formatting()<CR>", "formatting"},
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
        t     = "send to pane?",
        h     = "send to left pane",
        j     = "send to bottom pane",
        k     = "send to top pane",
        l     = "send to right pane",
        y     = "send to top-left pane",
        o     = "send to top-right pane",
        n     = "send to bottom-left pane",
        ["."] = "send to bottom-right pane",
    },
    W = {
        name  = "Windows" ,
        w = {"<C-W>w", "other window"},
        d = {"<C-W>c", "delete window"},
        h = {"<C-W>h", "window left"},
        j = {"<C-W>j", "window below"},
        l = {"<C-W>l", "window right"},
        k = {"<C-W>k", "window up"},
        H = {"<C-W>5<", "expand window left"},
        J = {"<cmd>:resize +5<CR>", "expand window below"},
        L = {"<C-W>5>", "expand window right"},
        K = {"<cmd>:resize -5<CR>", "expand window up"},
        s = {"<C-W>s", "split window below"},
        v = {"<C-W>v", "split window below"},

        ["-"] = {"<C-W>s", "split window below"},
        ["|"] = {"<C-W>v", "split window right"},
        ["2"] = {"<C-W>v", "layout double columns"},
        ["="] = {"<C-W>=", "balance window"},
        ["?"] = {"<cmd>:Windows<CR>", "fzf window"},
    },
}, { prefix = "<leader>" })

-- vim.cmd 'highlight default link WhichKeyGroup Type'

