
if vim.fn.executable('terraform-ls') ~= 1 then
  return
end

local root_files = {
  "main.tf",
  '.git',
}

vim.lsp.start {
  name = 'terraform-ls',
  cmd = { "terraform-ls" , "serve" },
  root_dir = vim.fs.dirname(vim.fs.find(root_files, { upward = true })[1]),
  capabilities = require('user.lsp').make_client_capabilities(),
  filetypes = { "terraform", "terraform-vars" },
  single_file_support = true,

}
