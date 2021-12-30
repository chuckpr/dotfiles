local npairs = require("nvim-autopairs")

-- This 👇 allows nested auto-pairing in f-strings
npairs.setup({ignored_next_char = string.gsub([[ [%.%%%]%[%w] ]], '%s+', '')})
