-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- vim.keymap.set('n', '/', '/\v', { expr = true, silent = true })
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<ESC>:w<CR>', { noremap = true })
vim.keymap.set({ 'n', 'i' }, '<C-s><C-s>', '<ESC>ZZ', { noremap = true })
vim.keymap.set({ 'n', 'i' }, '<C-q>', '<ESC>:q!<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<ESC><ESC>', ':nohl<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-b><C-d>', ':bd<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-b><C-n>', ':bn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-b><C-p>', ':bp<CR>', { noremap = true, silent = true })
vim.keymap.set('i', 'jj', '<ESC>', { noremap = true, silent = true })
vim.keymap.set('n', 'tt', '<cmd>belowright new<CR><cmd>terminal<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })
vim.keymap.set('x', 'x', '"_x', { noremap = true, silent = true })
vim.api.nvim_create_autocmd('TermOpen', {
	pattern = '*',
	command = 'startinsert',
})
vim.api.nvim_create_autocmd('TermOpen', {
	pattern = '*',
	command = 'setlocal norelativenumber',
})
vim.api.nvim_create_autocmd('TermOpen', {
	pattern = '*',
	command = 'setlocal nonumber',
})

-- copolot
-- vim.g.copilot_no_tab_map = true
vim.keymap.set('i', '<C-J>', 'copilot#Accept("<CR>")', { expr = true, silent = true })

-- telescope
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

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

	nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
	nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
	nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
	nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
	nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
	nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

	-- See `:help K` for why this keymap
	nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
	nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

	-- Lesser used LSP functionality
	nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
	nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
	nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
	nmap('<leader>wl', function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, '[W]orkspace [L]ist Folders')

	nmap('<leader>f', vim.lsp.buf.format, '[F]ormat current buffer')
	-- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
	-- 	vim.lsp.buf.format()
	-- end, { desc = 'Format current buffer with LSP' })
	vim.api.nvim_create_autocmd('BufWritePre', {
		pattern = '*.go',
		callback = function()
			vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
		end
	})
end


return {
	on_attach = on_attach
}
