
local status, lualine = pcall(require, 'lualine')

if not status then
  vim.notify('lualine plugin not found')
  return
end

lualine.setup()

