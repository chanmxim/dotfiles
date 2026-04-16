return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Inject autocomplete globally
		vim.lsp.config("*", { capabilities = capabilities })

		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					semanticTokens = true,
				},
			},
		})

		local servers = {
			"lua_ls",
			"pyright",
			"ts_ls",
			"gopls",
			"rust_analyzer",
			"html",
			"cssls",
			"bashls",
		}

		for _, server in ipairs(servers) do
			vim.lsp.enable(server)
		end

		-- Set up keymaps (Active only when LSP connects to a buffer)
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local opts = { buffer = args.buf }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<leader>d", function()
					require("telescope.builtin").diagnostics({ bufnr = 0 })
				end, opts)
			end,
		})
	end,
}
