-- check mason-lspconfig for LSP being used
local lspconfig = require('lspconfig')

require('lspkind').init()

-- Diagnostics symbols for display in the sign column.
vim.cmd('sign define LspDiagnosticsSignError text=')
vim.cmd('sign define LspDiagnosticsSignWarning text=')
vim.cmd('sign define LspDiagnosticsSignInformation text=')
vim.cmd('sign define LspDiagnosticsSignHint text=')
--vim.cmd('setlocal omnifunc=v:lua.vim.lsp.omnifunc')

lspconfig.bashls.setup {}

-- clangd may not work properly see the link below:
-- https://stackoverflow.com/questions/74785927/clangd-doesnt-recognize-standard-headers
lspconfig.clangd.setup {}

--lspconfig.neocmake.setup {}
lspconfig.cmake.setup {}
lspconfig.jsonls.setup {}
lspconfig.jdtls.setup {}
lspconfig.lua_ls.setup {}
lspconfig.marksman.setup {}
lspconfig.pyright.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.yamlls.setup {}
lspconfig.vimls.setup {}

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wl', function()
    -- 	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
    	vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

