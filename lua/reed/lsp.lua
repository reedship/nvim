vim.diagnostic.config({ virtual_text = true })
-- Configure ts_ls
vim.lsp.config("ts_ls", {
  -- `on_attach` is a function called when the language server attaches to a buffer
  on_attach = function(client, bufnr)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'grr', vim.lsp.buf.references, { noremap = true, silent = true, buffer = bufnr })
    -- vim.keymap.set('n', 'gws', vim.lsp.buf.workspace_symbol, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set('n', '<leader>ca', '<cmd>LspTypescriptSourceAction<cr>', { noremap = true, silent = true, buffer = bufnr })
    client.server_capabilities.semanticTokensProvider = nil
  end,

  -- Define the filetypes that `ts_ls` will be used for
  filetypes = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
  },
  root_markers = {
    "tsconfig.json",
    "package.json",
    "jsconfig.json",
    ".git",
  },
  root_dir = function(bufnr, on_dir)
    -- The project root is where the LSP can be started from
    -- As stated in the documentation above, this LSP supports monorepos and simple projects.
    -- We select then from the project root, which is identified by the presence of a package
    -- manager lock file.
    local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
    -- Give the root markers equal priority by wrapping them in a table
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
      or vim.list_extend(root_markers, { '.git' })
    -- exclude deno
    local deno_root = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc' })
    local deno_lock_root = vim.fs.root(bufnr, { 'deno.lock' })
    local project_root = vim.fs.root(bufnr, root_markers)
    if deno_lock_root and (not project_root or #deno_lock_root > #project_root) then
      -- deno lock is closer than package manager lock, abort
      return
    end
    if deno_root and (not project_root or #deno_root >= #project_root) then
      -- deno config is closer than or equal to package manager lock, abort
      return
    end
    -- project is standard TS, not deno
    -- We fallback to the current working directory if no project root is found
    on_dir(project_root or vim.fn.getcwd())
  end,

  -- Command to start the language server
  cmd = { "typescript-language-server", "--stdio" },

  -- Settings for `ts_ls`
  settings = {
    -- Example: configure implicit project configuration
    implicitProjectConfiguration = {
      checkJs = true,
      noErrorTruncation = true
    },
    inlayHints = {
      includeInlayParameterNameHints = 'all',
      includeInlayVariableTypeHints = true,
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

local eslint_config_files = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
  'eslint.config.mjs',
  'eslint.config.cjs',
  'eslint.config.ts',
  'eslint.config.mts',
  'eslint.config.cts',
}
vim.lsp.config('eslint',{
  cmd = {
    "vscode-eslint-language-server",
    "--stdio"
  },

  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "svelte",
    "astro",
    "htmlangular"
  },

  root_dir = function(bufnr, on_dir)
    -- The project root is where the LSP can be started from
    -- As stated in the documentation above, this LSP supports monorepos and simple projects.
    -- We select then from the project root, which is identified by the presence of a package
    -- manager lock file.
    local root_markers = {
      'package-lock.json',
      'yarn.lock',
      'pnpm-lock.yaml',
      'bun.lockb',
      'bun.lock'
    }

    -- dont run eslint in node_modules at all
    local filename = vim.api.nvim_buf_get_name(bufnr)
    if filename:match("node_modules") then
      return
    end

    -- Give the root markers equal priority by wrapping them in a table
    root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
    or vim.list_extend(root_markers, { '.git' })

    -- exclude deno
    if vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' }) then
      return
    end

    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

    local filename = vim.api.nvim_buf_get_name(bufnr)
    local is_buffer_using_eslint = vim.fs.find(eslint_config_files, {
      path = filename,
      upward = true,
      limit = 1,
    })[1]

    if not is_buffer_using_eslint then
      return
    end

    on_dir(project_root)
  end,
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspEslintFixAll', function()
      client:request_sync('workspace/executeCommand', {
        command = 'eslint.applyAllFixes',
        arguments = {
          {
            uri = vim.uri_from_bufnr(bufnr),
            version = vim.lsp.util.buf_versions[bufnr],
          },
        },
      }, nil, bufnr)
    end, {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "LspEslintFixAll",
    })
  end,

  before_init = function(_, config)
    -- The "workspaceFolder" is a VSCode concept. It limits how far the
    -- server will traverse the file system when locating the ESLint config
    -- file (e.g., .eslintrc).
    local root_dir = config.root_dir

    if root_dir then
      config.settings = config.settings or {}
      config.settings.workspaceFolder = {
        uri = root_dir,
        name = vim.fn.fnamemodify(root_dir, ':t'),
      }

      -- Support Yarn2 (PnP) projects
      -- local pnp_cjs = root_dir .. '/.pnp.cjs'
      -- local pnp_js = root_dir .. '/.pnp.js'
      -- if type(config.cmd) == 'table' and (vim.uv.fs_stat(pnp_cjs) or vim.uv.fs_stat(pnp_js)) then
      --   config.cmd = vim.list_extend({ 'yarn', 'exec' }, config.cmd --[[@as table]])
      -- end
    end
  end,

  handlers = {
    ['eslint/openDoc'] = function(_, result)
      if result then
        vim.ui.open(result.url)
      end
      return {}
    end,
    ['eslint/confirmESLintExecution'] = function(_, result)
      if not result then
        return
      end
      return 4 -- approved
    end,
    ['eslint/probeFailed'] = function()
      vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
      return {}
    end,
    ['eslint/noLibrary'] = function()
      vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
      return {}
    end,
  },

  settings = {
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine"
      },
      showDocumentation = {
        enable = true
      }
    },
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
    experimental = {
      useFlatConfig = false,
    },
    format = true,
    nodePath = "",
    onIgnoredFiles = "off",
    problems = {
      shortenToSingleLine = false
    },
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "location"
    }
  }
})
-- Define the server configuration
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.work', 'go.mod', '.git' },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
  -- Add this to init.lua for auto-formatting and organizing imports
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
      -- Organize imports
      vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
      -- Format
      vim.lsp.buf.format({ async = false })
    end,
  })

})

vim.lsp.enable({
  "ts_ls",
  "lua_ls",
  "eslint",
  "gopls"
})
