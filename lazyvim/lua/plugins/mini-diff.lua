return {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  -- Keymap: <leader>go to toggle diff overlay for current buffer
  keys = {
    {
      "<leader>go",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
      desc = "Toggle mini.diff overlay",
    },
  },
  opts = {
    view = {
      style = "sign",
      signs = {
        add = "▎",
        change = "▎",
        delete = "",
      },
    },
  },
}
