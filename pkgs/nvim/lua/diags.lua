local M = {}

M.last_priority_uri = nil
M.title = 'Workspace Diagnostics'
M.change_since_render = false

local function debounce_trailing(ms, fn)
	local timer = vim.loop.new_timer()
	return function(...)
		local argv = { ... }
		timer:start(ms, 0, function()
			timer:stop()
			vim.schedule_wrap(function()
				fn(unpack(argv))
			end)()
		end)
	end
end

local function is_qf_foreign()
	return vim.fn.getqflist({ title = 0 }).title == M.title
end

function M.populate_qflist()
	local priority_uri = vim.uri_from_bufnr(0)

	if not M.change_since_render and priority_uri == M.last_priority_uri then
		return
	end

	if string.sub(priority_uri, 0, 7) == 'file://' and string.len(priority_uri) > 7 then
		M.last_priority_uri = priority_uri
	else
		priority_uri = M.last_priority_uri
	end

	local diag_qflist = M.get_qflist({ bufnr = nil })
	vim.fn.setqflist(diag_qflist)
	vim.diagnostic.setqflist({ open = false, title = M.title })
	M.change_since_render = false
end

M.debounced_populate_qflist = debounce_trailing(150, M.populate_qflist)

function M.get_qflist(opts)
	local all_diags = vim.diagnostic.get(opts.bufnr)
	local qflist = vim.diagnostic.toqflist(all_diags)

	-- TODO sort qflist here

	return qflist
end

local function qf_hook()
	M.change_since_render = true
	if is_qf_foreign() then
		return
	end

	M.debounced_populate_qflist()
end

local function hook()
	qf_hook()
end

function M.setup()
	local diag_group = vim.api.nvim_create_augroup('Diagnostics', {
		clear = false,
	})

	vim.api.nvim_create_autocmd('DiagnosticChanged', {
		callback = function()
			hook()
		end,
		pattern = { '*' },
		group = diag_group,
	})

	vim.api.nvim_create_autocmd('WinEnter', {
		callback = function()
			hook()
		end,
		pattern = { '*' },
		group = diag_group,
	})

	vim.api.nvim_create_autocmd('BufEnter', {
		callback = function()
			hook()
		end,
		pattern = { '*' },
		group = diag_group,
	})
end

return M
