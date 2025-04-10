-- filepath: /home/renanklein/projects/nvim-configs/lua/plugins/ai_coding.lua
return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- GitHub Copilot configuration
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
      vim.api.nvim_set_keymap("i", "<C-k>", 'copilot#Previous()', { silent = true, expr = true })
      vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Next()', { silent = true, expr = true })
      vim.api.nvim_set_keymap("i", "<C-o>", 'copilot#Dismiss()', { silent = true, expr = true })
    end,
  },
  
  -- Avante.nvim for advanced AI coding assistance
  {
    "avante/nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("avante").setup({
        -- Configure for GitHub Copilot
        provider = "github-copilot",
        
        -- Configure Claude 3.7 Sonnet as the model
        model = "claude-3-7-sonnet-20240229",
        
        -- Additional configuration
        keymaps = {
          toggle = "<leader>ai", -- Toggle Avante
          execute = "<leader>ae", -- Execute AI command
          complete = "<leader>ac", -- Request completion
          explain = "<leader>ax",  -- Explain code
        },
        
        -- UI customization
        ui = {
          border = "rounded",
          width = 0.8,   -- 80% of screen width
          height = 0.7,  -- 70% of screen height
          position = "center",
        },
        
        -- Context settings
        context = {
          lines_before = 30,  -- Include 30 lines before cursor
          lines_after = 30,   -- Include 30 lines after cursor
          include_diagnostics = true,
        },
      })
      
      -- Add custom keymaps
      vim.keymap.set("n", "<leader>ag", ":AvanteGenerate<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>af", ":AvanteFixCode<CR>", { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>ad", ":AvanteCodeDoc<CR>", { noremap = true, silent = true })
      vim.keymap.set("v", "<leader>ar", ":AvanteRefactor<CR>", { noremap = true, silent = true })
    end,
  },
}

