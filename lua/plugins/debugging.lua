
return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap-python',
      'mfussenegger/nvim-jdtls', -- Java support
    },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'
      dapui.setup()

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
      vim.keymap.set('n', '<Leader>dt', dap.toggle_breakpoint, {})
      vim.keymap.set('n', '<Leader>dc', dap.continue, {})

      -- Python setup
      require('dap-python').setup '~/.virtualenvs/debugpy/bin/python'

      -- Java setup
      dap.adapters.java = function(callback)
        -- adjust 'javaExec' and 'jdtlsLaunchArgs' according to your setup
        callback({
          type = 'server',
          host = '127.0.0.1',
          port = '${port}',
          executable = {
            command = 'java',
            args = { '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=127.0.0.1:${port}', '-jar', '/path/to/java-debug-adapter/target/com.microsoft.java.debug.plugin.jar' },
          }
        })
      end

      dap.configurations.java = {
        {
          type = 'java',
          request = 'launch',
          name = "Launch Java Program",
          mainClass = "${file}", -- Change this if necessary
          projectName = "MyProject", -- Adjust this to your project name
          -- You can set additional options as needed
        },
      }
    end,
  },
}

