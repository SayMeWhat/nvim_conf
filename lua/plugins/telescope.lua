return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- Telescope key mapping
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

      -- Custom ditfiles picker function
      function _G.dotfiles()
        builtin.find_files {
          prompt_title = '< Dotfiles >',
          cwd = '~/',
          hidden = true,
        }
      end

      vim.api.nvim_set_keymap('n', '<leader>fd', ':lua dotfiles()<CR>', { noremap = true, silent = true })
      -- Create a Telescope command
      vim.api.nvim_create_user_command('TelescopeDotfiles', dotfiles, {})
    end,
  },
  {
    'nvim-telescope/telescope-ui-select.nvim',
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {},
          },
        },
      }
      require('telescope').load_extension 'ui-select'
    end,
  },
}
