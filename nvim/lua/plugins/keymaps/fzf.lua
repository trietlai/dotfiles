-- fzf & fzf-lua plugins
-- replaced by telescope, leave it here for reference

local M = {}

local wk = require('which-key')
local fzf = require('fzf-lua')
local U = require('settings.util')

local function fzf_keymap(lhs, rhs, desc)
    U.keymap("n", "<leader>" .. lhs, rhs, desc)
end

function M.register()
    
    fzf_keymap("b", function() fzf.buffers() end, "list buffers")
    fzf_keymap("g", function() fzf.git_status() end, "Git status")
    fzf_keymap("h", function() fzf.search_history() end, "search history")
    fzf_keymap("j", function() tbuiltin.jumplist() end, "jump list")
    fzf_keymap("l", function() fzf.loclist() end, "location list")
    fzf_keymap("m", function() fzf.keymaps() end, "show keymaps")
    -- fzf_keymap("p",
    --            function() require('extensions.telescope-dotfile').project_files() end,
    --            "search project files")
    fzf_keymap("q", function() fzf.quickfix() end, "quickfix list")
    fzf_keymap("r", function() fzf.oldfiles() end, "recent files")
    fzf_keymap("t", function() fzf.tags() end, "tags")
    fzf_keymap("/", function() fzf.live_grep() end, "search text")
    fzf_keymap(":", function() fzf.command_history() end, "command history")
    fzf_keymap("`", function() fzf.marks() end, "marks")
    fzf_keymap('"', function() fzf.registers() end, "registers")
    fzf_keymap("=", function() fzf.spell_suggest() end, "spell suggest")
    fzf_keymap("w", ":Windows", "find windows")

    local func_maps = {
        -- Buffers & Files
        {"Fb", function() fzf.buffers() end, "open buffers" },
        {"Ff", function() fzf.files() end, "fd on a path" },
        {"Fr", function() fzf.oldfiles() end, "recent files" },
        {"Fq", function() fzf.quickfix() end, "quickfix list" },
        {"FQ", function() fzf.quickfix_stack() end, "quickfix stack" },
        {"Fl", function() fzf.loclist() end, "location list" },
        {"FL", function() fzf.loclist_stack() end, "location stack" },

        -- Tmux
        {"Ft", function() fzf.tmux_buffers() end, "list tmux paste buffers" },

        -- Misc
        {"Fc", function() fzf.changes() end, "changes" },
        {"Fj", function() fzf.jumps() end, "jumps" },
        {"Fk", function() fzf.keymaps() end, "key mappings" },
        {"Fm", function() fzf.man_pages() end, "man pages" },
        {"Fx", function() fzf.commands() end, "neovim commands" },
        {"F?", function() fzf.help_tags() end, "help tags" },
        {"F:", function() fzf.command_history() end, "command history" },
        {"F`", function() fzf.marks() end, "marks" },
        {'F"', function() fzf.registers() end, "registers" },
        {'F=', function() fzf.spell_suggest() end, "spelling suggestions" },

        -- Search
        {"F/", function() fzf.grep() end, "search pattern" },
        {"Fsb", function() fzf.grep_curbuf() end, "search current buffer lines" },
        {"Fsl", function() fzf.grep_last() end, "search last pattern" },
        {"Fsr", function() fzf.live_grep_resume() end, "live grep continue last search" },
        {"Fss", function() fzf.live_grep() end, "live grep current project" },
        {"Fsv", function() fzf.grep_visual() end, "search visual selection" },
        {"Fsw", function() fzf.grep_cword() end, "search word under cursor" },
        {"FsW", function() fzf.grep_cWORD() end, "search WORD under cursor" },

        -- Tags
        {"F*/", function() fzf.tags_grep() end, "grep project tags" },
        {"F*b", function() fzf.tags() end, "project tags" },
        {"F*l", function() fzf.tags_live_grep() end, "live grep project tags" },
        {"F*t", function() fzf.btags() end, "buffer tags" },
        {"F*v", function() fzf.tags_grep_visual() end, "tag grep visual selection" },
        {"F*w", function() fzf.tags_grep_cword() end, "tag grep word under cursor" },
        {"F*W", function() fzf.tags_grep_cWORD() end, "tag grep WORD under cursor" },

        -- Git
        {"FG", function() fzf.git_status() end, "git status" },
        {"Fgb", function() fzf.git_branches() end, "git branches" },
        {"Fgc", function() fzf.git_commits() end, "git commit log (project)" },
        {"FgC", function() fzf.git_bcommits() end, "git commit log (buffer)" },
        {"Fgf", function() fzf.git_files() end, "git ls-files" },
        {"Fgs", function() fzf.git_status() end, "git status" },
        {"FgS", function() fzf.git_stash() end, "git stash" },

        -- LSP
        {"Fla", function() fzf.lsp_code_actions() end, "code actions" },
        {"Flf", function() fzf.lsp_finder() end, "All LSP locations, combined view" },
        {"Fli", function() fzf.lsp_implementations() end, "implementations" },
        {"Fld", function() fzf.lsp_definitions() end, "definitions" },
        {"FlD", function() fzf.lsp_declarations() end, "declarations" },
        {"Flk", function() fzf.lsp_document_symbols() end, "document symbols" },
        {"Flr", function() fzf.lsp_references() end, "references" },
        {"Fls", function() fzf.lsp_workspace_symbols() end, "workspace symbols" },
        {"Flt", function() fzf.lsp_typedefs() end, "type definitions" },
        {"Flw", function() fzf.lsp_document_diagnostics() end, "document diagnostics" },
        {"FlW", function() fzf.lsp_workspace_diagnostics() end, "workspace diagnostics" },

    }
    for _, map in pairs(func_maps) do
        fzf_keymap(unpack(map))
    end

    local cmd_maps = {
        {"Sa", ":Ag", "text Ag" },
        {"SB", ":BLines", "current buffer" },
        {"Sb", ":Buffers", "open buffers" },
        {"Sc", ":Commits", "commits" },
        {"SC", ":BCommits", "buffer commits" },
        {"Sf", ":Files", "files" },
        {"Sg", ":GFiles", "git files" },
        {"SG", ":GFiles?", "modified git files" },
        {"Sh", ":History", "file history" },
        {"SH", ":History:", "command history" },
        {"Sl", ":Lines", "lines" },
        {"Sm", ":Marks", "marks" },
        {"SM", ":Maps", "normal maps" },
        {"Sp", ":Helptags", "help tags" },
        {"SP", ":Tags", "project tags" },
        {"Ss", ":Snippets", "snippets" },
        {"SS", ":Colors", "color schemes" },
        {"S/", ":Rg", "text Rg" },
        {"St", ":BTags", "buffer tags" },
        {"Sw", ":Windows", "search windows" },
        {"Sy", ":Filetypes", "file types" },
        {"Sz", ":FZF", "FZF" },
        {"SY", ":History/", "history" },
        {"S;", ":Commands", "commands" },
    }
    for _, map in pairs(cmd_maps) do
        fzf_keymap(unpack(map))
    end

    wk.register({
        F = {
            name = "FzfLua",
            g = {
                name = "git",
             },
            l = {
                name = "LSP",
             },
             s = {
                 name = "search",
             },
             ["*"] = {
                 name = "tags",
             },
         },
        S = {
            name  = "Search",
        },
    }, { prefix = "<leader>" })
end

return M

