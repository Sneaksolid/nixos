vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>op", "<cmd>Neotree toggle source=filesystem<CR>", silent = true },
		{ "<leader>og", "<cmd>Neotree toggle source=git_status<CR>", silent = true }
	},
	opts = {
		close_if_last_window = true,
		enable_git_status = true,
		open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
		source_selector = {
			winbar = true,
		},
		window = {
			width = 30,
			auto_expand_width = true,
			mappings = {
				["<TAB>"] = { "open" }
			}
		},
		filesystem = {
			use_libuv_file_watcher = true
		},
		cwd_target = {
			sidebar = "global"
		}
	}
}
