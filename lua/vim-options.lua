vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Set leader keys
vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = '%=%{v:relnum ? v:relnum : v:lnum} '

local uv = vim.uv or vim.loop
local os_name = uv.os_uname().sysname

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

if os_name == 'Windows_NT' then
  vim.o.shell = first_executable({
    'C:\\Program Files\\PowerShell\\7\\pwsh.exe',
    'pwsh.exe',
    'powershell.exe',
    'cmd.exe',
  }) or vim.o.shell
else
  vim.o.shell = first_executable({
    vim.env.SHELL,
    '/bin/zsh',
    '/usr/bin/zsh',
    '/bin/bash',
    '/usr/bin/bash',
    '/bin/sh',
  }) or vim.o.shell
end

vim.opt.clipboard = 'unnamedplus'

vim.keymap.set({ 'n', 'x' }, '<leader>y', [["+y]], { desc = 'Copy to system clipboard' })

local function paste_without_carriage_returns()
  vim.cmd.normal { '"+p', bang = true }
  vim.cmd [[silent keepjumps keeppatterns %s/\r//ge]]
end

vim.keymap.set('n', '<leader>p', paste_without_carriage_returns, {
  noremap = true,
  silent = true,
  desc = 'Paste from clipboard and strip CRLF',
})
