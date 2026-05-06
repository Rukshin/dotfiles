return {
  {
    'nvim-telescope/telescope.nvim',
    tag = 'v0.2.1',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              preview_width = 0.55,
            },
          },
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
          }
        }
      })

      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')

      vim.keymap.set('n', '<C-p>', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set('n', '<leader>/', builtin.live_grep, { desc = "Search in project" })
      vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "Recent files" })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "Buffers" })
      vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = "Commands" })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = "Keymaps" })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = "Grep string under cursor" })
      vim.keymap.set('n', '<leader>f.', builtin.resume, { desc = "Resume last picker" })
      vim.keymap.set('n', '<leader>ft', builtin.treesitter, { desc = "Treesitter symbols" })
      vim.keymap.set('n', '<leader>gf', builtin.git_files, { desc = "Git files" })
      vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = "Git commits" })
      vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = "Git status" })
    end
  },
}
