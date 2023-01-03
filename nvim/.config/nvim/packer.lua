local install_path = vim.fn.stdpath 'data' ..
    '/site/pack/packer/start/packer.nvim'

local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system {
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim', install_path
    }
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)

    -- Package manager
    use 'wbthomason/packer.nvim'

    -- Useful status updates for LSP
    use 'j-hui/fidget.nvim'

    -- lspconfig
    use 'neovim/nvim-lspconfig'

    -- mason.nvim stuff
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- nvim cmp
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
            { 'tzachar/cmp-tabnine', run = './install.sh' }
        }
    }

    -- lsp_signature
    use 'ray-x/lsp_signature.nvim'

    if is_bootstrap then require('packer').sync() end
end)

-- When we are bootstrapping a configuration, it doesn't
-- make sense to execute the rest of the init.lua.
--
-- You'll need to restart nvim, and then it will work.
if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end
