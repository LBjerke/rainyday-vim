require("obsidian").setup({
  config = {
    workspaces = {
      {
        name = "personal",
        path = "~/Code/vaults/personal",
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },
    },

  },
})
