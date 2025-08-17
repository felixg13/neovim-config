local fzf = require 'fzf-lua'

fzf.setup {
  files = {
    fd_opts = [[--color=never --hidden --follow --exclude .git --exclude .obsidian --type f]],
  },
}

vim.keymap.set('n', '<leader>fg', fzf.live_grep, { desc = 'Live Grep (fzf)' })
vim.keymap.set('n', '<leader>ff', fzf.files, { desc = 'Find Files (fzf)' })
vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = 'Find Buffers (fzf)' })
vim.keymap.set('n', '<leader>fh', fzf.help_tags, { desc = 'Help Tags (fzf)' })

-- Git-related
vim.keymap.set('n', '<leader>gs', fzf.git_status, { desc = 'Git Status (fzf)' })
vim.keymap.set('n', '<leader>gc', fzf.git_commits, { desc = 'Git Commits (fzf)' })
vim.keymap.set('n', '<leader>gb', fzf.git_branches, { desc = 'Git Branches (fzf)' })

-- LSP integration
vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = 'LSP References (fzf)' })
vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = 'LSP Definitions (fzf)' })
vim.keymap.set('n', 'gi', fzf.lsp_implementations, { desc = 'LSP Implementations (fzf)' })
vim.keymap.set('n', '<leader>ds', fzf.lsp_document_symbols, { desc = 'Document Symbols (fzf)' })
vim.keymap.set('n', '<leader>ws', fzf.lsp_workspace_symbols, { desc = 'Workspace Symbols (fzf)' })

-- Command history & keymaps
vim.keymap.set('n', '<leader>:', fzf.command_history, { desc = 'Command History (fzf)' })
vim.keymap.set('n', '<leader>km', fzf.keymaps, { desc = 'Search Keymaps (fzf)' })

-- Search within current buffer
vim.keymap.set('n', '<leader>/', fzf.blines, { desc = 'Search Buffer Lines (fzf)' })

-- Resume last picker (super useful!)
vim.keymap.set('n', '<leader>fr', fzf.resume, { desc = 'Resume Last FZF Picker' })
