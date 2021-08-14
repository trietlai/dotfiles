require('nvim-autopairs').setup()
-- Break line on HTML or inside pairs

local npairs = require('nvim-autopairs')
local M = {}

vim.g.completion_confirm_key = ""
-- M.completion_confirm = function()
--     if vim.fn.pumvisible() ~= 0  then
--         if vim.fn.complete_info()["selected"] ~= -1 then
--             vim.fn["compe#confirm"]()
--             return npairs.esc("<c-y>")
--         else
--             vim.defer_fn(function()
--                 vim.fn["compe#confirm"]("<cr>")
--             end, 20)
--             return npairs.esc("<c-n>")
--         end
--     else
--         return npairs.check_break_line_char()
--     end
-- end
M.completion_confirm = function()
    if vim.fn.pumvisible() ~= 0  then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"](npairs.esc("<cr>"))
        else
            return npairs.esc("<cr>")
        end
    else
        return npairs.autopairs_cr()
    end
end

return M

