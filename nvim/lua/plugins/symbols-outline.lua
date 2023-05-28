require('symbols-outline').setup {
    symbols = {
        Module = {icon = "", hl = "TSNamespace"},
        Namespace = {icon = "∷", hl = "TSNamespace"},
        Key = {icon = "", hl = "TSType"},
        Operator = {icon = "⊕", hl = "TSOperator"},
        Null = {icon = "ﳠ", hl = "TSType"},
    }
}

local U = require('settings.util')
U.keymap("n", "<F5>", ":SymbolsOutline", "toggle symbols-outline")

