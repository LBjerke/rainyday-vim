-- Telescope setup()
local telescope = require('telescope')

telescope.setup({
  -- Your telescope setup here...
  extensions = {
    whaler = {
      -- Whaler configuration
      directories = { "~/Code", "~/Code/RainyDay", "~/code/", { path = "/etc/nixos/", alias = "nix" } },
      file_explorer = "oil",
      -- You may also add directories that will not be searched for subdirectories
      -- oneoff_directories = { "path/to/project/folder",  { path = "path/to/another/project", alias = "Project Z" } },
    }
  }
})
-- More config here
telescope.load_extension("whaler")
--


-- Or directly
vim.keymap.set("n", "<leader>wtf", telescope.extensions.whaler.whaler)

