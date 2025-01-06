return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(args)
            local lspclient = vim.lsp.get_client_by_id(args.data.client_id)
            if not lspclient then return end
            if lspclient.supports_method('textDocument/formatting') then
              vim.api.nvim.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                  vim.lsp.buf.format({bufnr=args.buf, id = client.id})
                end
              })
            end
          end,
        })
        -- Keybindings for LSP functionality
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts) -- Go to Definition
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts) -- Go to References
      end
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      capabilities = capabilities
      require("lspconfig").lua_ls.setup {
        on_attach = on_attach,
      }
      require("lspconfig").ts_ls.setup {
        on_attach = on_attach,
        hostInfo = "neovim",
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" }
      }
    end
  }
}
