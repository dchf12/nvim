-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set('n', '<C-n>', ':bnext<Return>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', ':bprevious<Return>', { noremap = true, silent = true })
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '/', '/\\v', { noremap = true })
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<ESC>:w<CR>', { noremap = true })
vim.keymap.set({ 'n', 'i' }, '<C-s><C-s>', '<ESC>ZZ', { noremap = true })
vim.keymap.set({ 'n', 'i' }, '<C-q><C-q>', '<ESC>:q!<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<ESC><ESC>', ':nohl<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-b><C-d>', ':bd<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-b><C-n>', ':bn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-b><C-p>', ':bp<CR>', { noremap = true, silent = true })
vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true })
vim.keymap.set('n', 'tt', '<cmd>belowright new<CR><cmd>terminal<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })
vim.keymap.set('x', 'x', '"_x', { noremap = true, silent = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>*', '*``cgn', { noremap = true })

-- copolot
-- vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', { expr = true, silent = true })

-- telescope
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>sgf', require('telescope.builtin').git_files, { desc = '[S]earch [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>scw', require('telescope.builtin').grep_string, { desc = '[S]earch [C]urrent [W]ord' })
vim.keymap.set('n', '<leader>sgr', require('telescope.builtin').live_grep, { desc = '[S]earch by [Gr]ep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<C-f>', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[F]uzzily search in current buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- dap
vim.keymap.set('n', '<F5>', ':DapContinue<CR>', { silent = true })
vim.keymap.set('n', '<F10>', ':DapStepOver<CR>', { silent = true })
vim.keymap.set('n', '<F11>', ':DapStepInto<CR>', { silent = true })
vim.keymap.set('n', '<F12>', ':DapStepOut<CR>', { silent = true })
vim.keymap.set('n', '<leader>b', ':DapToggleBreakpoint<CR>', { silent = true })
vim.keymap.set('n', '<leader>B',
	':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>', { silent = true })
vim.keymap.set('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
	{ silent = true })
vim.keymap.set('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true })
vim.keymap.set('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { silent = true })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end
		vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
	end

	nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
	nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

	nmap('<leader>gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('<leader>gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('<leader>gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	nmap('<leader>f', vim.lsp.buf.format, '[F]ormat current buffer')
	vim.api.nvim_create_autocmd('BufWritePre', {
		pattern = '*.go',
		callback = function()
			vim.lsp.buf.code_action({
				context = {
					only = { 'source.organizeImports' },
					diagnostics = {}
				},
				apply = true
			})
		end
	})
end

return {
	on_attach = on_attach
}
