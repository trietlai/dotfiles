local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local force_inactive = {
    filetypes = {},
    buftypes  = {},
    bufnames  = {}
}

local components = {
    active = {},
    inactive = {}
}
-- Insert three sections (left, mid and right) for the active statusline
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, {})
table.insert(components.inactive, {})

local colors = {
    bg        = '#282828',
    black     = '#282828',
    yellow    = '#d8a657',
    cyan      = '#00f9fd',
    oceanblue = '#45707a',
    green     = '#87ff00',
    orange    = '#e78a4e',
    violet    = '#b237b6',
    magenta   = '#d8697c',
    white     = '#a89984',
    fg        = '#a89984',
    skyblue   = '#00afff',
    red       = '#FF6059',
}

local vi_mode_colors = {
    NORMAL        = 'green',
    OP            = 'green',
    INSERT        = 'red',
    VISUAL        = 'skyblue',
    BLOCK         = 'skyblue',
    REPLACE       = 'violet',
    ['V-REPLACE'] = 'violet',
    ENTER         = 'cyan',
    MORE          = 'cyan',
    SELECT        = 'orange',
    COMMAND       = 'green',
    SHELL         = 'green',
    TERM          = 'green',
    NONE          = 'yellow'
}

local vi_mode_indicators = {
    NORMAL        = '🅝 NORMAL',
    OP            = '🅞 OP',
    INSERT        = '🅘 INSERT',
    VISUAL        = '🅥 VISUAL',
    BLOCK         = '🅑 BLOCK',
    REPLACE       = '🅡 REPLACE',
    ['V-REPLACE'] = '🆁 V-REPLACE',
    ENTER         = '🅔 ENTER',
    MORE          = '🅜 MORE',
    SELECT        = '🅢 SELECT',
    COMMAND       = '🅒 COMMAND',
    SHELL         = '🆂 SHELL',
    TERM          = '🅣 TERM',
    NONE          = 'NONE',
}

local sep_icons = {
    right = "",
    left = ""
}

force_inactive.filetypes = {
    'NvimTree',
    'dbui',
    'packer',
    'startify',
    'fugitive',
    'fugitiveblame',
    'fzf',
}

force_inactive.buftypes = {
    'terminal',
    'nowrite',
    'nofile',
    'prompt',
}

-- ACITVE LEFT

-- vi-mode
components.active[1][1] = {
    provider = function()
        return vi_mode_indicators[vi_mode_utils.get_vim_mode()]
    end,
    hl = function()
        local val = {}
        val.bg    = vi_mode_utils.get_mode_color()
        val.fg    = 'black'
        val.style = 'bold'
        return val
    end,
    right_sep = sep_icons.left .. ' '
}
-- filename
components.active[1][2] = {
    provider = function()
        return vim.fn.expand("%:F")
    end,
    hl = {
        fg    = 'white',
        bg    = 'bg',
        style = 'bold'
    },
    right_sep = ''
}
-- gitBranch
components.active[1][3] = {
    provider = 'git_branch',
    hl = {
        fg    = 'yellow',
        bg    = 'bg',
        style = 'bold'
    }
}
-- diffAdd
components.active[1][4] = {
    provider = 'git_diff_added',
    hl = {
        fg    = 'green',
        bg    = 'bg',
        style = 'bold'
    }
}
-- diffModfified
components.active[1][5] = {
    provider = 'git_diff_changed',
    hl = {
        fg    = 'orange',
        bg    = 'bg',
        style = 'bold'
    }
}
-- diffRemove
components.active[1][6] = {
    provider = 'git_diff_removed',
    hl = {
        fg    = 'red',
        bg    = 'bg',
        style = 'bold'
    }
}

-- ACTIVE MID

