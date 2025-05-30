return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
  opts = {
    file_types = { "markdown", "codecompanion" }, -- Only load for codecompanion filetype
  },
}
