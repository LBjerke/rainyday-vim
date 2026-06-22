if vim.g.did_load_sidekick_plugin then
  return
end
vim.g.did_load_sidekick_plugin = true

require('sidekick').setup {
  cli = {
    mux = {
      enabled = false,
    },
  },
}

local keymap = vim.keymap

keymap.set('n', '<leader>as', function()
  require('sidekick.cli').select { filter = { installed = true } }
end, { desc = 'sidekick: [s]elect AI tool' })

keymap.set('n', '<leader>at', function()
  require('sidekick.cli').toggle()
end, { desc = 'sidekick: [t]oggle terminal' })

keymap.set({ 'n', 'x' }, '<leader>ap', function()
  require('sidekick.cli').prompt()
end, { desc = 'sidekick: select [p]rompt' })

keymap.set({ 'n', 'i' }, '<Tab>', function()
  if not require('sidekick').nes_jump_or_apply() then
    return '<Tab>'
  end
end, { expr = true, desc = 'sidekick: goto/apply NES' })
