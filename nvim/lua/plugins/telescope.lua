
local telescope = require("telescope")
local actions = require("telescope.actions")
telescope.load_extension('project')

--require'telescope'.extensions.project.project{}

telescope.setup{
    defaults = {
        set_env = { ["COLORTERM"] = "truecolor" },
        path_display = { "shorten", "absolute" },
        mappings = {
            n = {
                ["q"] = actions.close
            },
            i = {
                ["<esc>"] = actions.close,
            },
        },
        file_ignore_patterns = { "node_modules", ".git" },
    },
    pickers = {
        buffers = {
            sort_lastused = true,
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
                {path = '~/repo', max_depth = 4},
            },
            hidden_files = true, -- default: false
        }
    }
}

