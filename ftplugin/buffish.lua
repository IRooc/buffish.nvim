local api = vim.api
local actions = require("buffish").actions

api.nvim_buf_set_option(0, 'buflisted', false)
api.nvim_buf_set_option(0, 'bufhidden', 'delete')
api.nvim_buf_set_option(0, 'buftype', 'nofile')
api.nvim_buf_set_option(0, 'swapfile', false)

local augroup = vim.api.nvim_create_augroup('buffish-au',
  {clear = true})

api.nvim_create_autocmd("BufWinEnter", {
  buffer = 0,
  callback = function()
    vim.pretty_print("enter")
    vim.w.old_conceallevel = vim.wo.conceallevel
    vim.wo.conceallevel = 1
    vim.w.old_concealcursor = vim.wo.concealcursor
    vim.wo.concealcursor = "n"
  end,
  group = augroup
})

api.nvim_create_autocmd("BufWinLeave", {
  buffer = 0,
  callback = function()
    vim.pretty_print("leave")
    vim.wo.conceallevel = vim.w.old_conceallevel
    vim.w.old_conceallevel = nil
    vim.wo.concealcursor = vim.w.old_concealcursor
    vim.w.old_concealcursor = nil
  end,
  group = augroup
})

api.nvim_create_autocmd("BufDelete", {
  callback = function(details)
    actions.rerender(details)
  end,
  group = augroup
})

api.nvim_buf_set_keymap(0, 'n', "q", '', {
  callback = actions.quit,
  nowait = true,
  noremap = true,
  silent = true
})

api.nvim_buf_set_keymap(0, 'n', "<CR>", '', {
  callback = actions.select,
  nowait = true,
  noremap = true,
  silent = true
})

api.nvim_buf_set_keymap(0, 'n', "dd", '', {
  callback = actions.delete,
  nowait = true,
  noremap = true,
  silent = true
})
