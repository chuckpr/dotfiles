local npairs = require("nvim-autopairs")
-- local Rule = require('nvim-autopairs.rule')
-- local cond = require('nvim-autopairs.conds')

npairs.setup({ignored_next_char = string.gsub([[ [%.%%%]%[%w] ]], '%s+', '')})

-- npairs.get_rule('"'):with_pair(cond.not_filetypes({"vim"}))
