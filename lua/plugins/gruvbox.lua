return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  opts = {
    contrast = 'soft',
    transparent_mode = false,
  },
  init = function()
    vim.cmd 'colorscheme gruvbox'
  end,
}
