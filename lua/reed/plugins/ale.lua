return {
    'dense-analysis/ale',
    config = function()
        -- Configuration goes here.
        local g = vim.g

        g.ale_ruby_rubocop_auto_correct_all = 1

        g.ale_linters = {
            ruby = {'rubocop', 'ruby'},
            lua = {'lua_language_server'},
            typescript = {'ts_ls'},
        }
        g.ale_typescript_tsc_options = "--noEmit"

        -- Don’t lint automatically
        g.ale_lint_on_text_changed = "never"
        g.ale_lint_on_insert_leave = 0
        g.ale_lint_on_save = 0
        g.ale_lint_on_enter = 0

        -- Don’t touch loclist/quickfix automatically
        g.ale_set_loclist = 0
        g.ale_set_quickfix = 0
        g.ale_open_list = 0
        -- Helper to merge ALE and LSP diagnostics into quickfix
        local function populate_combined_quickfix()
          -- 1. Run ALE lint for current project (tsc)
          vim.cmd("ALELint")

          -- 2. Wait a short moment for ALE to finish async linting
          vim.defer_fn(function()
            -- Collect ALE results (if ALE is loaded)
            local ale_list = vim.fn  or {}
            local ale_items = {}

            for _, d in ipairs(ale_list) do
              if d.text and d.bufnr then
                table.insert(ale_items, {
                  bufnr = d.bufnr,
                  lnum = d.lnum or 1,
                  col = d.col or 1,
                  text = "[ALE] " .. d.text,
                })
              end
            end

            -- Collect LSP diagnostics for all buffers
            local lsp_items = vim.diagnostic.toqflist(
              vim.diagnostic.get(nil, { severity = { min = vim.diagnostic.severity.HINT } })
            )

            -- Combine both
            local all_items = {}
            for _, item in ipairs(ale_items) do table.insert(all_items, item) end
            for _, item in ipairs(lsp_items) do table.insert(all_items, item) end

            -- Populate quickfix
            vim.fn.setqflist({}, ' ', {
              title = 'ALE + LSP diagnostics',
              items = all_items,
            })

            vim.cmd("copen")
          end, 500) -- wait 0.5s for ALE to complete
        end
        vim.keymap.set("n", "<leader>qf", populate_combined_quickfix,
        { desc = "Populate quickfix with ALE + LSP errors"})
    end
}
