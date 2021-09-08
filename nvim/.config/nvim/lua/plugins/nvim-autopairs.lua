local npairs = require("nvim-autopairs")
-- local Rule = require('nvim-autopairs.rule')
local cond = require('nvim-autopairs.conds')

npairs.get_rule('"'):with_pair(cond.not_filetypes({"vim"}))

npairs.setup({fast_wrap = {map = '<leader>e', hightlight = 'Search'}})
