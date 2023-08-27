return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	tag = "v3.6.0",
	config = true,
	opts = {
		options = {
			mode = "buffers",
			offsets = {
				{
					filetype = "neo-tree",
				}
			},
			diagnostics = "nvim_lsp",
		}
	}
}
