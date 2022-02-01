local function tmux()
    local tmux_session = os.getenv('TMUX')
    if tmux_session == nil then
        return 'not in tmux session'
    else
        return 'TMUX active'
    end
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'material-nvim',
        component_separators = {left = '', right = ''},
        section_separators = {left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename', {tmux, color = {fg = 'LightCyan'}}},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
