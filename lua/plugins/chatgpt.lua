return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  config = function()
    require("chatgpt").setup()
    vim.keymap.set("n", "<leader>tk", ":ChatGPT<CR>", {})
    vim.keymap.set("n", "<leader>tj", ":ChatGPTActAs<CR>", {})
    vim.keymap.set("n", "<leader>tt", ":ChatGPTEditWithInstructions<CR>", {})
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim",
  },
}
