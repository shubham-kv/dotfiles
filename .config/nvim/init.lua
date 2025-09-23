-- vim:fileencoding=utf-8:foldmethod=marker:foldmarker=-\ {{,}}

--
-- # NVIM Config
--
-- Plugins managed with `lewis6991/pckr.nvim`. After cloning/installing the
-- packages run `helptags ALL` to generate help tags.
--
--

-- Editor Optons ---------------- {{

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.hlsearch = false

vim.o.cursorline = true
vim.o.signcolumn = "yes"

vim.o.scrolloff = 2
vim.o.splitright = true
vim.o.splitbelow = true

-- disable netrw at the very start
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- }}

-- Plugins ------------------------ {{

local function safe_require(name, opts)
  local ok, mod = pcall(require, name)

  if not ok then
    vim.api.nvim_err_writeln("Failed to load module '" .. name .. "'")
    return
  end

  if type(opts) == "function" then
    opts(mod)
  elseif type(mod.setup) == "function" then
    mod.setup(opts or {})
  end
end

local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/lewis6991/pckr.nvim",
      pckr_path,
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end

bootstrap_pckr()

safe_require("pckr", function(pckr)
  pckr.add({
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",

    -- Colorschemes
    "folke/tokyonight.nvim",

    -- File explorer & navigation
    {
      "nvim-tree/nvim-tree.lua",
      requires = { "nvim-tree/nvim-web-devicons" },
      config = function()
        safe_require("nvim-tree", {
          renderer = { group_empty = true },
          sort = { sorter = "case_sensitive" },
          view = { width = 40, adaptive_size = true },
          filters = { dotfiles = false, git_ignored = false },
          update_focused_file = { enable = true, update_root = false },
        })
      end,
    },

    {
      "nvim-mini/mini.nvim",
      config = function()
        -- Quick navigation
        safe_require("mini.pick")

        -- Code completion
        safe_require("mini.snippets")
        safe_require("mini.completion")
        safe_require("mini.pairs")

        -- Git
        safe_require("mini.git")
        safe_require("mini.diff", {
          view = {
            style = "sign",
            signs = { add = "+", change = "~", delete = "-" },
          },
        })

        -- Appearance
        safe_require("mini.statusline")
      end,
    },

    -- Syntax highlighting
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        safe_require("nvim-treesitter.configs", {
          auto_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
    },

    -- LSPs, Formatting, etc.
    "neovim/nvim-lspconfig",

    {
      "mason-org/mason.nvim",
      config = function()
        safe_require("mason")
      end,
    },

    -- Diagnostics, Code actions, etc.
    {
      "nvimtools/none-ls.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        safe_require("null-ls", function(null_ls)
          null_ls.setup({
            sources = {
              null_ls.builtins.diagnostics.markdownlint,

              -- write-good for weasel words/passive voice
              null_ls.builtins.diagnostics.write_good.with({
                filetypes = { "markdown", "text" },
                extra_args = { "--no-passive" },
              }),

              null_ls.builtins.formatting.stylua,
              null_ls.builtins.formatting.markdownlint,
              null_ls.builtins.formatting.prettierd.with({
                disabled_filetypes = { "markdown" },
              }),
            },
          })
        end)
      end,
    },

    -- Distraction free
    "folke/zen-mode.nvim",
  })
end)

-- }}

-- Theme ------------------------ {{

local theme = "tokyonight"
local ok = pcall(vim.cmd.colorscheme, theme)

if not ok then
  print("Failed to set '" .. theme .. "' colorscheme")
end

-- }}

-- Keymaps ------------------------ {{

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>s", "<cmd>source %<cr>", { desc = "Read Vim or Ex commands from current file" })
vim.keymap.set("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<cr>", { desc = "Close current window" })
vim.keymap.set("n", "<leader>nw", function()
  local date = vim.fn.system('date -R'):gsub("\n$", "")
  vim.api.nvim_put({date}, 'c', false, true)
end, { desc = "Paste timestamp" })

vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>th", "<cmd>tabprevious<cr>", { desc = "Open previous tab to the left" })
vim.keymap.set("n", "<leader>tl", "<cmd>tabnext<cr>", { desc = "Open next tab to the right" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<cr>", { desc = "Close current tab" })

vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.open_float(nil, { focus = true })
end, { desc = "Show diagnostics under cursor" })

vim.keymap.set("n", "<leader>p", vim.cmd.NvimTreeToggle)

vim.keymap.set("n", "<leader>fb", "<cmd>Pick buffers<cr>", { desc = "Search open buffers" })
vim.keymap.set("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "Search all files" })
vim.keymap.set("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "Search through help" })
vim.keymap.set("n", "<leader>fg", "<cmd>Pick grep_live<cr>", { desc = "Grep through files" })

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "Toggle zenmode" })

-- }}

-- LSP Setup ---------------------- {{

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    -- Display documentation of the symbol under the cursor
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

    -- Jump to the definition
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)

    -- Format current file
    vim.keymap.set({ "n", "x" }, "gq", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)

    -- Displays a function's signature information
    vim.keymap.set("i", "<C-s>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

    -- Jump to declaration
    vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)

    -- Lists all the implementations for the symbol under the cursor
    vim.keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)

    -- Jumps to the definition of the type symbol
    vim.keymap.set("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)

    -- Lists all the references
    vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)

    -- Renames all references to the symbol under the cursor
    vim.keymap.set("n", "<leader>ln", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

    -- Selects a code action available at the current cursor position
    vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  end,
})

-- Use the "legacy setup" on older Neovim version.
-- The new api is only available on Neovim v0.11 or greater.
local function lsp_setup(server, opts)
  if vim.fn.has("nvim-0.11") == 0 then
    safe_require("lspconfig", function(lspconfig)
      lspconfig[server].setup(opts)
    end)
    return
  end

  if not vim.tbl_isempty(opts) then
    vim.lsp.config(server, opts)
  end

  vim.lsp.enable(server)
end

lsp_setup("vimls", {})
lsp_setup("lua_ls", {
  settings = { Lua = { diagnostics = { globals = { "vim" } } } },
})
lsp_setup("clangd", {})

lsp_setup("html", {})
lsp_setup("cssls", {})
lsp_setup("ts_ls", {})
lsp_setup("jsonls", {})

lsp_setup("marksman", {})
-- lsp_setup('rust_analyzer', {})

-- }}

-- Configurations ----------------- {{

-- Diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = "",  -- Customize prefix (●, →, » etc.)
    spacing = 2,  -- Space between text and virtual text
    severity = nil, -- Show all severities (can set to vim.diagnostic.severity.ERROR if needed)
    format = function(diagnostic)
      local icons = {
        [vim.diagnostic.severity.ERROR] = "✘",
        [vim.diagnostic.severity.WARN] = "▲",
        [vim.diagnostic.severity.INFO] = "»",
        [vim.diagnostic.severity.HINT] = "⚑",
      }
      return icons[diagnostic.severity] .. " " .. diagnostic.message
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.INFO] = "»",
      [vim.diagnostic.severity.HINT] = "⚑",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },                       -- Show signs in the gutter
  underline = true,        -- Underline errors/warnings
  update_in_insert = false, -- Don't update while typing (prevents flicker)
  severity_sort = true,    -- Sort by severity
})

-- }}
