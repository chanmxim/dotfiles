return {
	"akinsho/bufferline.nvim",
	version = "4.*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers",

				offsets = {
					{
						filetype = "neo-tree",
						text = "Explorer",
						text_align = "center",
						separator = true,
					},
				},

				separator_style = "thin",
				always_show_bufferline = true,
				show_buffer_close_icons = true,
				show_close_icon = false,
			},
		})

		vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous Tab" })
		vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next Tab" })
		vim.keymap.set("n", "<leader>c", function()
			local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })

			if #listed_buffers <= 1 then
				return
			end

			local bufnr = vim.api.nvim_get_current_buf()
			vim.cmd("bp")
			vim.cmd("bd " .. bufnr)
		end, { desc = "Close Tab safely" })
	end,
}
