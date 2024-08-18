return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local builtin = require 'telescope.builtin'
      local telescope = require 'telescope'

      telescope.setup {
        defaults = {
          file_ignore_patterns = {
            '%.bin',        -- Ignore binary files
            '%.exe',        -- Ignore executable files
            '%.o',          -- Ignore object files
            'node_modules', -- Ignore node_modules directory
            '%.class',      -- Ignore Java class files
            '%.jar',        -- Ignore Java JAR files
            '%.pdf',        -- Ignore PDF files
            '%.zip',        -- Ignore ZIP files
            '%.log',        -- Ignore log files
            '%.db',         -- Ignore database files
            '%.png',        -- Ignore image files
            '%.jpg',        -- Ignore image files
            '%.jpeg',       -- Ignore image files
            '%.svg',        -- Ignore SVG files
            '%.gif',        -- Ignore GIF files
          },
        },
      }

      -- Telescope key mapping
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
      vim.keymap.set('n', '<leader>km', builtin.keymaps, {})

      -- Custom dotfiles picker function
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
