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
    use 'wbthomason/packer.nvim'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind-nvim'

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'p00f/nvim-ts-rainbow'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'romgrk/nvim-treesitter-context'

    -- Autocomplete
    use 'hrsh7th/nvim-compe'
    use 'andymass/vim-matchup'

    -- Files/directories tree
    use 'preservim/NERDTree'
    use 'Xuyuanp/nerdtree-git-plugin'
    use 'tiagofumo/vim-nerdtree-syntax-highlight'
    use 'PhilRunninger/nerdtree-visual-selection'
    -- alternative 
    use 'kyazdani42/nvim-tree.lua'
    use 'kevinhwang91/rnvimr'

    -- key mapping
    use 'folke/which-key.nvim'

    -- FZF
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use 'stsewd/fzf-checkout.vim'

    -- Syntax
    use 'habamax/vim-asciidoctor'
    use 'honza/dockerfile.vim'
    use 'martinda/Jenkinsfile-vim-syntax'
    use 'chr4/nginx.vim'
    use 'zigford/vim-powershell'
    use 'gcmt/taboo.vim'

    -- Tim Pope
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-endwise'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    -- Git
    use 'airblade/vim-gitgutter'
    use 'junegunn/gv.vim'
    use 'sindrets/diffview.nvim'
    -- use 'jreybert/vimagit'
    -- use 'lambdalisue/gina.vim'

    -- Registers
    use 'tversteeg/registers.nvim'

    -- indent & align
    use 'lukas-reineke/indent-blankline.nvim'
    use 'junegunn/vim-easy-align'

    -- Move & Search & replace
    use 'kevinhwang91/nvim-hlslens'
    use 'ggandor/lightspeed.nvim'
    use 'karb94/neoscroll.nvim'
    use 'dstein64/nvim-scrollview'
    use 'easymotion/vim-easymotion'
    use 'terryma/vim-expand-region'
    use 'chaoren/vim-wordmotion'
    use 'rhysd/clever-f.vim'

    -- copy & paste
    use 'machakann/vim-highlightedyank'
    use 'ojroques/vim-oscyank'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    -- Color
    use 'norcalli/nvim-colorizer.lua'

    -- Colorschema
    use 'sainnhe/gruvbox-material'
    use 'sainnhe/sonokai'
    -- use 'Luxed/ayu-vim'
    -- use 'morhetz/gruvbox'
    -- use 'NLKNguyen/papercolor-theme'
    use { 'kaicataldo/material.vim', branch = 'main' }

    -- Status Line and Bufferline
    --use 'famiu/feline.nvim' -- TODO
    --use 'romgrk/barbar.nvim' -- TODO
    use 'vim-airline/vim-airline'
    use 'vim-airline/vim-airline-themes'
end)

