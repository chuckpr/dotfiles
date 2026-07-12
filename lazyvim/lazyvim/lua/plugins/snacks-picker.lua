return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>fG",
      function()
        Snacks.picker.git_grep()
      end,
      desc = "Grep Git Files",
    },
  },
}
