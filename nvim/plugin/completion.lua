if vim.g.did_load_completion_plugin then
  return
end
vim.g.did_load_completion_plugin = true

vim.opt.completeopt = { "menu", "menuone", "noselect" }

require("blink.cmp").setup({
  keymap = {
    ["<C-n>"] = { "select_next", "snippet_forward", "fallback" },
    ["<C-p>"] = { "select_prev", "snippet_backward", "fallback" },
    ["<C-y>"] = { "select_and_accept" },
    ["<C-e>"] = { "hide", "cancel" },
    ["<C-b>"] = { "scroll_documentation_up", "fallback" },
    ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  completion = {
    documentation = { auto_show = true },
    ghost_text = { enabled = true },
  },
  signature = { enabled = true },
})
