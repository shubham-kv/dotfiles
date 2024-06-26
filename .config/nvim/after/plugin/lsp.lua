
local status, lsp_zero = pcall(require, 'lsp-zero')

if not status then
	vim.notify('lsp-zero not found!')
end

lsp_zero.on_attach(function(client, bufnr)
	lsp_zero.default_keymaps({
		buffer = bufnr,
		preserve_mappings = false
	})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'tsserver'
	},
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	},
})

