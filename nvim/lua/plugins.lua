-- vim.cmd [[packadd packer.nvim]]
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

-- require('packer').init({display = {non_interactive = true}})
require('packer').init({display = {auto_clean = false}})

return require('packer').startup(function(use)
    use {
        'wbthomason/packer.nvim',
    }

    -- LSP
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require 'plugins/lspconfig'
        end
    }

    -- add symbols for LSP kinds e.g. method, class, etc.
    use {
        'onsails/lspkind-nvim',
        config = function()
            require 'plugins/lspkind'
        end
    }

    -- LSP for rust
    use {
        'simrat39/rust-tools.nvim',
        after = 'nvim-lspconfig',
        requires = {
            'neovim/nvim-lspconfig',
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'mfussenegger/nvim-dap'
        },
        config = function()
            require 'plugins/rust-tools'
        end
    }

    -- automatically change to project root folder
    use { 'ygm2/rooter.nvim', event = 'BufEnter' }

    -- tree-sitter parser
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require 'plugins/treesitter'
        end
    }

    -- Rainbow parentheses for neovim using tree-sitter
    use {
        'p00f/nvim-ts-rainbow',
        requires = 'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        config = function()
            require 'plugins/nvim-ts-rainbow'
        end
    }

    -- changes the commentstring setting
    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        requires = 'nvim-treesitter/nvim-treesitter',
    }

    -- shows the context (e.g. function name) of the currently visible buffer contents
    use {
        'romgrk/nvim-treesitter-context',
        requires = 'nvim-treesitter/nvim-treesitter',
    }

    -- Autocomplete
    use {
        'hrsh7th/nvim-compe',
        event = 'InsertEnter',
        config = function()
            require 'plugins/compe'
        end,
    }

    -- extends vim's % key to language-specific words
    use {
        'andymass/vim-matchup',
        event = 'CursorMoved'
    }

    -- Files/directories tree
    use {
        'preservim/NERDTree',
        cmd = 'NERDTreeToggle',
        requires = {
            'Xuyuanp/nerdtree-git-plugin',
            'tiagofumo/vim-nerdtree-syntax-highlight',
            'PhilRunninger/nerdtree-visual-selection'
        }
    }
    -- alternative
    use {
        'kyazdani42/nvim-tree.lua',
        cmd = 'NvimTreeToggle',
        config = function()
            require 'plugins/nvimtree'
        end
    }
    use {
        'kevinhwang91/rnvimr',
        cmd = 'RnvimrToggle'
    }

    -- key mapping
    use {
        'folke/which-key.nvim',
    }

    -- FZF
    use {
        'junegunn/fzf',
        event = 'VimEnter',
        requires = {
            'junegunn/fzf.vim',
            'stsewd/fzf-checkout.vim'
        }
    }

    -- Syntax
    use { 'habamax/vim-asciidoctor', ft = { 'adoc' } }

    use { 'honza/dockerfile.vim', ft = { 'dockerfile' } }

    use { 'martinda/Jenkinsfile-vim-syntax', ft = { 'jenkinsfile' } }

    use { 'chr4/nginx.vim', ft = { 'conf' } }
    use { 'zigford/vim-powershell', ft = { 'ps1' } }

    -- Tim Pope
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-endwise'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    -- Git
    use { 'tpope/vim-fugitive', cmd = { 'Git' } }
    use {
        'airblade/vim-gitgutter',
        even = 'BufEnter',
        config = function()
            require 'plugins/gitgutter'
        end
    }
    -- similar to magit
    -- use {
    --     'TimUntersberger/neogit',
    --     requires = 'nvim-lua/plenary.nvim',
    --     config = function()
    --         require 'plugins/neogit'
    --     end
    -- }

    -- git commit log browser
    use { 'junegunn/gv.vim', cmd = 'GV' }

    use {
        'sindrets/diffview.nvim',
        cmd = 'DiffviewOpen',
        config = function()
            require 'plugins/diffview'
        end
    }

    -- use 'lambdalisue/gina.vim'

    -- indent & align
    use {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        config = function()
            require 'plugins/indent-blankline'
        end
    }
    use 'junegunn/vim-easy-align'

    -- Move & Search & replace
    -- search & highlight
    use {
        'kevinhwang91/nvim-hlslens',
        event = 'BufEnter',
        config = function()
            require 'plugins/hlslens'
        end
    }

    -- motion/jump plugin
    use {
        'ggandor/lightspeed.nvim',
        config = function()
            require 'plugins/lightspeed'
        end
    }
    -- alternatives motion/jump plugins
    -- use 'easymotion/vim-easymotion'
    -- use 'rhysd/clever-f.vim'

    -- Smooth scrolling for window movement commands
    use {
        'karb94/neoscroll.nvim',
        config = function()
            require 'plugins/neoscroll'
        end
    }

    -- displays interactive scrollbars
    use 'dstein64/nvim-scrollview'

    -- Press + to expand the visual selection and _ to shrink it.
    use 'terryma/vim-expand-region'

    use 'chaoren/vim-wordmotion'

    -- copy & paste
    use 'machakann/vim-highlightedyank'

    -- copy to system clipboard
    use {
        'ojroques/vim-oscyank',
        config = function()
            require 'plugins/oscyank'
        end
    }

    -- terminal
    use {
        'numtostr/FTerm.nvim',
        config = function()
            require 'plugins/fterm'
        end
    }

    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    -- RGB color highlighter
    use {
        'norcalli/nvim-colorizer.lua',
        ft = { 'html', 'css', 'yml' },
        config = function()
            require 'plugins/colorizer'
        end
    }

    use {
        'glepnir/dashboard-nvim',
        config = function()
            require 'plugins/dashboard'
        end
    }

    use {
        'RishabhRD/nvim-cheat.sh',
        requires = 'RishabhRD/popfix',
        cmd = {'Cheat', 'CheatList', 'CheatWithoutComments', 'CheatListWithoutComments'}
    }

    -- better quickfix
    use {
        'kevinhwang91/nvim-bqf',
        config = function()
            require 'plugins/bqf'
        end
    }

    -- colorscheme
    use {
        'sainnhe/gruvbox-material',
        cmd = 'colorscheme'
    }
    use {
        'sainnhe/sonokai',
        cmd = 'colorscheme'
    }
    -- use 'Luxed/ayu-vim'
    -- use 'morhetz/gruvbox'
    -- use 'NLKNguyen/papercolor-theme'
    use { 'kaicataldo/material.vim', branch = 'main' }

    -- Status Line and Bufferline
    --use 'famiu/feline.nvim' -- TODO
    --use 'glepnir/galaxyline.nvim' -- status line
    --use 'romgrk/barbar.nvim' -- TODO
    use {
        'vim-airline/vim-airline',
        requires = { 'vim-airline/vim-airline-themes' },
        config = function()
            require 'plugins/vim-airline'
        end
    }
    use {
        'akinsho/nvim-bufferline.lua',
        requires = {'kyazdani42/nvim-web-devicons', 'famiu/bufdelete.nvim'},
        config = function()
            require 'plugins/bufferline'
        end
    }
end)

