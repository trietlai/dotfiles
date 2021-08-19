require("nnn").setup({
    command = "nnn -o -C",
    set_default_mappings = 0,
    replace_netrw = 1,
    layout = {
        window = {
            width = 0.9,
            height = 0.8,
            yoffset = 0.2,
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