-- LspName
components.active[2][1] = {
    provider = 'lsp_client_names',
    hl = {
        fg    = 'yellow',
        bg    = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- diagnosticErrors
components.active[2][2] = {
    provider = 'diagnostic_errors',
    enabled = function() return lsp.diagnostics_exist('Error') end,
    hl = {
        fg    = 'red',
        style = 'bold'
    }
}
-- diagnosticWarn
components.active[2][3] = {
    provider = 'diagnostic_warnings',
    enabled = function() return lsp.diagnostics_exist('Warning') end,
    hl = {
        fg    = 'yellow',
        style = 'bold'
    }
}
-- diagnosticHint
components.active[2][4] = {
    provider = 'diagnostic_hints',
    enabled = function() return lsp.diagnostics_exist('Hint') end,
    hl = {
        fg    = 'cyan',
        style = 'bold'
    }
}
-- diagnosticInfo
components.active[2][5] = {
    provider = 'diagnostic_info',
    enabled = function() return lsp.diagnostics_exist('Information') end,
    hl = {
        fg    = 'skyblue',
        style = 'bold'
    }
}

-- ACTIVE RIGHT

-- fileIcon
components.active[3][1] = {
    provider = function()
        local filename  = vim.fn.expand('%:t')
        local extension = vim.fn.expand('%:e')
        local icon      = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon == nil then
            icon = ''
        end
        return icon
    end,
    hl = function()
        local val        = {}
        local filename   = vim.fn.expand('%:t')
        local extension  = vim.fn.expand('%:e')
        local icon, name = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon ~= nil then
            val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
        else
            val.fg = 'white'
        end
        val.bg    = 'bg'
        val.style = 'bold'
        return val
    end,
    right_sep = ' '
}
-- fileType
components.active[3][2] = {
    provider = 'file_type',
    hl = function()
        local val        = {}
        local filename   = vim.fn.expand('%:t')
        local extension  = vim.fn.expand('%:e')
        local icon, name = require'nvim-web-devicons'.get_icon(filename, extension)
        if icon ~= nil then
            val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
        else
            val.fg = 'white'
        end
        val.bg    = 'bg'
        val.style = 'bold'
        return val
    end,
    right_sep = ' '
}
-- fileSize
components.active[3][3] = {
    provider = 'file_size',
    enabled = function() return vim.fn.getfsize(vim.fn.expand('%:t')) > 0 end,
    hl = {
        fg    = 'skyblue',
        bg    = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- fileFormat
components.active[3][4] = {
    provider = function() return '' .. vim.bo.fileformat:upper() .. '' end,
    hl = {
        fg    = 'white',
        bg    = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- fileEncode
components.active[3][5] = {
    provider = 'file_encoding',
    hl = {
        fg    = 'white',
        bg    = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- lineInfo
components.active[3][6] = {
    provider = 'position',
    hl = {
        fg    = 'white',
        bg    = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- linePercent
components.active[3][7] = {
    provider = 'line_percentage',
    hl = {
        fg    = 'white',
        bg    = 'bg',
        style = 'bold'
    },
    right_sep = ' '
}
-- scrollBar
components.active[3][8] = {
    provider = 'scroll_bar',
    hl = {
        fg = 'yellow',
        bg = 'bg',
    },
}

-- INACTIVE

-- fileType
components.inactive[1][1] = {
    provider = 'file_type',
    hl = {
        fg    = 'black',
        bg    = 'cyan',
        style = 'bold'
    },
    left_sep = {
        str = ' ',
        hl  = {
            fg = 'NONE',
            bg = 'cyan'
        }
    },
    right_sep = {
        {
            str = ' ',
            hl  = {
                fg = 'NONE',
                bg = 'cyan'
            }
        },
        ' '
    }
}
-- filename : commented out due to a conflict with fzf-lua plugin
-- components.inactive[1][2] = {
--     provider = function()
--         return vim.fn.expand("%:F")
--     end,
--     hl = {
--         fg    = 'white',
--         bg    = 'bg',
--         style = 'bold'
--     },
--     right_sep = ''
-- }

require('feline').setup({
    colors         = colors,
    vi_mode_colors = vi_mode_colors,
    components     = components,
    force_inactive = force_inactive,
})

