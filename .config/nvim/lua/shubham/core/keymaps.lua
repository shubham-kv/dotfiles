local keymap = vim.keymap
vim.g.mapleader = " "

keymap.set("n", "<leader>p", vim.cmd.NvimTreeToggle)

-- tab keymaps
-- ============>
keymap.set('n', '<leader>tn', ':tabnew<CR>')
keymap.set('n', '<leader>tx', ':tabclose<CR>')
keymap.set('n', '<leader>th', ':tabprevious<CR>')
keymap.set('n', '<leader>tl', ':tabnext<CR>')
