" vim: set foldmethod=marker foldlevel=0 nomodeline:
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc

"lua require"colorizer".setup()

" ---------------------------------------------------------------
" LSP Config {{{
" ---------------------------------------------------------------

lua << EOF
-- python
require("lspconfig").pyright.setup{}
-- bash
require("lspconfig").bashls.setup{}

local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gT", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<Leader>Lwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>Lwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>Lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<Leader>LD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>Lrn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<Leader>Lca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<Leader>Le", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "<Leader>Lq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<Leader>Lf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { "pyright", "rust_analyzer", "tsserver" }
local servers = { "pyright", "bashls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" LSP Config }}}

" ---------------------------------------------------------------
" Which Key {{{
" ---------------------------------------------------------------

lua << EOF
  local wk = require("which-key")
  wk.setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
    -- basic mappings
    -- normal mode
    wk.register({
    ["ga"]      = "Easy align",
    ["gc"]      = "Commentary",
    ["gcc"]     = "Commentary line",
    ["n"]       = "next search match",
    ["N"]       = "previous search match",
    ["U"]       = "redo",
    ["Y"]       = "yank till end of line",
    ["<TAB>"]   = "next window",
    ["<S-TAB>"] = "previous window",
    ["<C-c>"]   = "Escape",
    ["<C-s>"]   = "save",
    ["<C-u>"]   = "uppercase",
    ["g."]      = "Last inserted text",
    ["]q"]      = "next quickfix",
    ["[q"]      = "previous quickfix",
    ["]l"]      = "next location-list",
    ["[l"]      = "previous location-list",
    ["]b"]      = "next buffer",
    ["[b"]      = "previous buffer",
    ["]t"]      = "next tab",
    ["[t"]      = "previous tab",
    ["<C-j>"]   = "move to window below (horizontal split)",
    ["<C-k>"]   = "move to window above (horizontal split)",
    ["<C-l>"]   = "move to right window (vertical split)",
    ["<C-h>"]   = "move to left window (vertical split)",
    -- LSP: see above
    ["gD"]      = "goto declaration",
    ["gd"]      = "goto definition",
    ["gT"]      = "type definition",
    ["K"]       = "display info of symbol under cursor",
    ["gi"]      = "goto implementation",
    ["gr"]      = "display references",
    ["g."]      = "goto last inserted text",
    ["[d"]      = "Move to the previous diagnostic",
    ["]d"]      = "Move to the next diagnostic",
    ["<C-k>"]   = "signature help",
    })

    -- insert mode
    wk.register({
    ["<C-u>"]     = "uppercase",
    ["<C-]>"]     = "complete using tags",
    ["<C-Space>"] = "language aware omni-completion",
    ["<C-b>"]     = "keyword completion from the current buffer",
    ["<C-d>"]     = "dictionary completion",
    ["<C-f>"]     = "file path completion",
    ["<C-l>"]     = "whole-of-line completion",
    ["<C-h>"]     = "move cursor left",
    ["<C-l>"]     = "move cursor right",
    ["<C-j>"]     = "move cursor down",
    ["<C-k>"]     = "move cursor up",
    ["<C-^>"]     = "last buffer?",
    -- Readline-style mappings for insert mode
    ["<C-a>"]     = "begin of line",
    ["<C-e>"]     = "end of line",
    ["<A-b>"]     = "back to begin of word",
    ["<A-f>"]     = "forward to begin of word",
    ["<A-BS>"]    = "delete to begin of word",
    ["<A-d>"]     = "delete to end of word",
    }, { mode = "i" })

    wk.register({
    -- Readline-style mappings for command mode
    ["<C-a>"]  = "begin of line",
    ["<C-b>"]  = "left one character",
    ["<C-e>"]  = "end of line",
    ["<A-b>"]  = "back to begin of word",
    ["<A-f>"]  = "forward to begin of word",
    ["<A-BS>"] = "delete to begin of word",
    ["<A-d>"]  = "delete to end of word",
    }, { mode = "c" })

    -- leader
    -- single
    wk.register({
    c           = "close quickfix/location window",
    d           = "delete to black-hole register",
    x           = "delete char to black-hole register",
    y           = "copy to 'y' register",
    p           = "paste from 'y' register",
    P           = "paste from 'y' register",
    ga          = "live easy align",
    t           = "toggle background",
    z           = "zoom: window <-> tab",
    ["1"]       = "goto first tab",
    ["2"]       = "goto second tab",
    ["3"]       = "goto third tab",
    ["4"]       = "goto fourth tab",
    ["5"]       = "goto fifth tab",
    ["<TAB>"]   = "next buffer",
    ["<S-TAB>"] = "previous buffer",
    -- TODO: remove cmd
    ["?"] = { "<cmd>Maps<CR>", "show keybindings" },
    }, { prefix = "<leader>" })

    -- group
    wk.register({
    ["<Leader>"] = {
        name  = "tab",
        -- TODO: remove cmd
        ["1"] = { "<cmd>1gt<CR>", "goto first tab" },
        ["2"] = { "<cmd>2gt<CR>", "goto second tab" },
        ["3"] = { "<cmd>3gt<CR>", "goto third tab" },
        ["4"] = { "<cmd>4gt<CR>", "goto fourth tab" },
        ["5"] = { "<cmd>5gt<CR>", "goto fifth tab" },
        c     = { "<cmd>tabclose<CR>", "close current tab" },
        o     = { "<cmd>:tabonly<CR>", "close all except current tab" },
    },
    B = {
        name  = "Buffer",
        d     = "delete buffer",
        f     = "first buffer",
        l     = "last buffer",
        n     = "next buffer",
        p     = "previous buffer",
        ["?"] = "fzf buffer"
        },
    F = {
        name   = "FZF",
        f      = "fuzzy finder files",
        b      = "fuzzy finder buffers",
        c      = "fuzzy finder Git commits",
        C      = "fuzzy finder colors",
        x      = "fuzzy finder commands",
        m      = "fuzzy finder maps",
        w      = "fuzzy finder windows",
        H      = "fuzzy finder Helptags",
        l      = "fuzzy finder lines",
        ["hh"] = "fuzzy finder file/buffer history",
        ["h:"] = "fuzzy finder command history",
        ["h/"] = "fuzzy finder search history",
        ["ag"] = "Ag search word at point",
        ["AG"] = "Ag search line at point",
        ['a"'] = "Ag search from register",
        ["rg"] = "Rg search word at point",
        ["`"]  = "fuzzy finder marks",
        },
    G = {
        name  = "Git",
        s     = "status",
        o     = "checkout",
        c     = "commit",
        C     = "commit but ignore hooks",
        P     = "push",
        FP    = "push but force with lease",
        p     = "pull",
        f     = "fetch",
        l     = "log for current file",
        L     = "full log",
        d     = "diff",
        b     = "blame",
        m     = "checkout master",
        rm    = "rebase -i master",
        ["-"] = "checkout -",
        },
    L = {
        name   = "Language",
        -- LSP: see above
        ["wa"] = "add workspace folder",
        ["wr"] = "remove workspace folder",
        ["wl"] = "list workspace folders",
        ["D"]  = "type definition",
        ["rn"] = "rename",
        ["ca"] = "code action",
        ["e"]  = "show line diagnostics",
        ["q"]  = "set location-list",
        ["f"]  = "formatting",
        },
    S = {
        name  = "Search",
        a     = "text Ag",
        b     = "current buffer",
        B     = "open buffers",
        c     = "commits",
        C     = "buffer commits",
        f     = "files",
        g     = "git files",
        G     = "modified git files",
        h     = "file history",
        H     = "command history",
        l     = "lines",
        m     = "marks",
        M     = "normal maps",
        p     = "help tags",
        P     = "project tags",
        s     = "snippets",
        S     = "color schemes",
        t     = "text Rg",
        T     = "buffer tags",
        w     = "search windows",
        y     = "file types",
        z     = "FZF",
        ["/"] = "history",
        [";"] = "commands",
        },
    T = {
        name  = "tmux",
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
    }, { prefix = "<leader>" })
EOF

highlight default link WhichKeyGroup Type

" Which Key }}}

