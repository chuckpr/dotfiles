local npairs = require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')
local ts_conds = require('nvim-autopairs.ts-conds')
local conds = require('nvim-autopairs.conds')
local endwise = require('nvim-autopairs.ts-rule').endwise

-- This 👇 allows nested auto-pairing in f-strings
-- This will not autopair if alphanumeric, dot, percent, or quote follows
npairs.setup({
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
    fast_wrap = {
        map = "<C-w>",
        chars = {'{', '[', '(', '"', "'"},
        pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
        offset = 0, -- Offset from pattern match
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment'
    },
    chars = {'{', '[', '(', '"', "'"},
    disable_in_macro = true,
    enable_check_bracket_line = true
})

npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))

npairs.add_rules({
    Rule("'''", "'''", "python"):with_pair(ts_conds.is_not_ts_node({'string'})),
    Rule("'", "'", "python"):with_pair(conds.before_text('f')),
    Rule('"', '"', "python"):with_pair(conds.before_text('f')),
    endwise('then$', 'fi', 'sh', nil), endwise('do$', 'done', 'sh', nil),
    endwise('case$', 'esac', 'sh', nil)
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done',
             cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))
