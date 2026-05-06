return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      integrations = {
        treesitter = true,
        telescope = { enabled = true },
        neo_tree = true,
        mason = true,
        lsp_trouble = false,
      },
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
