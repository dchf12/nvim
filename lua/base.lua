vim.cmd("autocmd!")
vim.wo.number = true

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

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
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  pattern = '[^l]*',
  command = 'cwindow',
  nested = true,
})
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local file_dir = vim.fn.expand('%:p:h')
    if file_dir ~= '' then
      vim.cmd('silent grep! TODO ' .. file_dir .. '/**/*')
      local qf_list = vim.fn.getqflist()
      if #qf_list > 0 then
        vim.cmd('cwindow')
      end
    end
  end
})
