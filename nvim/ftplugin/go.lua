if vim.fn.executable('gopls') ~= 1 then
  return
end

local root_files = {
  "go.mod",
  "go.sum",
  '.git',
}

vim.lsp.start {
  name = 'gopls',
  cmd = { "gopls" },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  single_file_support = true,

}
