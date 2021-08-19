require("nnn").setup({
    command = "nnn -o -C",
    set_default_mappings = 0,
    replace_netrw = 1,
    layout = {
        window = {
            width = 0.9,
            height = 0.6,
            highlight = 'Debug'
        }
    },
    action = {
        ["<c-t>"] = "tab split",
        ["<c-s>"] = "split",
        ["<c-v>"] = "vsplit",
    },
    session = 'global',
})
