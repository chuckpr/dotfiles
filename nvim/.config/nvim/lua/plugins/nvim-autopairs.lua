local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')
local ts_conds = require('nvim-autopairs.ts-conds')

-- This 👇 allows nested auto-pairing in f-strings
-- This will not autopair if alphanumeric, dot, percent, or quote follows
npairs.setup({
    ignored_next_char = string.gsub([[ [%w%.%%%'%"] ]], "%s+", ""),
    fast_wrap = {map = "<C-w>"}
})

npairs.add_rules({
    Rule("'''", "'''", "python"):with_pair(
        ts_conds.is_not_ts_node({'string', 'comment'}))
})
