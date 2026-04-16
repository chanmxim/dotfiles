return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "modern",
    
    win = {
      border = "rounded",
      padding = { 1, 2 },
    },

    spec = {
      { "<leader>f", group = "Telescope" }, 
      { "<leader>e", group = "Explorer" },
      { "<leader>r", group = "Rename" },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
