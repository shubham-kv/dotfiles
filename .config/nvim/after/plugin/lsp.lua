
-- Set up lsp zero
-- ================>
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(_client, bufnr)
	lsp_zero.default_keymaps({
		buffer = bufnr,
		preserve_mappings = false
	})
end)

lsp_zero.set_sign_icons({
	error = '✘',
	warn = '▲',
	hint = '⚑',
	info = '»'
})


-- Set up mason
-- =============>
require('mason').setup({})

require('mason-lspconfig').setup({
	ensure_installed = {
		'eslint',
		'jsonls',
		'vimls',
		'lua_ls',
		'clangd'
	},

	handlers = {
		function(server_name)
			-- require('lspconfig')[server_name].setup({})
      lsp_zero.default_setup(server_name)
		end,

		eslint = function()
			require('lspconfig').eslint.setup({
				on_attach = function(client, bufnr)
					print('hello from eslint setup')

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end
			})
		end,
	},
})


-- Set up nvim-cmp
-- ================>
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),

		-- Accept currently selected item. Set `select` to `false` to only confirm
		-- explicitly selected items.
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp_action.tab_complete(),
		['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' }, -- For luasnip users.
	}, {
		{ name = 'buffer' },
	})
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' },
	}, {
		{ name = 'buffer' },
	})
})
require("cmp_git").setup() ]] --

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	}),
	matching = { disallow_symbol_nonprefix_matching = false }
})


-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- we're configuring with mason-lspconfig so this is not needed
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
-- 	capabilities = capabilities
-- }

-- lspconfig.tsserver.setup({
-- 	capabilities = capabilities,
-- })

-- lspconfig.eslint.setup({
-- 	on_attach = function(client, bufnr)
-- 		vim.api.nvim_create_autocmd("BufWritePre", {
-- 			buffer = bufnr,
-- 			command = "EslintFixAll",
-- 		})
-- 	end
-- })
