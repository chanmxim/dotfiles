return {
	"neovim/nvim-lspconfig",
	dependencies = { "saghen/blink.cmp" },
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Inject autocomplete globally
		vim.lsp.config("*", { capabilities = capabilities })

		-- Go
		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					semanticTokens = true,
				},
			},
		})

		-- Lua
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" }, -- Stop annoying "Undefined global 'vim'" warnings
					},
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
				vim.keymap.set("n", "gr", function()
					require("telescope.builtin").lsp_references()
				end, opts)
			end,
		})
	end,
}
