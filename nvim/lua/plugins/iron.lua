local iron = require("iron.core")
local view = require("iron.view")
iron.setup {
    config = {
        should_map_plug = false,
        scratch_repl = true,
        repl_definition = {
            python = {
                command = { "ipython3" },
                format = require("iron.fts.common").bracketed_paste,
            },
        },
        repl_open_cmd = view.bottom("30%"),
    },
    keymaps = {
        send_motion = "<leader>is",
        visual_send = "<leader>is",
        send_file   = "<leader>if",
        send_line   = "<leader>il",
        send_mark   = "<leader>im",
        mark_motion = "<leader>ik",
        mark_visual = "<leader>ik",
        remove_mark = "<leader>id",
        cr          = "<leader>i<cr>",
        interrupt   = "<leader>i<space>",
        exit        = "<leader>iQ",
        clear       = "<leader>iC",
    },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

local U = require('settings.util')
U.keymap('n', '<leader>iO', ':IronRepl', 'Open a REPL for file type')
U.keymap('n', '<leader>iH', ':IronReplHere', 'Open a REPL in current window')
U.keymap('n', '<leader>iR', ':IronRestart', 'Restart the current REPL')
U.keymap('n', '<leader>iF', ':IronFocus', 'Focuses on the REPL for file type')
U.keymap('n', '<leader>iX', ':IronHide', 'Hide the REPL window for file type')

local wk = require('which-key')
wk.register({
    i = {
        name = "Iron commands",
    },
}, { prefix = "<leader>" })

