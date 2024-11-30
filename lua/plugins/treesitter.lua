return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    local config = require 'nvim-treesitter.configs'
    config.setup {
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn", -- Start selection with 'gnn'
          node_incremental = "grn", -- Increment to the next node with 'grn'
          scope_incremental = "grc", -- Increment to the scope with 'grc'
          node_decremental = "grm", -- Decrement to the previous node with 'grm'
        },
      },
    }
  end,
}
