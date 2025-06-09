return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
  },
  keys = {
    { "<leader>Cc", "<cmd>CodeCompanionChat<cr>", desc = "[C]odeCompanion[C]hat" },
    { "<leader>Ch", "<cmd>CodeCompanionHistory<cr>", desc = "[C]ode[C]ompanionp[H]istory" },
    { "<leader>Ct", "<cmd>CodeCompanionChat Toggle<cr>", desc = "[C]odeCompanionChat [T]oggle" },
  },
  opts = {
    display = {
      action_palette = {
        width = 95,
        height = 20,
        prompt = "Prompt ", -- Prompt used for interactive LLM calls
        provider = "snacks", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        },
      },
      chat = {
        window = {
          layout = "float",
          border = "single",
          height = 0.95,
          width = 0.8,
          relative = "editor",
        },
      },
    },
    adapters = {
      anthropic = "anthropic",
    },
    strategies = {
      chat = {
        adapter = "anthropic",
        slash_commands = {
          file = {
            opts = {
              provider = "snacks",
            },
          },
          buffer = {
            opts = {
              provider = "snacks",
            },
          },
          help = {
            opts = {
              provider = "snacks",
            },
          },
          symbols = {
            opts = {
              provider = "snacks",
            },
          },
          workspace = {
            opts = {
              provider = "snacks",
            },
          },
        },
      },
      inline = {
        adapter = "anthropic",
      },
      cmd = {
        adapter = "anthropic",
      },
    },
    extensions = {
      history = {
        enabled = true,
        opts = {
          -- Keymap to open history from chat buffer (default: gh)
          keymap = "gh",
          -- Keymap to save the current chat manually (when auto_save is disabled)
          -- save_chat_keymap = "cc",
          -- Save all chats by default (disable to save only manually using 'sc')
          auto_save = true,
          -- Number of days after which chats are automatically deleted (0 to disable)
          expiration_days = 10,
          -- Picker interface (consistent with your action_palette provider)
          -- picker = "snacks", -- ("telescope", "snacks", "fzf_lua", or "default")
          -- Automatically generate titles for new chats
          auto_generate_title = true,
          -- title_generation_opts = {
          -- Adapter for generating titles (defaults to current chat adapter)
          -- adapter = nil,
          -- Model for generating titles (defaults to current chat model)
          -- model = nil,
          -- },
          -- On exiting and entering neovim, loads the last chat on opening chat
          continue_last_chat = false,
          -- When chat is cleared with `gx` delete the chat from history
          delete_on_clearing_chat = true,
          -- Directory path to save the chats
          dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
          -- Enable detailed logging for history extension
          enable_logging = true,
        },
      },
    },
  },
}
