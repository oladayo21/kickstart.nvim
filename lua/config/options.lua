vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Lazyvim root dir detection
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- clipboard
opt.clipboard:append("unnamedplus")

opt.relativenumber = true
