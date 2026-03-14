return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'catppuccin/nvim',
  },
  config = function()
    local theme = 'auto'
    local ok, catppuccin_lualine = pcall(require, 'catppuccin.utils.lualine')
    if ok then
      theme = catppuccin_lualine()
    end

    require('lualine').setup {
      options = {
        theme = theme,
      },
    }
  end,
}
