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
			local bufnr = vim.api.nvim_get_current_buf()

			-- Check if the buffer has unsaved changes
			if vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
				-- Prompt user with a native dialog box (No = 1, Yes = 2, Cancel = 0)
				local choice =
					vim.fn.confirm("Save changes to " .. vim.fn.bufname(bufnr) .. "?", "&No\n&Yes", 1, "Question")

				if choice == 0 then
					return -- User hit Cancel or Esc, abort entirely
				elseif choice == 2 then
					vim.cmd("write") -- User chose Yes, save the file
				end
			end

			-- Count actual editable buffers (ignoring sidebars like neo-tree)
			local actual_buffers = {}
			for _, buf in ipairs(vim.api.nvim_list_bufs()) do
				if
					vim.api.nvim_get_option_value("buflisted", { buf = buf })
					and vim.api.nvim_get_option_value("buftype", { buf = buf }) == ""
				then
					table.insert(actual_buffers, buf)
				end
			end

			-- Move the window focus away BEFORE deleting the buffer
			if #actual_buffers > 1 then
				vim.cmd("bnext")
			else
				-- If this is the last file, create a blank file
				local new_buf = vim.api.nvim_create_buf(true, false)
				vim.api.nvim_win_set_buf(0, new_buf)
			end

			-- Delete the original buffer forcefully
			pcall(vim.cmd, "bdelete! " .. bufnr)
		end, { desc = "Close Tab safely" })
	end,
}
