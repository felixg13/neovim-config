require('nvim-treesitter').install {
  'bash',
  'c',
  'cpp',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
   'vim',
  'vimdoc',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
  local lang = vim.treesitter.language.get_lang(ev.match)
    if lang then
    require('nvim-treesitter').install { lang }
    end
    pcall(vim.treesitter.start)
  end,
})
