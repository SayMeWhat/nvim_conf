return {
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<Leader>dt', function() require('dap').toggle_breakpoint() end, desc = 'DAP toggle breakpoint' },
      { '<Leader>dc', function() require('dap').continue() end, desc = 'DAP continue' },
    },
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap, dapui = require 'dap', require 'dapui'

      local function first_executable(candidates)
        for _, candidate in ipairs(candidates) do
          if candidate and candidate ~= '' then
            local path = vim.fn.expand(candidate)
            if vim.fn.executable(path) == 1 then
              return path
            end
          end
        end
      end

      local function first_glob(patterns)
        for _, pattern in ipairs(patterns) do
          local matches = vim.fn.glob(pattern, false, true)
          if #matches > 0 then
            return matches[1]
          end
        end
      end

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

      local debugpy = first_executable({
        '~/.virtualenvs/debugpy/bin/python',
        vim.fn.stdpath('data') .. '/mason/packages/debugpy/venv/bin/python',
        vim.fn.exepath 'python3',
        vim.fn.exepath 'python',
      })

      if debugpy then
        require('dap-python').setup(debugpy)
      end

      local java_debug_jar = first_glob({
        vim.fn.stdpath('data') .. '/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar',
      })

      if java_debug_jar then
        dap.adapters.java = function(callback)
          callback({
            type = 'server',
            host = '127.0.0.1',
            port = '${port}',
            executable = {
              command = 'java',
              args = {
                '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=127.0.0.1:${port}',
                '-jar',
                java_debug_jar,
              },
            },
          })
        end

        dap.configurations.java = {
          {
            type = 'java',
            request = 'launch',
            name = 'Launch Java class',
            cwd = '${workspaceFolder}',
            projectName = '${workspaceFolderBasename}',
            mainClass = function()
              return vim.fn.input 'Main class: '
            end,
          },
        }
      end
    end,
  },
}
