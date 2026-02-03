return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Mason setup for LSP server management
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })

      -- Mason-lspconfig bridge for automatic installation
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "jdtls" },
        automatic_installation = true,
      })

      -- LSP keybindings and handlers
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local opts = { buffer = args.buf }
          local telescope_builtin = require('telescope.builtin')

          -- IntelliJ-style navigation with Telescope

          -- Cmd+B / Ctrl+B - Go to Definition
          vim.keymap.set('n', 'gd', telescope_builtin.lsp_definitions,
            { buffer = args.buf, desc = "Go to definition" })
          vim.keymap.set('n', '<leader>gd', telescope_builtin.lsp_definitions,
            { buffer = args.buf, desc = "Go to definition" })

          -- Cmd+Alt+B - Go to Implementation
          vim.keymap.set('n', 'gi', telescope_builtin.lsp_implementations,
            { buffer = args.buf, desc = "Go to implementation" })
          vim.keymap.set('n', '<leader>gi', telescope_builtin.lsp_implementations,
            { buffer = args.buf, desc = "Go to implementation" })

          -- Cmd+Alt+F7 - Find Usages / References
          vim.keymap.set('n', 'gr', telescope_builtin.lsp_references,
            { buffer = args.buf, desc = "Go to references" })
          vim.keymap.set('n', '<leader>gr', telescope_builtin.lsp_references,
            { buffer = args.buf, desc = "Find usages" })

          -- Type definition
          vim.keymap.set('n', 'gt', telescope_builtin.lsp_type_definitions,
            { buffer = args.buf, desc = "Go to type definition" })
          vim.keymap.set('n', '<leader>gt', telescope_builtin.lsp_type_definitions,
            { buffer = args.buf, desc = "Go to type definition" })

          -- Ctrl+Q / Quick Documentation
          vim.keymap.set('n', 'K', vim.lsp.buf.hover,
            { buffer = args.buf, desc = "Hover documentation" })

          -- Shift+F6 - Rename
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,
            { buffer = args.buf, desc = "Rename symbol" })
          vim.keymap.set('n', '<F2>', vim.lsp.buf.rename,
            { buffer = args.buf, desc = "Rename symbol" })

          -- Alt+Enter - Code Action
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
            { buffer = args.buf, desc = "Code action" })
          vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action,
            { buffer = args.buf, desc = "Code action" })

          -- Diagnostics with Telescope
          vim.keymap.set('n', '<leader>fd', telescope_builtin.diagnostics,
            { buffer = args.buf, desc = "Show diagnostics" })
          vim.keymap.set('n', '<leader>xx', telescope_builtin.diagnostics,
            { buffer = args.buf, desc = "Show diagnostics" })

          -- Document symbols (like Cmd+F12 structure view)
          vim.keymap.set('n', '<leader>ds', telescope_builtin.lsp_document_symbols,
            { buffer = args.buf, desc = "Document symbols" })

          -- Workspace symbols (like Cmd+Alt+Shift+N)
          vim.keymap.set('n', '<leader>ws', telescope_builtin.lsp_workspace_symbols,
            { buffer = args.buf, desc = "Workspace symbols" })

          -- Navigate diagnostics
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,
            { buffer = args.buf, desc = "Previous diagnostic" })
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next,
            { buffer = args.buf, desc = "Next diagnostic" })

          -- Show line diagnostics
          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float,
            { buffer = args.buf, desc = "Show line diagnostics" })

          -- Signature help
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
            { buffer = args.buf, desc = "Signature help" })
          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help,
            { buffer = args.buf, desc = "Signature help" })

          -- Format code
          vim.keymap.set('n', '<leader>cf', function()
            vim.lsp.buf.format({ async = true })
          end, { buffer = args.buf, desc = "Format code" })
        end
      })

      -- Configure diagnostics display
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          source = "if_many",
        },
        float = {
          source = "always",
          border = "rounded",
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Customize diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- LSP handlers for better UI
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "rounded"
        }
      )

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help, {
          border = "rounded"
        }
      )

      -- Lua language server configuration using new vim.lsp.config API
      vim.lsp.config.lua_ls = {
        cmd = { 'lua-language-server' },
        root_markers = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
        filetypes = { 'lua' },
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
              }
            },
          },
        },
      }

      -- Java/Kotlin language server configuration using new vim.lsp.config API
      vim.lsp.config.jdtls = {
        cmd = { 'jdtls' },
        root_markers = { 'pom.xml', 'build.gradle', 'build.gradle.kts', '.git' },
        filetypes = { 'java', 'kotlin' },
        settings = {
          java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
              favoriteStaticMembers = {
                "org.junit.Assert.*",
                "org.junit.Assume.*",
                "org.junit.jupiter.api.Assertions.*",
                "org.junit.jupiter.api.Assumptions.*",
                "org.junit.jupiter.api.DynamicContainer.*",
                "org.junit.jupiter.api.DynamicTest.*",
              },
            },
            sources = {
              organizeImports = {
                starThreshold = 9999,
                staticStarThreshold = 9999,
              },
            },
          },
        },
      }

      -- Enable LSP servers for their filetypes
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('jdtls')
    end,
  }
}
