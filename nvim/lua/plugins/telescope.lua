
local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.load_extension('project')

--require'telescope'.extensions.project.project{}

telescope.setup{
    defaults = {
        set_env = { ["COLORTERM"] = "truecolor" },
        path_display = { shorten = 3, "absolute" },
        mappings = {
            n = {
                ["q"] = actions.close
            },
            i = {
                ["jj"] = { "<esc>", type = "command" },
                ["<esc>"] = actions.close,
            },
        },
        file_ignore_patterns = { "node_modules", ".git", "build" },
        selection_strategy = "row",
        selection_caret = ' ',
        dynamic_preview_title = true,
    },
    pickers = {
        buffers = {
            sort_lastused = true,
            sort_mru = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
                i = {
                    ["<c-d>"] = actions.delete_buffer,
                },
                n = {
                    ["d"] = actions.delete_buffer,
                }
            }
        },
    },
    extensions = {
        project = {
            base_dirs = {
                {path = '~/src', max_depth = 4},
                {path = '~/projects', max_depth = 4},
            },
            hidden_files = false, -- default: false
        }
    }
}

