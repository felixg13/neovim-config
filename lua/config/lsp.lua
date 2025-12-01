local server = {
  'bashls',
  'hyprls',
  'lua_ls',
  'marksman',
  'ruff',
  'clangd',
  'cmake',
  'glsl_analyzer',
  'slangd',
}

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

-- Don't select first of completion list automatically
vim.cmd 'set completeopt+=noselect'

vim.lsp.enable(server)
