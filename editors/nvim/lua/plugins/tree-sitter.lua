return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      options = {
        ensure_installed = { "lua", "java", "kotlin", "javascript", "typescript", "bash", "go" },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end
}
