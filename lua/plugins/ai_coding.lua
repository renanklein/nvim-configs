return {
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		opts = {
			provider = "copilot",
			copilot = {
				model = "claude-sonnet-4",
				endpoint = "https://api.githubcopilot.com",
				allow_insecure = false,
				timeout = 10 * 60 * 1000,
				max_completion_tokens = 1000000,
				reasoning_effort = "high",
			},
			mcp = {
				enabled = true,
				auto_start = true,
				config = {
					make_vars = true,
					make_slash_commands = true,
					show_result_in_chat = true,
				},
			},
		},
		build = "make",
		config = function(_, opts)
			require("avante").setup(vim.tbl_deep_extend("force", opts, {
				system_prompt = function()
					local hub = require("mcphub").get_hub_instance()
					return hub and hub:get_active_servers_prompt() or ""
				end,
				custom_tools = function()
					return {
						require("mcphub.extensions.avante").mcp_tool(),
					}
				end,
			}))

			require("mcphub").setup({
				extensions = {
					avante = {
						make_slash_commands = true, -- make /slash commands from MCP server prompts
					},
				},
			})

			-- Set up keymaps
			vim.keymap.set({ "n", "v" }, "<leader>aa", function()
				require("avante.api").ask()
			end, { desc = "Avante: Ask AI", noremap = true, silent = true })

			vim.keymap.set("v", "<leader>ae", function()
				require("avante.api").edit()
			end, { desc = "Avante: Edit selection", noremap = true, silent = true })

			vim.keymap.set("n", "<leader>ar", function()
				require("avante.api").refresh()
			end, { desc = "Avante: Refresh", noremap = true, silent = true })

			vim.keymap.set("n", "<leader>af", function()
				require("avante.api").focus()
			end, { desc = "Avante: Focus", noremap = true, silent = true })

			-- MCP Hub keymaps (check if mcphub is available)
			local mcphub_ok, _ = pcall(require, "mcphub")
			if mcphub_ok then
				vim.keymap.set("n", "<leader>mc", function()
					require("mcphub").connect()
				end, { desc = "MCP Hub: Connect", noremap = true, silent = true })

				vim.keymap.set("n", "<leader>md", function()
					require("mcphub").disconnect()
				end, { desc = "MCP Hub: Disconnect", noremap = true, silent = true })

				vim.keymap.set("n", "<leader>ms", function()
					require("mcphub").status()
				end, { desc = "MCP Hub: Status", noremap = true, silent = true })
			end
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"echasnovski/mini.pick",
			"nvim-telescope/telescope.nvim",
			"hrsh7th/nvim-cmp",
			"ibhagwan/fzf-lua",
			"nvim-tree/nvim-web-devicons",
			"zbirenbaum/copilot.lua",
			"ravitemer/mcphub.nvim",
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				"MeanderingProgrammer/render-markdown.nvim",
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	}, -- Avante.nvim for advanced AI coding assistance
}
