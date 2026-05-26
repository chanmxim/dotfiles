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
			-- Do nothing if trying to close the last buffer
			local listed_buffers = vim.fn.getbufinfo({ buflisted = 1 })
			if #listed_buffers <= 1 then
				return
			end

			local buffer_id = vim.api.nvim_get_current_buf()

			-- Delete current buffer
			local success = pcall(function()
				vim.cmd("confirm bd " .. buffer_id)
			end)

			-- Switch to the previous buffer
			if success and vim.api.nvim_buf_is_valid(buffer_id) == false then
				vim.cmd("bp")
			end
		end, { desc = "Close Tab safely" })
	end,
}
