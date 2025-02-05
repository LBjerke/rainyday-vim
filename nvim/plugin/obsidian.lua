require("obsidian").setup({
  config = {
    workspace = {
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
