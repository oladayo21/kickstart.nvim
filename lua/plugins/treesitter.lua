return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {"lua","vim","bash","javascript","tsx","typescript","markdown"},
        auto_install = true,
        highlight = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        autotag = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>ss",
            node_incremental = "<leader>ss",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },

      })
    end
  }
}

