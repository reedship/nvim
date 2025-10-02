return {
    "neovim/nvim-lspconfig", -- optional, but gives you default configs
    config = function()
      -- on_attach callback: keymaps per buffer
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end

      -- capabilities (optional, if you use nvim-cmp or blink.cmp)
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Configure servers
      vim.lsp.config["lua_ls"] = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = { checkThirdParty = false },
            diagnostics = { globals = { "vim" } },
          },
        },
      }
      vim.lsp.enable("lua_ls")

      vim.lsp.config["ts_ls"] = {
        on_attach = on_attach,
        capabilities = capabilities,
        filetypes = {
          "javascript", "javascriptreact", "javascript.jsx",
          "typescript", "typescriptreact", "typescript.tsx",
        },
      }
      vim.lsp.enable("ts_ls")
      -- vim.lsp.config["eslint"] = {
      --   on_attach = on_attach,
      --   capabilities = capabilities,
      --   settings = {
      --     format = true,
      --     packageManager = "yarn",
      --     quiet = false,
      --     codeAction = {
      --       disableRuleComment = { enable = true, location = "separateLine" },
      --       showDocumentation = { enable = true },
      --     },
      --     rulesCustomizations = {},
      --     run = "onSave", -- or "onSave"
      --     validate = "on",
      --     workingDirectory = { mode = "auto" },
      --   },
      -- }
      -- vim.lsp.enable("eslint")
    end,
  }
