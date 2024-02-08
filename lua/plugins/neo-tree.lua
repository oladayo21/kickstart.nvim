return {
  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    keys = {
      {
        "<leader>fe",
        function()
          require("neo-tree.command").execute({ toggle = true, })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
      -- {
      --   "<leader>ge",
      --   function()
      --     require("neo-tree.command").execute({ source = "git_status", toggle = true })
      --   end,
      --   desc = "Git explorer",
      -- },
      -- {
      --   "<leader>be",
      --   function()
      --     require("neo-tree.command").execute({ source = "buffers", toggle = true })
      --   end,
      --   desc = "Buffer explorer",
      -- },
      {
        "<leader>o",
        function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd "p"
          else
            vim.cmd.Neotree "focus"
          end
        end,
        desc = "Toggle Explorer Focus",
      }
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      if vim.fn.argc(-1) == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    -- opts = ,
    config = function()
      local icons = require("icons")
      local opts = {
        sources = { "filesystem", "buffers", "git_status", "document_symbols" },
        open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
        filesystem = {
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        window = {
          mappings = {
            ["<space>"] = "none",
            ["Y"] = function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
          },
        },
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          modified = {
            symbol = icons.ui.Plus,
            highlight = "NeoTreeModified"
          },
          git_status = {
            symbols = {
              added = icons.git.LineAdded,
              modified = icons.git.LineModified,
              unstaged = icons.git.FileUnstaged,
              staged = icons.git.FileStaged,
              untracked = icons.git.FileUntracked,
              ignored = icons.git.FileIgnored,
            }
          }
        },
      }
      local function on_move(data)
        Util.lsp.on_rename(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })

      require("neo-tree").setup(opts)
    end,
  },

}
