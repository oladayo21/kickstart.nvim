return {
  {
    'AstroNvim/astrotheme',
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require('astrotheme').setup(opts)
      vim.cmd.colorscheme 'astrodark'
    end,
  },
}
