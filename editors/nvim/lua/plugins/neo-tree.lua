return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = {
          position = "left",
          width = 35,
          mappings = {
            -- IntelliJ-style mappings
            ["<cr>"] = "open",
            ["<esc>"] = "cancel",
            ["s"] = "open_split",
            ["v"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["a"] = {
              "add",
              config = {
                show_path = "relative"
              }
            },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          },
        },
        filesystem = {
          follow_current_file = {
            enabled = true,
          },
          use_libuv_file_watcher = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })

      -- Toggle like IntelliJ Cmd+1 (Project view)
      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = "Toggle file explorer" })
      vim.keymap.set('n', '<leader>1', ':Neotree toggle<CR>', { noremap = true, silent = true, desc = "Toggle file explorer" })

      -- Focus file explorer
      vim.keymap.set('n', '<leader>o', ':Neotree focus<CR>', { noremap = true, silent = true, desc = "Focus file explorer" })
    end,
  }
}
