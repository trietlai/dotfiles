require('bufferline').setup {
    options = {
        numbers = "ordinal",
        number_style = "none",
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
        fill = {
            guifg = '#d8a657',
        },
        tab = {
            guifg = '#d8a657',
        },
        background = {
            guifg = '#d8a657',
        },
        info = {
            guifg = '#00f9fd',
        },
        info_visible = {
            guifg = '#00f9fd',
        },
        warning = {
            guifg = '#b237b6',
        },
        warning_visible = {
            guifg = '#b237b6',
        },
        error = {
            guifg = '#FF6059',
        },
        error_visible = {
            guifg = '#FF6059',
        },
        tab_close = {
            guifg = "#87FF00",
        },
        close_button = {
            guifg = "#87FF00",
        },
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
