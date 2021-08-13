local M = {}
local pickers = require("telescope.builtin")

-- if in a git repo, use git_files(), otherwise find_files()
M.project_files = function()
    local opts = {}
    local ok = pcall(pickers.git_files, opts)
    if not ok then pickers.find_files(opts) end
end

M.search_dotfiles = function()
    pickers.find_files({
        -- show dotfiles, but ignore the .git directory
        find_command = {"rg", "--files", "--hidden", "--iglob", "!.git"},
        prompt_title = ". dotfiles .",
        cwd = "$HOME/dotfiles/"
    })
end

return M

