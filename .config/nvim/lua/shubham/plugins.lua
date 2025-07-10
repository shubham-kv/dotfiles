-- this file can be loaded by calling `lua require('plugins')`

local ensure_packer_installation = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end

	return false
end

local packer_installed = ensure_packer_installation()
local status, packer = pcall(require, 'packer')

if not status then
	vim.notify('packer not found!')
	return
end

return packer.startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'nvim-lua/plenary.nvim'

	-- fuzzy find
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- ast
	use 'nvim-treesitter/playground'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- file tree explorers
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional
		},
	}

	-- undo history visualizer
	use 'mbbill/undotree'

	-- lsp
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		requires = {
			--- lsp support
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
			{'neovim/nvim-lspconfig'},

			-- autocompletion
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'},
			{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-cmdline'},
			{'hrsh7th/nvim-cmp'},

			-- snippets
			{'L3MON4D3/LuaSnip'},
			{'saadparwaiz1/cmp_luasnip'},
			{'rafamadriz/friendly-snippets'}
		}
	}

	-- renderers
	use({
		'MeanderingProgrammer/render-markdown.nvim',
		after = { 'nvim-treesitter' },
		-- requires = { 'echasnovski/mini.nvim', opt = true }, -- if you use the mini.nvim suite
		-- requires = { 'echasnovski/mini.icons', opt = true }, -- if you use standalone mini plugins
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
		config = function()
			require('render-markdown').setup({})
		end,
	})

	-- autocompletion
	use 'jiangmiao/auto-pairs'

  -- Diagnostics
  use {
    "chikko80/error-lens.nvim",
    requires = { "nvim-telescope/telescope.nvim" }, -- optional
    config = function()
      require("error-lens").setup()
    end,
  }

	-- git
	use 'airblade/vim-gitgutter'
	use 'tpope/vim-fugitive'

	-- colorschems
	use 'folke/tokyonight.nvim'
	use 'olimorris/onedarkpro.nvim'

	-- status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	-- distraction free
	-- use 'junegunn/goyo.vim' -- doesn't seem good with nvim, status line still stays in :Goyo mode

	if packer_installed then
		require('packer').sync()
	end
end)

