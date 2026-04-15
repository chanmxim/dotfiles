return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
      },
      integrations = {
        neotree = true,
        telescope = {
          enabled = true,
        },
        lualine = true,
      },
      custom_highlights = function(colors)
        return {
          -- LINE NUMBERS
          LineNr = { fg = colors.overlay1 }, 
          CursorLineNr = { fg = colors.mauve, style = { "bold" } }, 

          -- BRACKETS
          MatchParen = { fg = colors.crust, bg = colors.mauve, style = { "bold" } },

          -- FLOATING WINDOWS (Telescope)
           FloatBorder = { fg = colors.mauve, bg = colors.mantle },
          
        }
      end
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
