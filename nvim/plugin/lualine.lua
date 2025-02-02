if vim.g.did_load_lualine_plugin then
  return
end
vim.g.did_load_lualine_plugin = true

local navic = require('nvim-navic')
navic.setup {}

---Indicators for special modes,
---@return string status
local function extra_mode_status()
  -- recording macros
  local reg_recording = vim.fn.reg_recording()
  if reg_recording ~= '' then
    return ' @' .. reg_recording
  end
  -- executing macros
  local reg_executing = vim.fn.reg_executing()
  if reg_executing ~= '' then
    return ' @' .. reg_executing
  end
  -- ix mode (<C-x> in insert mode to trigger different builtin completion sources)
  local mode = vim.api.nvim_get_mode().mode
  if mode == 'ix' then
    return '^X: (^]^D^E^F^I^K^L^N^O^Ps^U^V^Y)'
  end
  return ''
end
require("pomo").setup({
  -- How often the notifiers are updated.
  update_interval = 1000,

  -- Configure the default notifiers to use for each timer.
  -- You can also configure different notifiers for timers given specific names, see
  -- the 'timers' field below.
  notifiers = {
    -- The "Default" notifier uses 'vim.notify' and works best when you have 'nvim-notify' installed.
    {
      name = "Default",
      opts = {
        -- With 'nvim-notify', when 'sticky = true' you'll have a live timer pop-up
        -- continuously displayed. If you only want a pop-up notification when the timer starts
        -- and finishes, set this to false.
        sticky = false,

        -- Configure the display icons:
        title_icon = "󱎫",
        text_icon = "󰄉",
        -- Replace the above with these if you don't have a patched font:
        -- title_icon = "⏳",
        -- text_icon = "⏱️",
      },
    },

    -- The "System" notifier sends a system notification when the timer is finished.
    -- Available on MacOS and Windows natively and on Linux via the `libnotify-bin` package.
    { name = "System" },

    -- You can also define custom notifiers by providing an "init" function instead of a name.
    -- See "Defining custom notifiers" below for an example 👇
    -- { init = function(timer) ... end }
  },

  -- Override the notifiers for specific timer names.
  timers = {
    -- For example, use only the "System" notifier when you create a timer called "Break",
    -- e.g. ':TimerStart 2m Break'.
    Break = {
      { name = "System" },
    },
  },
  -- You can optionally define custom timer sessions.
  sessions = {
    -- Example session configuration for a session called "pomodoro".
    pomodoro = {
      { name = "Work",        duration = "25m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work",        duration = "25m" },
      { name = "Short Break", duration = "5m" },
      { name = "Work",        duration = "25m" },
      { name = "Long Break",  duration = "15m" },
    },
  },
})

require('lualine').setup {
  globalstatus = true,
  sections = {
    lualine_c = {
      -- nvim-navic
      { navic.get_location, cond = navic.is_available },
    },
    lualine_z = {
      -- (see above)
      { extra_mode_status },
    },
  },
  options = {
    theme = 'auto',
  },
  -- Example top tabline configuration (this may clash with other plugins)
  -- tabline = {
  --   lualine_a = {
  --     {
  --       'tabs',
  --       mode = 1,
  --     },
  --   },
  --   lualine_b = {
  --     {
  --       'buffers',
  --       show_filename_only = true,
  --       show_bufnr = true,
  --       mode = 4,
  --       filetype_names = {
  --         TelescopePrompt = 'Telescope',
  --         dashboard = 'Dashboard',
  --         fzf = 'FZF',
  --       },
  --       buffers_color = {
  --         -- Same values as the general color option can be used here.
  --         active = 'lualine_b_normal', -- Color for active buffer.
  --         inactive = 'lualine_b_inactive', -- Color for inactive buffer.
  --       },
  --     },
  --   },
  --   lualine_c = {},
  lualine_x = {
    function()
      local ok, pomo = pcall(require, "pomo")
      if not ok then
        print(ok)
        return ""
      end

      local timer = pomo.get_first_to_finish()
      if timer == nil then
        return ""
      end

      return "󰄉 " .. tostring(timer)
    end,
    "encoding",
    "fileformat",
    "filetype",
  },
  --   lualine_y = {},
  --   lualine_z = {},
  -- },
  winbar = {
    lualine_z = {
      {
        'filename',
        path = 1,
        file_status = true,
        newfile_status = true,
      },
    },
  },
  extensions = { 'fugitive', 'fzf', 'toggleterm', 'quickfix' },
}
