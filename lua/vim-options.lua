-- Set up tabs and spaces
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Set leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set number line for files 
vim.cmd("set number")

-- Set  global  terminal 
vim.o.shell = "C:\\Program Files\\PowerShell\\7\\pwsh.exe"
