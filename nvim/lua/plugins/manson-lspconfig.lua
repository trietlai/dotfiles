require('mason-lspconfig').setup {
    ensure_installed = {
        'bashls',
        'clangd',
        'cmake',
        -- 'neocmake', -- often crash
        -- 'dockerls',
        -- 'gopls',
        'jsonls',
        'jdtls',
        'lua_ls',
        'marksman',
        -- 'pyright',
        'rust_analyzer',
        -- 'tsserver',
        'yamlls',
        'vimls',
    },
}

