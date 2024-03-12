return {
	"VonHeikemen/fine-cmdline.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},

	config = function()
		vim.keymap.set("n", "<CR>", ":FineCmdline<CR>", { noremap = true })
	end,
}
