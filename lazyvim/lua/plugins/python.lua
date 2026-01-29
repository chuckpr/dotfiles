return {
  -- Configure basedpyright LSP server
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                -- Basic type checking: only check types when hints are present
                typeCheckingMode = "basic",

                -- Disable warnings about missing type information
                -- (no errors if you don't add type hints)
                reportMissingParameterType = "none",
                reportMissingTypeArgument = "none",
                reportUnknownParameterType = "none",
                reportUnknownArgumentType = "none",
                reportUnknownLambdaType = "none",
                reportUnknownVariableType = "none",
                reportUnknownMemberType = "none",

                -- Disable style/convention warnings
                reportUnusedVariable = "none",
                reportUnusedClass = "none",
                reportUnusedFunction = "none",
                reportUnusedImport = "none",

                -- Keep critical error detection enabled
                reportMissingImports = "error",
                reportUndefinedVariable = "error",
              },
            },
          },
        },
      },
    },
  },

  -- Ensure basedpyright is installed via mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "basedpyright",
      },
    },
  },
}
