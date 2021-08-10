--vim.g.gitgutter_use_location_list = 1
vim.g.gitgutter_max_signs = -1

-- vim.cmd[[
-- function! GitStatus()
--   let [a,m,r] = GitGutterGetHunkSummary()
--   return printf('+%d ~%d -%d', a, m, r)
-- endfunction
-- set statusline+=%{GitStatus()}

-- command! Gqf GitGutterQuickFix | copen
-- ]]

