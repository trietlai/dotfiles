-- Global
_G.MyUtils = {}

-- Disable some unused built-in Neovim plugins
--vim.g.loaded_man            = false
--vim.g.loaded_gzip           = false
vim.g.loaded_netrwPlugin    = false
--vim.g.loaded_tarPlugin      = false
--vim.g.loaded_zipPlugin      = false
--vim.g.loaded_2html_plugin   = false
vim.g.loaded_remote_plugins = false

-- font for neovide
--vim.opt.guifont = "JetBrainsMono Nerd Font Mono:h12"
--vim.opt.guifont = "DaddyTimeMono NF:h12"
--vim.opt.guifont = "VictorMono Nerd Font Mono:h12"
vim.opt.guifont = "FiraCode Nerd Font Mono:h12"
vim.opt.hidden  = true       -- Required to keep multiple buffers open multiple buffers
vim.opt.wrap    = false      -- Display long lines as just one line
vim.opt.ruler   = true       -- Show the cursor position all the time
vim.cmd('set iskeyword+=-')  -- treat dash separated words as a word text object"
vim.opt.splitbelow   = true  -- Horizontal splits will automatically be below
vim.opt.splitright   = true  -- Vertical splits will automatically be to the right
vim.opt.conceallevel = 0     -- So that I can see `` in markdown files
vim.opt.smarttab     = true  -- Makes tabbing smarter will realize you have 2 vs 4
vim.opt.expandtab    = true  -- Converts tabs to spaces
vim.opt.smartindent  = true  -- Makes indenting smart
vim.opt.autoindent   = true  -- Good auto indent
vim.opt.laststatus   = 2     -- Always display the status line
vim.opt.showtabline  = 2     -- Always show tabs
vim.opt.showmode     = false -- We don't need to see things like -- INSERT -- anymore
vim.opt.backup       = false -- This is recommended by coc
vim.opt.writebackup  = false -- This is recommended by coc
vim.opt.updatetime   = 300   -- Faster completion
vim.opt.timeoutlen   = 500   -- By default timeoutlen is 1000 ms
vim.cmd('set formatoptions-=cro') --  Stop newline continuation of comments
vim.opt.clipboard = 'unnamedplus'
vim.opt.linespace = 0        --  No extra spaces between rows
vim.opt.incsearch = true     --  find as you type search
vim.opt.wildmenu  = true     --  show list instead of just completing
vim.cmd('set wildmode=list:longest,full')  --  command <Tab> completion
vim.cmd('set whichwrap=b,s,h,l,<,>,[,]')   --  backspace and cursor keys wrap to
vim.opt.scrolljump = 5       --  lines to scroll when cursor leaves screen
vim.cmd('syntax on')         --  enable syntax highlighting
vim.opt.autoread   = true
vim.opt.dictionary = '/usr/share/dict/words'
vim.opt.textwidth  = 0
vim.opt.fillchars  = { vert = ' ' }
vim.opt.scrolloff  = 3       --  minimum lines to keep above and below cursor
vim.opt.mouse      = 'a'     --  automatically enable mouse usage
vim.opt.backupcopy = 'yes'
vim.opt.undolevels = 1000
vim.opt.shortmess:append { c = true, S = true }
vim.opt.wrapscan     = true
vim.opt.showcmd      = true
vim.opt.showmatch    = true  --  show matching brackets/parenthesis
vim.opt.ignorecase   = true  --  case insensitive search
vim.opt.hlsearch     = true  --  highlight matching search strings
vim.opt.smartcase    = true  --  case sensitive when upper cases present
vim.opt.errorbells   = false
vim.opt.joinspaces   = false
vim.opt.title        = true
vim.opt.lazyredraw   = true
vim.opt.encoding     = 'UTF-8' --  the encoding displayed
vim.opt.showbreak    = "↪\\"
vim.opt.fileencoding = 'UTF-8' --  the encoding written to file
vim.opt.completeopt  = 'menuone,noselect'
vim.opt.listchars    = { tab = "→\\ ", trail = "·", precedes = "←", extends = "→",eol = "↲", nbsp = "␣" }
-- Buffer
vim.opt.fileformat  = 'unix'
vim.opt.tabstop     = 4        --  Insert 4 spaces for a tab
vim.opt.spelllang   = 'en'
vim.opt.softtabstop = 4        --  <Backspace> just once instead of 4
vim.opt.swapfile    = false
vim.opt.undofile    = false
vim.opt.shiftwidth  = 4        --  when indenting with '>', use 4 spaces width
-- Window
vim.opt.number         = true  --  show line numbers
vim.opt.colorcolumn    = "+1"
vim.opt.foldmethod     = 'indent'
vim.opt.foldlevel      = 99
vim.opt.list           = false
vim.opt.foldnestmax    = 10
vim.opt.signcolumn     = 'yes'
vim.opt.relativenumber = true
vim.opt.foldenable     = true  --  auto fold code
vim.opt.cursorline     = true  --  Highlight the Current Line

function MyUtils.goto_last_pos()
    local last_pos = vim.fn.line("'\"")
    if last_pos > 0 and last_pos <= vim.fn.line("$") then
        vim.api.nvim_win_set_cursor(0, {last_pos, 0})
    end
end
vim.cmd[[autocmd BufReadPost * lua MyUtils.goto_last_pos()]]

vim.cmd 'au TextYankPost * silent! lua vim.highlight.on_yank()'

