local M = {}

local wk = require('which-key')
local telescope = require('telescope.builtin')
local U = require('settings.util')

local function git_keymap(lhs, rhs, desc)
    U.keymap("n", "<leader>" .. lhs, rhs, desc)
end

function M.register()
    wk.register({
        G = {
            name  = "Git",
        },
        H = {
            name = "git-gutter",
            p    = "preview hunk",
            q    = { "<cmd>:Gqf<CR>", "show hunks in quickfix" },
            s    = "stage hunk",
            u    = "undo hunk",
        },
        M = {
            name  = "merge-tool",
        },
    }, { prefix = "<leader>" })

    -- mainly from vim-fugitive
    local git_maps = {
        {"Gb", function() telescope.git_branches() end, "list branches" },
        {"GB", ":Git blame", "blame" },
        {"Gc", function() telescope.git_commits() end, "list commits" },
        {"GC", function() telescope.git_bcommits() end, "git commit log (buffer)" },
        {"Gd", ":Gvdiffsplit", "diff" },
        {"GD", ":DiffviewOpen", "diff view" }, -- diffview plugin
        {"Gf", ":Git fetch", "fetch" },
        {"GF", function() telescope.git_files() end, "git files" },
        {"Gl", ":GV!", "log for current file" }, -- GV plugin
        {"GL", ":GV", "full log" }, -- GV plugin
        {"Gm", ":Git checkout master", "checkout master" },
        {"Go", ":Git checkout", "checkout" },
        {"Gp", ":Git pull", "pull" },
        {"GP", ":Git push", "push" },
        {"Gr", ":Git rebase -i master", "rebase -i master" },
        {"Gs", function() telescope.git_status() end, "list changes" },
        {"GS", function() telescope.git_stash() end, "list stashes" },
        {"G-", ":Git checkout -", "checkout -" },
    }
    for _, map in pairs(git_maps) do
        git_keymap(unpack(map))
    end

    local mergetool_maps = {
        {"M1", ":MergetoolToggleLayout mr", "layout mr: MERGED-REMOTE" },
        {"M2", ":MergetoolToggleLayout ml", "layout ml: MERGED-LOCAL" },
        {"M3", ":MergetoolToggleLayout LmR", "layout LmR: LOCAL-MERGED-REMOTE" },
        {"M4", ":MergetoolToggleLayout mr,b", "layout mr,b: MERGED-REMOTE/BASE" },
        {"M5", ":MergetoolToggleLayout LBR", "layout LBR: LOCAL-BASE-REMOTE" },
        {"Ml", ":MergetoolDiffExchangeLeft", "get/put from/to RIGHT" },
        {"Mh", ":MergetoolDiffExchangeRight", "get/put from/to LEFT" },
        {"Mk", ":MergetoolDiffExchangeDown", "get/put from/to UP" },
        {"Mj", ":MergetoolDiffExchangeUp", "get/put from/to DOWN" },
        {"Mm", ":MergetoolPreferLocal", "use MINE/LOCAL for MERGED" },
        {"Mq", ":MergetoolStop", "quit merge-tool" },
        {"Mt", ":MergetoolPreferRemote", "use THEIR/REMOTE for MERGED" },
        {"Ms", ":MergetoolStart", "start merge-tool" },
        {"Mz", "<Plug>(MergetoolToggle)", "toggle merge-tool" },
    }
    for _, map in pairs(mergetool_maps) do
        git_keymap(unpack(map))
    end
end

return M

