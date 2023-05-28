local wk = require('which-key')
wk.setup {
    key_labels = {
        ["<space>"] = "SPC",
        ["<CR>"]    = "RET",
        ["<Tab>"]   = "TAB",
        ["<S-Tab>"] = "S-TAB",
    },
}

wk.register({

    -- start with 'g'
    g = {
        c     = { "<Plug>Commentary", "Commentary" },
        -- p     = { function() require('telescope').extensions.project.project{} end, "list projects" },
    },

    -- start with ','
    [","] = {
        a = {"<Plug>(EasyAlign)", "Easy align"},
    },
}, {
    mode = "n",
})

