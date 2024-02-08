require("config.options")
require("config.keymaps")

-- [[ Install lazy.nvim plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


--[[ Configure plugins ]]
require("lazy").setup({{ import = "plugins" }}, {
  performance = {
    rtp = {
      disabled_plugins = {
        "netrwPlugin"
      }
    }
  },
  change_detection = {
    notify = false,
  },
})
