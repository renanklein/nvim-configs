return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({})
		vim.keymap.set("n", "<A-3>", ":ToggleTerm direction=float<CR>", {})
	end,
}
