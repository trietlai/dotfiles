local neogit = require('neogit')

neogit.setup {
    integrations = {
        -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`
        -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`
        diffview = true
    },
}
