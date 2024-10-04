require("conform").setup({
	notify_on_error = false,
	format_on_save = {
		timeout_ms = 500,
		lsp_fallback = true,
	},

	formatters_by_ft = {
		lua = { "stylua" },
		-- python = function(bufnr)
		-- 	if require("conform").get_formatter_info("ruff", bufnr).available then
		-- 		return { "ruff format" }
		-- 	else
		-- 		return { "isort", "black" }
		-- 	end
		-- end,
		javascript = { { "prettierd", "prettier" } },
		-- html = { { 'prettierd', 'prettier' } },
		htmldjango = { "djlint" },
		sql = { "sql_formatter" },
		-- cs = { 'csharpier' },
		go = { "goimports", "gofumpt" },
		nix = { "nixpkgs_fmt" },
	},
})
