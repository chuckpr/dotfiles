local types = require("luasnip.util.types")
local ls = require("luasnip")

require'luasnip'.config.setup({
    ext_opts = {
        [types.choiceNode] = {active = {virt_text = {{"●", "GruvboxOrange"}}}},
        [types.insertNode] = {active = {virt_text = {{"●", "GruvboxBlue"}}}}
    }
})

ls.snippets = {
    python = {
        ls.parser.parse_snippet("shb", "#!/usr/bin/env python"),
        ls.parser.parse_snippet("df", "def $1($2):\n    $0")
    }
}
