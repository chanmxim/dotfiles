return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local custom_theme = require("lualine.themes.auto")

    local colors = require("catppuccin.palettes").get_palette("mocha")

    custom_theme.normal.a.bg = colors.blue
    custom_theme.normal.a.fg = colors.base
    custom_theme.normal.b.fg = colors.blue

    -- Transparent middle section
    custom_theme.normal.c.bg = "NONE"
    custom_theme.insert.c.bg = "NONE"
    custom_theme.visual.c.bg = "NONE"
    custom_theme.command.c.bg = "NONE"
    custom_theme.replace.c.bg = "NONE"
    custom_theme.inactive.c.bg = "NONE"

    require("lualine").setup({
      options = {
        theme = custom_theme,
        globalstatus = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      -- 3. Customize what shows up in each section
      sections = {
        lualine_a = {'mode'},
        lualine_b = {
          'branch', 
          'diff',
          'diagnostics',
        },
        lualine_c = {'filename'}, -- This sits in the transparent middle
        lualine_x = {},
        lualine_y = {'progress'},
        lualine_z = {'location'}
      }
    })
  end,
}
