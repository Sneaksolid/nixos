return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim"
	},
	config = function()
		require('telescope').setup({
			extensions = {
				["ui-select"] = {
					require('telescope.themes').get_cursor({

					})
				}
			},
			defaults = {
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = "   ",
				selection_caret = "» ",
				entry_prefix = "  ",
				initial_mode = "insert",
				selection_strategy = "reset",
				sorting_strategy = "ascending",
				layout_strategy = "horizontal",
				results_title = false,
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				file_ignore_patterns = { "node_modules" },
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = { "truncate" },
				winblend = 0,
				border = {},
				borderchars = { "━", "┃", "━", "┃", "┏", "┓", "┛", "┗" },
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				-- Developer configurations: Not meant for general override
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
				},
			}
		})

		local extensions = { "projects", "ui-select" }
		for _, ex in ipairs(extensions) do
			require('telescope').load_extension(ex)
		end

		local telescope = require('telescope')
		local builtin = require('telescope.builtin')
		local buf_delete = function()
			vim.api.nvim_buf_delete(0, { force = false, unload = false })
		end

		local bufopts = { noremap = true, silent = true }

		vim.keymap.set('n', '<space><space>', builtin.find_files, bufopts)
		vim.keymap.set('n', '<space>bb', builtin.buffers, bufopts)
		vim.keymap.set('n', '<space>rr', builtin.resume, bufopts)
		vim.keymap.set('n', '<space>bk', buf_delete, bufopts)
		vim.keymap.set('n', '<space>pp', telescope.extensions.projects.projects, bufopts)
		vim.keymap.set('n', '<space>tt', ':tabnew<CR>', bufopts)
		vim.keymap.set('n', '<space>tn', ':tabnext<CR>', bufopts)
		vim.keymap.set('n', '<space>tp', ':tabprevious<CR>', bufopts)
		vim.keymap.set('n', '<space>tc', ':tabclose<CR>', bufopts)
		vim.keymap.set('n', '<space>/', builtin.live_grep, bufopts)
	end
}
