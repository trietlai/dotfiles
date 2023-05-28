local M = {}

local packer = require("packer")

-- Indicate first time installation
local packer_bootstrap = false

-- packer.nvim configuration
local packer_opts = {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Check if packer.nvim is installed
-- Run PackerCompile if there are changes in this file
local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        packer_bootstrap = fn.system {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path,
        }
        vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
end

local function packer_setup_plugins(use)
    -- Required packages
    use {
        'wbthomason/packer.nvim'
    }

    -- key mapping
    use {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
            require('plugins.which-key')
        end
    }

    -- FZF
    use {
        'junegunn/fzf',
        run = './install --bin',
        event = 'VimEnter',
        requires = {
            'junegunn/fzf.vim',
            'stsewd/fzf-checkout.vim'
        }
    }
    -- fzf lua
    use {
        'ibhagwan/fzf-lua',
        requires = {
            'vijaymarupudi/nvim-fzf',
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function()
            require('plugins.fzf-lua')
        end
    }

    -- Fzf alternative and many other plugins depend on it
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} },
        config = function()
            require('plugins.telescope')
        end
    }

    -- TODO: currently has an issue
    -- use {
    --     'nvim-telescope/telescope-project.nvim',
    --     requires = { 'nvim-telescope/telescope.nvim' },
    --     config = function()
    --         require('telescope').load_extension('project')
    --     end
    -- }

    -- Setup in the following order mason, mason-lspconfig, lspconfig
    -- auto complete
    use {
        'williamboman/mason.nvim',
        run = ':MasonUpdate', -- :MasonUpdate updates registry contents
        config = function()
            require('plugins.mason')
        end
    }
    use {
        'williamboman/mason-lspconfig.nvim',
        requires = {
            {'williamboman/mason.nvim'},
        },
        config = function()
            require('plugins.manson-lspconfig')
        end
    }
    -- LSP
    use {
        'neovim/nvim-lspconfig',
        config = function()
            require('plugins.lspconfig')
        end
    }
    -- Autocompletion
    use { 'hrsh7th/nvim-cmp' }
    use { "hrsh7th/cmp-buffer" }
    use { "hrsh7th/cmp-nvim-lua" }
    use { "hrsh7th/cmp-nvim-lsp" }
    use { "hrsh7th/cmp-nvim-lsp-signature-help" }
    use { "hrsh7th/cmp-path" }
    use { "L3MON4D3/LuaSnip" }
    use { "saadparwaiz1/cmp_luasnip" }
    use { "rafamadriz/friendly-snippets" }

    -- optional packages

    -- add symbols for LSP kinds e.g. method, class, etc.
    use {
        'onsails/lspkind-nvim',
        config = function()
            require('plugins.lspkind')
        end
    }
    use {
        'ojroques/nvim-lspfuzzy',
        requires = {
            {'junegunn/fzf'},
            {'junegunn/fzf.vim'},
        },
        config = function()
            require('plugins.lspfuzzy')
        end
    }
    use {
        'kosayoda/nvim-lightbulb',
        config = function()
            require('plugins.lightbulb')
        end
    }
    use {
        'simrat39/symbols-outline.nvim',
        config = function()
            require('plugins.symbols-outline')
        end
    }
	-- Automatically configures LSP for Neovim config, runtime and plugin directories
	use {
		'folke/neodev.nvim'
	}

	-- Debugging UI
	-- doesn't work unless disabling Yama
	-- `echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope`
	-- use {
	-- 	'mfussenegger/nvim-dap'
    --  config = function()
    -- 		require('plugins.nvim-dap')
    -- 	end
	-- }
	-- use {
	-- 	'rcarriga/nvim-dap-ui',
	-- 	requires = { 'mfussenegger/nvim-dap' }
	-- 	config = function()
	-- 		require("dapui").setup()
	-- 	end
	-- }

    -- automatically change to project root folder
    use {
        'ygm2/rooter.nvim', event = 'BufEnter',
        config = function()
            vim.g.rooter_pattern = {
                '.git', 'Makefile', 'node_modules', 'CMakeLists.txt', 'pom.xml',
                'build.gradle', 'Cargo.toml', 'go.mod', '.gitignore',
            }
            vim.g.outermost_root = false
        end
    }

    -- tree-sitter parser
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('plugins.treesitter')
        end
    }

    -- Rainbow parentheses for neovim using tree-sitter
    use {
        'p00f/nvim-ts-rainbow',
        requires = 'nvim-treesitter/nvim-treesitter',
        event = 'BufRead',
        config = function()
            require('plugins.nvim-ts-rainbow')
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
        config = function()
            require('treesitter-context').setup{
                enable = true,
                throttle = true, -- Throttles plugin updates (may improve performance)
            }
        end
    }

    -- extends vim's % key to language-specific words
    use {
        'andymass/vim-matchup',
        event = 'CursorMoved'
    }

    -- Files/directories tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function()
            require('plugins.nvim-tree')
        end
    }
    -- use {
    --     'kevinhwang91/rnvimr',
    --     cmd = 'RnvimrToggle'
    -- }
    use {
        "luukvbaal/nnn.nvim",
        config = function()
            require('plugins.nnn')
        end
    }

    -- Syntax
    use {
        'habamax/vim-asciidoctor',
        ft = { 'asciidoctor' },
        config = function()
            require('plugins.asciidoctor')
        end
    }

    use { 'honza/dockerfile.vim', ft = { 'dockerfile' } }

    -- use { 'martinda/Jenkinsfile-vim-syntax', ft = { 'jenkinsfile' } }
    -- use { 'chr4/nginx.vim', ft = { 'conf' } }
    -- use { 'zigford/vim-powershell', ft = { 'ps1' } }

    use {
        'kristijanhusak/orgmode.nvim',
        ft = {'org'},
        config = function()
            require('orgmode').setup{}
        end
    }
    --use { 'jceb/vim-orgmode', ft = { 'org' } }

    -- Tim Pope
    use 'tpope/vim-repeat'
    use 'tpope/vim-unimpaired'
    --use 'tpope/vim-endwise' -- conflict with 'compe'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'

    -- Git
    use { 'tpope/vim-fugitive' }

    -- use {
    --     'airblade/vim-gitgutter',
    --     even = 'BufEnter',
    --     config = function()
    --         require('plugins.gitgutter')
    --     end
    -- }

    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            require('plugins.gitsigns')
        end
    }

    -- similar to magit
    -- use {
    --     'TimUntersberger/neogit',
    --     requires = 'nvim-lua/plenary.nvim',
    --     config = function()
    --         require('plugins.neogit')
    --     end
    -- }

    -- git commit log browser
    use { 'junegunn/gv.vim', cmd = 'GV' }

    use {
        'sindrets/diffview.nvim',
        cmd = 'DiffviewOpen',
        config = function()
            require('plugins.diffview')
        end
    }

    use {
        'samoshkin/vim-mergetool',
        config = function()
            require('plugins.mergetool')
        end
    }

    -- use 'lambdalisue/gina.vim'

    -- indent & align
    use {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        setup = function()
            require('plugins.indent-blankline')
        end
    }
    use {
        'junegunn/vim-easy-align',
        as = 'vim-easy-align',
        config = function()
            require('plugins.vim-easy-align')
        end
    }

    -- Move & Search & replace
    -- search & highlight
    use {
        'kevinhwang91/nvim-hlslens',
        event = 'BufEnter',
        config = function()
            require('plugins.hlslens')
        end
    }

    -- motion/jump plugin
    use {
        'ggandor/lightspeed.nvim',
        config = function()
            require('plugins.lightspeed')
        end
    }
    -- alternatives motion/jump plugins
    -- use 'easymotion/vim-easymotion'
    -- use 'rhysd/clever-f.vim'

    -- Smooth scrolling for window movement commands
    use {
        'karb94/neoscroll.nvim',
        config = function()
            require('plugins.neoscroll')
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
        'ojroques/nvim-osc52',
        config = function()
            require('plugins.oscyank')
        end
    }

    -- terminal
    use {
        'numtostr/FTerm.nvim',
        config = function()
            require('plugins.fterm')
        end
    }

    -- Icons
    use 'nvim-tree/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    -- RGB color highlighter
    use {
        'norcalli/nvim-colorizer.lua',
        ft = { 'html', 'css', 'yml', 'lua' },
        config = function()
            require('plugins.colorizer')
        end
    }

    use {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('plugins.dashboard')
        end,
        requires = {'nvim-tree/nvim-web-devicons'}
    }

    use {
        'sudormrfbin/cheatsheet.nvim',
        requires = {
            {'nvim-telescope/telescope.nvim'},
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
        }
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
            require('plugins.bqf')
        end
    }

    -- colorscheme
    -- main colorscheme
    use { 'kaicataldo/material.vim', branch = 'main' } -- dark

    use {
        'NLKNguyen/papercolor-theme', -- dark & light
        cmd = 'colorscheme'
    }
    use {
        'Luxed/ayu-vim', -- dark & light
        cmd = 'colorscheme'
    }
    use {
        'sainnhe/gruvbox-material', -- dark & light
        cmd = 'colorscheme'
    }
    use {
        'morhetz/gruvbox', -- dark & light
        cmd = 'colorscheme'
    }
    use {
        'sainnhe/sonokai', -- dark
        cmd = 'colorscheme'
    }
    use {
        'folke/tokyonight.nvim', -- dark & light
        cmd = 'colorscheme'
    }

    use {
        'sainnhe/edge', -- dark & light
        cmd = 'colorscheme'
    }
    use {
        'Th3Whit3Wolf/space-nvim', -- dark & light
        cmd = 'colorscheme'
    }
    use {
        'sainnhe/everforest', -- dark & light
        cmd = 'colorscheme'
    }

    -- Status Line and Bufferline
    use {
        'vim-airline/vim-airline',
        requires = { 'vim-airline/vim-airline-themes' },
        setup = function()
            require('plugins.vim-airline')
        end
    }

    -- use {
    --     'glepnir/galaxyline.nvim',
    --     branch = 'main',
    --     requires = {'nvim-tree/nvim-web-devicons', opt = true},
    --     config = function()
    --         require('plugins.galaxy-statusline')
    --     end
    -- }

    -- use {
    --     'famiu/feline.nvim',
    --     requires = { 'lewis6991/gitsigns.nvim' },
    --     config = function()
    --         require('plugins.feline')
    --     end
    -- }

    -- use {
    --     'akinsho/nvim-bufferline.lua',
    --     requires = {'nvim-tree/nvim-web-devicons', 'famiu/bufdelete.nvim'},
    --     config = function()
    --         require('plugins.bufferline')
    --     end
    -- }
    use {
        'romgrk/barbar.nvim',
        requires = {'nvim-tree/nvim-web-devicons'},
        config = function()
            require('plugins.barbar')
        end
    }
    use {
        "cuducos/yaml.nvim",
        -- ft = {"yaml"}, -- optional
        requires = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-telescope/telescope.nvim" -- optional
        },
    }
    use {
        "lukas-reineke/virt-column.nvim",
        config = function()
            require("virt-column").setup()
        end
    }

    -- Bootstrap Neovim
    if packer_bootstrap then
        print "Restart Neovim required after installation!"
        packer.sync()
    end
  end

function M.setup()
    -- Plugins
    -- Init and start packer
    packer_init()
    packer.init(packer_opts)
    packer.startup(packer_setup_plugins)

    -- register keybindings using which-key
    require('plugins.keymaps').register()
end

return M

