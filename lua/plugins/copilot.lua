-- Accept suggestion with <Tab> (plugin default), dismiss with <C-]>, next/prev with <M-]>/<M-[>
vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)', { desc = 'Accept next Copilot word' })
vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)', { desc = 'Next Copilot suggestion' })
vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)', { desc = 'Previous Copilot suggestion' })
vim.keymap.set('i', '<C-]>', '<Plug>(copilot-dismiss)', { desc = 'Dismiss Copilot suggestion' })
