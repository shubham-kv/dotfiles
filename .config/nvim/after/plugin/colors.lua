
function SetColorScheme()
	-- color = color or 'onedark'
	color = color or 'tokyonight'
	vim.cmd.colorschem(color)
end

function SetTransparentBg()
	-- for transparent background
	vim.api.nvim_set_hl(0, 'Normal', {bg = 'none'})
	vim.api.nvim_set_hl(0, 'NormalFloat', {bg = 'none'})
end

SetColorScheme()
-- setTransparentBg()

