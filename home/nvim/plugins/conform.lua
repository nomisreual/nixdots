require("conform").setup({
	notify_on_error = false,
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},

	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		python = {
			exe = "ruff",
			args = { "format" },
			lsp_format = "never",
		},
		-- javascript = { "prettierd" },
		-- html = { "prettierd" },
		-- htmldjango = { "djlint" },
		-- sql = { "sql_formatter" },
		-- cs = { 'csharpier' },
		-- go = { "goimports", "gofumpt" },
		nix = { "nixpkgs_fmt" },
	},
})
