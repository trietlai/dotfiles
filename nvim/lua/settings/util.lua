
local M = {}

function M.keymap(mode, lhs, rhs, desc, opts)
    local noremap = true
    if (type(rhs) == 'string') then
        if (string.sub(rhs, 1, 1) == ":") then
            rhs = "<cmd>" .. rhs .. "<CR>"
        elseif (string.sub(rhs, 1, 6) == "<Plug>") then
            noremap = false
        end
    end
    local options = { noremap = noremap, silent = true, desc = desc }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    -- vim.print("DEBUG: keymap: " .. desc .. " - " .. lhs)
    vim.keymap.set(mode, lhs, rhs, options)
end

return M

