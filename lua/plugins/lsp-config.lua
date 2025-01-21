return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_install = { "lua_ls", "gopls", "csharp_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			servers = {
				jdtls = {
					-- 1) Force the LSP to start with a specific version of Java (if needed)
					cmd = {
						-- Point this to the *older* Java you want to use, if that is supported
						"/usr/lib/jvm/java-11-openjdk/bin/java",

						-- Standard flags for Eclipse JDT LS
						"-Declipse.application=org.eclipse.jdt.ls.core.id1",
						"-Dosgi.bundles.defaultStartLevel=4",
						"-Declipse.product=org.eclipse.jdt.ls.core.product",
						"-Dlog.protocol=true",
						"-Dlog.level=ALL",
						"-Xms1g",
						"--add-modules=ALL-SYSTEM",
						"--add-opens",
						"java.base/java.util=ALL-UNNAMED",
						"--add-opens",
						"java.base/java.lang=ALL-UNNAMED",

						-- The jar file for the JDT LS launcher
						"-jar",
						"/path/to/eclipse.jdt.ls/plugins/org.eclipse.equinox.launcher_VERSION.jar",

						-- The config folder for JDT LS (e.g., config_linux, config_win, config_mac)
						"-configuration",
						"/path/to/eclipse.jdt.ls/config_linux",

						-- The workspace directory (change to whatever you like)
						"-data",
						vim.fn.stdpath("cache") .. "/jdtls-workspace",
					},
					-- 2) Inform JDT LS of the older Java versions for compilation
					settings = {
						java = {
							configuration = {
								-- The "runtimes" field tells JDT LS about different JDKs.
								-- It will let your code target these versions.
								runtimes = {
									{
										name = "JavaSE-1.8",
										path = "/usr/lib/jvm/java-8-openjdk",
									},
									{
										name = "JavaSE-11",
										path = "/usr/lib/jvm/java-11-openjdk-amd64",
									},
									-- If you’d like a default one for new projects, specify `default = true`.
									-- e.g. { name = "JavaSE-11", path = "/usr/lib/jvm/java-11-openjdk", default = true }
								},
							},
						},
					},
				},
			},
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.gopls.setup({
				capabilities = capabilities,
			})

			lspconfig.terraformls.setup({
				capabilities = capabilities,
			})

			lspconfig.jdtls.setup({
				capabilities = capabilities,
			})

			lspconfig.pyright.setup({
				capabilities = capabilities,
			})

			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
			})

			lspconfig.csharp_ls.setup({
				capabilities = capabilities,
			})

			lspconfig.tsserver.setup({
				capabilities = capabilities,
			})

      lspconfig.kotlin_language_server.setup({
        capabilities = capabilities
      })

      lspconfig.intelephense.setup({
        capabilities = capabilities
      })

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
