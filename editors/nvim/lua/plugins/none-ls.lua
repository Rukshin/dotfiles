return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.ktfmt,
        null_ls.builtins.formatting.yamlfmt.with({ filetypes = { "yaml", "yaml.github" } }),
        null_ls.builtins.diagnostics.yamllint,
      },
    })
  end,
}
