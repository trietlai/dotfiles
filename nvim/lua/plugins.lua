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
    -- Packer can manage itself as an optional plugin
    use { 'wbthomason/packer.nvim', event = 'VimEnter' }

    -- LSP
    use { 'kabouzeid/nvim-lspinstall', event = 'BufEnter' }
    use {
        'neovim/nvim-lspconfig',
        after = 'nvim-lspinstall',
        config = function()
            require 'plugins.lspconfig'
        end
    }
    use {
        'onsails/lspkind-nvim',
        config = function()
            require 'plugins.lspkind'
        end
    }

    -- automatically change to project root folder
    use { 'ygm2/rooter.nvim', event = 'BufEnter' }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require 'plugins.treesitter'
        end
    }

    use {
        'p00f/nvim-ts-rainbow',
        event = 'BufRead',
        config = function()
            require 'plugins.nvim-ts-rainbow'
        end
    }
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'romgrk/nvim-treesitter-context'

    -- Autocomplete
    use {
        'hrsh7th/nvim-compe',
        event = 'InsertEnter',
        config = function()
            require 'plugins.compe'
        end,
    }

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
            require 'plugins.nvimtree'
        end
    }
    use {
        'kevinhwang91/rnvimr',
        cmd = 'RnvimrToggle'
    }

    -- key mapping
    use {
        'folke/which-key.nvim',
        --keys = { 'n', '<Space>' }
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

    use 'gcmt/taboo.vim'

    -- Tim Pope
    use { 'tpope/vim-fugitive', cmd = { 'Git' } }
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-endwise'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    -- Git
    use {
        'airblade/vim-gitgutter',
        even = 'BufEnter',
        config = function()
            require('plugins.gitgutter')
        end
    }
    use { 'junegunn/gv.vim', cmd = 'GV' }
    use {
        'sindrets/diffview.nvim',
        --cmd = 'DiffviewOpen',
        config = function()
            require 'plugins.diffview'
        end
    }

    -- use 'jreybert/vimagit'
    -- use 'lambdalisue/gina.vim'

    -- Registers: fzf.vim has this functionality
    -- use 'tversteeg/registers.nvim'

    -- indent & align
    use {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        config = function()
            require 'plugins.indent-blankline'
        end
    }
    use 'junegunn/vim-easy-align'

    -- Move & Search & replace
    use {
        'kevinhwang91/nvim-hlslens',
        event = 'BufEnter',
        config = function()
            require 'plugins.hlslens'
        end
    }

    use {
        'ggandor/lightspeed.nvim',
        config = function()
            require 'plugins.lightspeed'
        end
    }

    use {
        'karb94/neoscroll.nvim',
        config = function()
            require 'plugins.neoscroll'
        end
    }

    use 'dstein64/nvim-scrollview'
    use 'easymotion/vim-easymotion'
    use 'terryma/vim-expand-region'
    use 'chaoren/vim-wordmotion'
    use 'rhysd/clever-f.vim'

    -- copy & paste
    use 'machakann/vim-highlightedyank'
    use {
        'ojroques/vim-oscyank',
        config = function()
            require('plugins.oscyank')
        end
    }

    -- misc
    use {
        'numtostr/FTerm.nvim',
        config = function()
            require('plugins.fterm')
        end
    }

    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    -- Color
    use {
        'norcalli/nvim-colorizer.lua',
        ft = { 'html', 'css', 'yml' },
        config = function()
            require 'plugins.colorizer'
        end
    }

    use {
        'glepnir/dashboard-nvim',
        config = function()
            require 'plugins.dashboard'
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
    --use 'romgrk/barbar.nvim' -- TODO
    use {
        'vim-airline/vim-airline',
        requires = { 'vim-airline/vim-airline-themes' },
        config = function()
            require('plugins.vim-airline')
        end
    }

end)

