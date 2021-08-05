vim.g.nvim_tree_width = 40
vim.g.nvim_tree_hijack_cursor = 0
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_follow = 1 -- "0 by default, this option allows the cursor to be updated when entering a buffer
vim.g.nvim_tree_gitignore = 0
vim.g.nvim_tree_auto_ignore_ft = {'startify', 'dashboard'}
vim.g.nvim_tree_highlight_opened_files = 3
vim.g.nvim_tree_icons = {
  default = '',
  symlink = '',
  git = {unstaged = "✗", staged = "✓", unmerged = "", renamed = "➜", untracked = "★", deleted = ""},
  folder = {default = "", open = "", empty = "", empty_open = "", symlink = ""}
}
