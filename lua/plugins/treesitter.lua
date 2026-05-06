require('nvim-treesitter').install {
  'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc',
  'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
    require('nvim-treesitter').install { lang }
    pcall(vim.treesitter.start)
  end,
})
