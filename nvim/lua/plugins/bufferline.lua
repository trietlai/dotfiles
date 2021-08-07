require('bufferline').setup {
    options = {
        numbers = "both",
        number_style = "superscript",
        mappings = true,
        close_command = function(bufnum)
            require('bufdelete').bufdelete(bufnum, true)
        end,
        right_mouse_command = "vertical sbuffer %d",
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator_icon = '▎',
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            return "("..count..")"
        end,
        offsets = {{filetype = "NvimTree", text = "", padding = 1}},
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        separator_style = "slant",
        enforce_regular_tabs = false,
        always_show_bufferline = true
    },
    highlights = {
        buffer_visible = {
            guifg = '#7AA2F7',
        },
        buffer_selected = {
            guifg = "#87FF00",
            gui = "bold,italic"
        },
        close_button_visible = {
            guifg = '#7AA2F7',
        },
        close_button_selected = {
            guifg = "#87FF00",
        },
    }
}
