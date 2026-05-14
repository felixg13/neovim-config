-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

vim.opt.wrap = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = ''

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 20

vim.opt.winborder = 'rounded'

vim.opt.background = 'dark'

vim.diagnostic.config {
  virtual_lines = {
    current_line = true,
  },
}

-- Globals
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

require 'config.keymaps'

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Auto trigger completion list or <ctrl-x,ctrl-o> to manually trigger completion list
-- <ctrl-p> to go to previous in list, <ctrl-n> to go to next in list
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method 'textDocument/completion' then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- Packages
local gh = function(x)
  return 'https://github.com/' .. x
end

vim.pack.add {
  gh 'ellisonleao/gruvbox.nvim',
  -- Plugins
  gh 'stevearc/conform.nvim',
  gh 'ibhagwan/fzf-lua',
  gh 'lewis6991/gitsigns.nvim',
  gh 'nvim-treesitter/nvim-treesitter',
  gh 'folke/which-key.nvim',
  gh 'github/copilot.vim',

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
load 'plugins.copilot'

-- Language servers: { lsp_name, mason_name }
local language_servers = {
  { 'clangd', 'clangd' },
  { 'pyright', 'pyright' },
  { 'lua_ls', 'lua-language-server' },
}

-- Formatters and other tools managed by Mason
local language_tools = {
  'clang-format',
}

require('mason').setup()
require('mason-tool-installer').setup {
  ensure_installed = vim.list_extend(
    vim.tbl_map(function(s)
      return s[2]
    end, language_servers),
    language_tools
  ),
}

vim.lsp.enable(vim.tbl_map(function(s)
  return s[1]
end, language_servers))

-- vim: ts=2 sts=2 sw=2 et
