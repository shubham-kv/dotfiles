-- Diagnostics with virtual text
vim.diagnostic.config({
  virtual_text = {
    prefix = '',    -- Customize prefix (●, →, » etc.)
    spacing = 2,    -- Space between text and virtual text
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
  signs = true,             -- Show signs in the gutter
  underline = true,         -- Underline errors/warnings
  update_in_insert = false, -- Don't update while typing (prevents flicker)
  severity_sort = true,     -- Sort by severity
})

local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "»" }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
