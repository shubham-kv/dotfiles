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
options.tabstop = 2
options.shiftwidth = 2
options.expandtab = true
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
options.hlsearch = false
options.incsearch = true
options.ignorecase = true
options.smartcase = true


-- cursor line
-- ============>
options.cursorline = true


-- others
-- =======>
options.scrolloff = 4
options.updatetime = 100
options.backspace = 'indent,eol,start'
-- options.clipboard:append('unnamedplus')
