vim.lsp.enable({
  "ts_ls",
  "lua_ls"
})
vim.diagnostic.config({ virtual_text = true })
-- Configure ts_ls
vim.lsp.config("ts_ls", {
  -- `on_attach` is a function called when the language server attaches to a buffer
  on_attach = function(client, bufnr)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr })
    client.server_capabilities.semanticTokensProvider = nil
  end,

  -- Define the filetypes that `ts_ls` will be used for
  filetypes = {
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "javascript",
    "javascriptreact",
  },

  -- Command to start the language server
  cmd = { "typescript-language-server", "--stdio" },

  -- Settings for `ts_ls`
  settings = {
    -- Example: configure implicit project configuration
    implicitProjectConfiguration = {
      checkJs = true,
    },
  },
})
vim.lsp.config('lua_ls', {
    cmd = { 'lua-language-server' },
    on_attach = function(client, _)
      client.server_capabilities.semanticTokensProvider = nil
    end,
    filetypes = { 'lua' },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.luacheckrc',
        '.stylua.toml',
        'stylua.toml',
        'selene.toml',
        'selene.yml',
        '.git',
    },
    settings = {
        Lua = {
            runtime = {
                version = "Lua 5.4",
            },
            completion = {
                enable = true,
            },
            diagnostics = {
                enable = true,
                globals = { "vim" },
            },
            workspace = {
                library = { vim.env.VIMRUNTIME },
                checkThirdParty = false,
            },
        },
    },})
