return { -- Autoformat
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },

    formatters_by_ft = {
      lua = { 'stylua' },
      python = function(bufnr)
        if require('conform').get_formatter_info('ruff_format', bufnr).available then
          return { 'ruff_format' }
        else
          return { 'isort', 'black' }
        end
      end,
      javascript = { { 'prettierd', 'prettier' } },
      -- html = { { 'prettierd', 'prettier' } },
      htmldjango = { 'djlint' },
      sql = { 'sql_formatter' },
      -- cs = { 'csharpier' },
      go = { 'goimports', 'gofumpt' },
      nix = { 'nixpkgs_fmt' },
    },
  },
}
