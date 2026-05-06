local gh = function(x)
  return 'https://github.com/' .. x
end

vim.pack.add {
  -- Colorschemes
  gh 'ellisonleao/gruvbox.nvim',
  -- Plugins
  gh 'stevearc/conform.nvim',
  gh 'ibhagwan/fzf-lua',
  gh 'lewis6991/gitsigns.nvim',
  gh 'nvim-treesitter/nvim-treesitter',
  gh 'folke/which-key.nvim',

  -- LSP
  gh 'neovim/nvim-lspconfig',
  gh 'williamboman/mason.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
}

local function load(mod)
  local ok, err = pcall(require, mod)
  if not ok then
    vim.notify('Failed to load ' .. mod .. ': ' .. err, vim.log.levels.WARN)
  end
end

load 'plugins.gruvbox'
load 'plugins.conform'
load 'plugins.fzf-lua'
load 'plugins.gitsigns'
load 'plugins.treesitter'
load 'plugins.which-key'
load 'plugins.mason'
