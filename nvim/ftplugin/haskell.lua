
if vim.fn.executable('haskell-language-server-wrapper') ~= 1 then
  return
end

local root_files = {
  'package.yaml',
  'stack.yaml',
  '.git',
  '.cabal',
  'cabal.project',
  'hie.yaml'
}

vim.lsp.start {
  name = 'hls',
  cmd = { "haskell-language-server-wrapper", "--lsp"  },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  filetypes = { 'haskell', 'lhaskell', 'cabal' },

}
