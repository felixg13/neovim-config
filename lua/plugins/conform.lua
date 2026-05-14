local conform = require 'conform'

-- 'off' | 'hunks' | 'all'
vim.g.conform_save_mode = 'hunks'

local function format_hunks()
  local hunks = require('gitsigns').get_hunks()
  if not hunks then
    return
  end
  for i = #hunks, 1, -1 do
    local hunk = hunks[i]
    if hunk ~= nil and hunk.type ~= 'delete' then
      local start = hunk.added.start
      local last = start + hunk.added.count
      local last_hunk_line = vim.api.nvim_buf_get_lines(0, last - 2, last - 1, true)[1]
      local range = { start = { start, 0 }, ['end'] = { last - 1, last_hunk_line:len() } }
      conform.format { range = range, timeout_ms = 500, lsp_format = 'fallback' }
    end
  end
end

local function format_marks(s_mark, e_mark)
  local s = vim.api.nvim_buf_get_mark(0, s_mark)
  local e = vim.api.nvim_buf_get_mark(0, e_mark)
  conform.format {
    async = false,
    lsp_format = 'fallback',
    range = { start = { s[1] + 1, s[2] }, ['end'] = { e[1] + 1, e[2] } },
  }
end

_G._conform_operator = function()
  format_marks('[', ']')
end

conform.setup {
  notify_on_error = false,
  formatters_by_ft = {
    lua = { 'stylua' },
    c = { 'clangd' },
    cpp = { 'clangd' },
    python = { 'ruff_fix', 'ruff_organize_import', 'ruff_format' },
    sh = { 'shellharden' },
    xml = { 'lemminx' },
    cmake = { 'cmake-format' },
  },
}

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(ev)
    local mode = vim.g.conform_save_mode
    if mode == 'off' then
      return
    elseif mode == 'hunks' then
      if vim.b[ev.buf].full_format_done then
        vim.b[ev.buf].full_format_done = false
        return
      end
      format_hunks()
    elseif mode == 'all' then
      conform.format { async = false, lsp_format = 'fallback', timeout_ms = 500 }
    end
  end,
})

local cycle = { off = 'hunks', hunks = 'all', all = 'off' }

vim.api.nvim_create_user_command('FormatStyle', function()
  local next = cycle[vim.g.conform_save_mode] or 'hunks'
  vim.g.conform_save_mode = next
  vim.notify('Format on save: ' .. next, vim.log.levels.INFO, { title = 'Conform' })
end, { desc = 'Cycle format-on-save mode: off → hunks → all' })

vim.keymap.set('n', '<leader>F', function()
  vim.o.operatorfunc = 'v:lua._conform_operator'
  return 'g@'
end, { expr = true, desc = 'Format with motion' })

vim.keymap.set('n', '<leader>FF', function()
  conform.format { async = false, lsp_format = 'fallback' }
  vim.b.full_format_done = true
end, { desc = '[F]ormat buffer' })

vim.keymap.set('x', '<leader>F', function()
  format_marks('<', '>')
end, { desc = 'Format selection' })
