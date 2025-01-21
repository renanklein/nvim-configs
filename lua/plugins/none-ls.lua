return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.pyink,
        null_ls.builtins.formatting.csharpier,
        null_ls.builtins.formatting.google_java_format,
        null_ls.builtins.formatting.ktlint,
        null_ls.builtins.formatting.phpcbf
			},
		})
		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
