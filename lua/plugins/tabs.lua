return {
	"romgrk/barbar.nvim",
	dependecies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
  config = function ()
    require("barbar").setup({
      init = function() vim.g.barbar_auto_setup = false end,
      version = '^1.0.0'
    })
  end
}
