return {
  'windwp/nvim-ts-autotag',
  event = 'InsertEnter', -- Load when entering insert mode
  config = function()
    require('nvim-ts-autotag').setup {
      opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
      },
      per_filetype = {
        ['html'] = {
          enable_close = false,
        },
      },
    }
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- Ensure treesitter is installed
  },
}
