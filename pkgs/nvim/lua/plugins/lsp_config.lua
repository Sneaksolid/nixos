return {
	"neovim/nvim-lspconfig",
	config = function(_, opts)
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lsp_config = require("lspconfig")
		local lsp_flags = {
			debounce_text_changes = 150,
		}

		local search_workspace = function()
			require('telescope.builtin').lsp_workspace_symbols({
				query = vim.fn.input("Query: ")
			})
		end

		local on_attach = function(_, bufnr)
			local lsp_signature = require("lsp_signature")
			lsp_signature.on_attach({
				bind = true,
				handler_opts = {
					border = "none"
				}
			})

			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set('n', "gd", require("telescope.builtin").lsp_definitions, bufopts)
			vim.keymap.set('n', "gi", require("telescope.builtin").lsp_implementations, bufopts)
			vim.keymap.set('n', "<space>cr", vim.lsp.buf.rename, bufopts)
			vim.keymap.set('n', "<space>ca", vim.lsp.buf.code_action, bufopts)
			vim.keymap.set('n', "gr", require("telescope.builtin").lsp_references, bufopts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
			vim.keymap.set('n', '<c-s>', vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set('n', "<space>ff", vim.lsp.buf.format, bufopts)
			vim.keymap.set('n', 'sd', require('telescope.builtin').diagnostics, bufopts)
			vim.keymap.set('n', 'ss', require('telescope.builtin').treesitter, bufopts)
			vim.keymap.set('n', 'sw', search_workspace, bufopts)
		end

		for lsp_server, settings in pairs(opts) do
			lsp_config[lsp_server].setup({
				on_attach = on_attach,
				flags = lsp_flags,
				capabilities = capabilities,
				settings = settings,
			})
		end

		vim.cmd [[
		  highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
		  highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
		  highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
		  highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

		  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
		  sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
		  sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
		  sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
		]]

		vim.api.nvim_create_autocmd('FileType', {
			callback = function()
				local bufnr = vim.fn.bufnr('%')
				local bufopts = { noremap = true, silent = false, buffer = bufnr }
				vim.keymap.set('n', "<space>hh", ':ClangdSwitchSourceHeader<CR>', bufopts)
			end,
			pattern = { 'cpp', 'hpp' }
		})

		vim.api.nvim_create_autocmd('BufWritePre', {
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
			pattern = { '*.go', '*.lua', '*.rs', '*.cpp', '*.hpp' }
		})
	end,
	opts = {
		gopls = {},
		golangci_lint_ls = {},
		tsserver = {},
		rust_analyzer = {},
		pyright = {},
		clangd = {},
		cmake = {},
		vuels = {},
		dartls = {},
		-- nil_ls = {},
		nixd = {},
		lua_ls = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				diagnostics = {
					globals = { 'vim' },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			}
		},
	},
}
