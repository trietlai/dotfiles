-- commented options are defaults
require('lspkind').init({
    -- defines how annotations are shown
    -- default: symbol
    -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
    mode = 'symbol_text',

    symbol_map = {
        Text        = '',
        Method      = 'ƒ',
        Function    = '',
        Constructor = '',
        Variable    = '',
        Class       = '',
        Interface   = 'ﰮ',
        Module      = '',
        Property    = '',
        Unit        = '',
        Value       = '',
        Enum        = '了',
        Keyword     = '',
        Snippet     = '﬌',
        Color       = '',
        File        = '',
        Folder      = '',
        EnumMember  = '',
        Constant    = '',
        Struct      = ''
    },
})

-- Diagnostics symbols for display in the sign column.
vim.cmd('sign define LspDiagnosticsSignError text=')
vim.cmd('sign define LspDiagnosticsSignWarning text=')
vim.cmd('sign define LspDiagnosticsSignInformation text=')
vim.cmd('sign define LspDiagnosticsSignHint text=')

