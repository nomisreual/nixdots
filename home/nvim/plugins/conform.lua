require("conform").setup({
	notify_on_error = false,
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},

	formatters_by_ft = {
		lua = { "stylua" },
		rust = { "rustfmt" },
		-- javascript = { "prettierd" },
		-- html = { "prettierd" },
		-- htmldjango = { "djlint" },
		-- sql = { "sql_formatter" },
		-- cs = { 'csharpier' },
		-- go = { "goimports", "gofumpt" },
		nix = { "nixpkgs_fmt" },
	},
})
