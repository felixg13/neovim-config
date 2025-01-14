return {
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      vim.g.tokyonight_style = 'moon'
    end,
  },
  {
    'shaunsingh/nord.nvim',
    priority = 1000,
  },
}
