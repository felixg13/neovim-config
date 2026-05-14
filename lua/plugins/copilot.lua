-- Accept suggestion with <Tab>, dismiss with <C-]>, next/prev with <M-]>/<M-[>
vim.g.copilot_no_tab_map = true

vim.keymap.set('i', '<Tab>', function()
  local suggestion = vim.fn['copilot#Accept'] ''
  if suggestion ~= '' then
    return suggestion
  end
  return '<Tab>'
end, { expr = true, replace_keycodes = false, desc = 'Accept Copilot suggestion or insert tab' })

vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)', { desc = 'Accept next Copilot word' })
vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)', { desc = 'Next Copilot suggestion' })
vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)', { desc = 'Previous Copilot suggestion' })
vim.keymap.set('i', '<C-]>', '<Plug>(copilot-dismiss)', { desc = 'Dismiss Copilot suggestion' })
