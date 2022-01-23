local npairs = require("nvim-autopairs")

-- This 👇 allows nested auto-pairing in f-strings
-- This will not autopair if alphanumeric, dot, percent, or quote follows
npairs.setup({ignored_next_char = string.gsub([[ [%w%.%%%'%"] ]], "%s+", "")})
