
local options = vim.opt


-- appearance
-- ===========>
options.termguicolors = true
options.background = 'dark'
options.signcolumn = 'yes'


-- line numbers
-- =============>
options.relativenumber = true
options.number = true


-- tabs & indentations
-- ====================>
options.tabstop = 4
options.shiftwidth = 4
options.expandtab = false
options.autoindent = true
options.smartindent = true


-- behavior
-- ==============>
options.wrap = false


-- windows
options.splitright = true
options.splitbelow = true


-- search
-- ================>
options.ignorecase = true
options.smartcase = true
options.incsearch = false
options.hlsearch = false


-- cursor line
-- ============>
options.cursorline = true


-- others
-- =======>
options.scrolloff = 2
options.backspace = 'indent,eol,start'
-- options.clipboard:append('unnamedplus')

