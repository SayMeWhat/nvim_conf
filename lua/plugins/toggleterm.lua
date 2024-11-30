return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    config = function()
      -- Initialize and configure the toggleterm plugin
      require('toggleterm').setup {
        -- Configuration options
        size = 15,
        open_mapping = [[<leader>t]],
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = 'horizontal',
        close_on_exit = true,
        shell = vim.o.shell,
      }

      -- Set a key mapping for ToggleTerm
      vim.keymap.set('n', '<leader>t', ':ToggleTerm size=8 dir=~/desktop direction=horizontal name=desktop<cr>', {})
    end,
  },
}
