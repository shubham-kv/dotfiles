-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
  sort = {
    sorter = 'case_sensitive',
  },
  view = {
    width = 35,
    adaptive_size = true
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false
  },
})

