require('mason').setup()

require('mason-tool-installer').setup {
  ensure_installed = {
    'bash-language-server',
    'marksman',
    'clangd',
    -- cmake-language-server: install via pacman (pip not available)
  },
}
