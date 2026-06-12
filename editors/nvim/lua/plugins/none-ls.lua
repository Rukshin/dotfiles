return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local helpers = require("null-ls.helpers")

    local ktfmt = helpers.make_builtin({
      name = "ktfmt",
      meta = { url = "https://github.com/facebook/ktfmt" },
      method = null_ls.methods.FORMATTING,
      filetypes = { "kotlin" },
      generator_opts = {
        command = "ktfmt",
        args = { "--kotlinlang-style", "-" },
        to_stdin = true,
      },
      factory = helpers.formatter_factory,
    })

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        ktfmt,
        null_ls.builtins.formatting.yamlfmt.with({ filetypes = { "yaml", "yaml.github" } }),
        null_ls.builtins.diagnostics.yamllint,
      },
    })
  end,
}
