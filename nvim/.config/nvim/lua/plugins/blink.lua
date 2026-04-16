return {
	"saghen/blink.cmp",
	build = "cargo build --release",
	version = "1.*",
	opts = {
		keymap = {
			preset = "super-tab",
			["<CR>"] = { "accept", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		completion = {
			menu = { border = "rounded" },
			documentation = { auto_show = true, window = { border = "rounded" } },
		},
		signature = { enabled = true },
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},

	opts_extend = { "sources.default" },
}
