
if vim.fn.executable('zls') ~= 1 then
  return
end

local root_files = {
  ".zig",
  '.git',
}

vim.lsp.start {
  name = 'zls',
  cmd = { "zls" },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  filetypes = { "zig", "zir" },
  single_file_support = true,

}
