vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {}

-- Lazy.nvim config --
require("lazy").setup("plugins")

-- Catppuccin config --
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

-- Treesitter config --

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"lua", "javascript", "go", "rust", "java", "python"},
  highlight = { enable = true },
  indent = { enable = true }
})
