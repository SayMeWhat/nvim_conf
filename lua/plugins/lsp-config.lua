return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require 'lspconfig'

      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
      }

      lspconfig.pyright.setup {
        capabilities = capabilities,
      }
      lspconfig.jdtls.setup {
        capabilities = capabilities,
        cmd = { 'jdtls' },
      }

      vim.diagnostic.config {
        virtual_text = false,
      }

      -- Show line diagnostics automatically in hover window
      vim.o.updatetime = 250
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, {})
      vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, {})
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
    end,
  },
}
