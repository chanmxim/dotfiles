return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
	config = function()
		vim.api.nvim_set_hl(0, "DashboardHeader", { link = "Function" })
		vim.api.nvim_set_hl(0, "DashboardDesc", { link = "DashboardHeader" })
		vim.api.nvim_set_hl(0, "DashboardKey", { link = "DashboardHeader" })
		vim.api.nvim_set_hl(0, "DashboardIcon", { link = "DashboardHeader" })
		vim.api.nvim_set_hl(0, "DashboardFooter", { link = "DashboardHeader" })

		local logo = [[
     ██████╗ ██╗  ██╗ █████╗ ███╗   ██╗    ██╗   ██╗██╗    ██╗██╗   ██╗
    ██╔════╝ ██║  ██║██╔══██╗████╗  ██║    ██║   ██║██║    ██║██║   ██║
    ██║      ███████║███████║██╔██╗ ██║    ██║   ██║██║ █╗ ██║██║   ██║
    ██║      ██╔══██║██╔══██║██║╚██╗██║    ██║   ██║██║███╗██║██║   ██║
    ╚██████╗ ██║  ██║██║  ██║██║ ╚████║    ╚██████╔╝╚███╔███╔╝╚██████╔╝
     ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝     ╚═════╝  ╚══╝╚══╝  ╚═════╝ 
    ]]

		logo = string.rep("\n", 8) .. logo .. "\n\n"

		require("dashboard").setup({
			theme = "doom",
			hide = {
				statusline = false,
			},
			config = {
				header = vim.split(logo, "\n"),

				center = {
					{ action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
					{ action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
					{ action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
					{ action = "Neotree toggle", desc = " File Explorer", icon = "󰙅 ", key = "e" },
					{ action = "Lazy", desc = " Plugin Manager", icon = "󰒲 ", key = "l" },
					{ action = "qa", desc = " Quit", icon = " ", key = "q" },
				},

				footer = {},
			},
		})
	end,
}
