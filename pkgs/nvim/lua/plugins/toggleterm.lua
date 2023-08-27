return {
	"akinsho/toggleterm.nvim",
	config = true,
	keys = {
		{ "<c-t>", "<cmd>ToggleTerm<CR>", mode = "n", silent = true },
		{ "<c-t>", "<cmd>ToggleTerm<CR>", mode = "t", silent = true },
		{ "<Esc>", "<C-\\><C-n>",         mode = "t", silent = true },
	}
}
