
function setColorScheme()
	color = color or 'tokyonight'
	vim.cmd.colorschem(color)
end

function setTransparentBg()
	-- for transparent background
	vim.api.nvim_set_hl(0, 'Normal', {bg = 'none'})
	vim.api.nvim_set_hl(0, 'NormalFloat', {bg = 'none'})
end

-- setColorScheme()
-- setTransparentBg()

