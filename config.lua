lvim.plugins = {
  -- colorschemes
  "ellisonleao/gruvbox.nvim",
  "LunarVim/synthwave84.nvim",
  "lunarvim/github.nvim",
  "lunarvim/darkplus.nvim",
  "lunarvim/templeos.nvim",

  -- treesitter
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- annotations/ doc/comments toggling
  {
    "danymat/neogen",
    lazy = true,
    config = function()
      require("neogen").setup {
        enabled = true,
      }
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  --typescript
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    lazy = true,
    config = function()
      require("user.tss").config()
    end
  },
  {
    "vuki656/package-info.nvim",
    config = function()
      require("package-info").setup()
    end,
    lazy = true,
    event = { "BufReadPre", "BufNew" },
  },
  -- go tools
  {
    "olexsmir/gopher.nvim",
    config = function()
      require("gopher").setup {
        commands = {
          go = "go",
          gomodifytags = "gomodifytags",
          gotests = "gotests",
          impl = "impl",
          iferr = "iferr",
        },
      }
    end,
    ft = { "go", "gomod" },
    event = { "BufRead", "BufNew" },
  },
  {
    "leoluz/nvim-dap-go",
    config = function()
      require("dap-go").setup()
    end,
    ft = { "go", "gomod" },
    event = { "BufRead", "BufNew" },
  },
  -- loading spinner for lsp progress
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    config = function()
      require("user.fidget_spinner").config()
    end,
    -- disable = lvim.builtin.noice.active,
  },
  "kylechui/nvim-surround",
  -- bookmark plugin
  "ThePrimeagen/harpoon",

  {
    "NvChad/nvim-colorizer.lua",
    config = function()
      require("user.colorizer").config()
    end,
  },

  -- nice buffer delete wrapper to not missup splits
  "moll/vim-bbye",

  -- TODO: comments hilights
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("user.todo-comments").config()
    end,
    event = "BufRead",
  },

  -- a search panel for nvim
  {
    "windwp/nvim-spectre",
    lazy = true,
    config = function()
      require("user.spectre").config()
    end,
  },
  -- structural search and replace
  {
    "cshuaimin/ssr.nvim",
    lazy = true,
    config = function()
      require("ssr").setup {
        min_width = 50,
        min_height = 5,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_all = "<leader><cr>",
        },
      }
    end,
    event = { "BufReadPost", "BufNew" },
  },
  -- copy link to github with selected lines to share
  {
    "ruifm/gitlinker.nvim",
    config = function()
      require("gitlinker").setup({
        opts = {
          -- remote = 'github', -- force the use of a specific remote
          -- adds current line nr in the url for normal mode
          add_current_line_on_normal_mode = true,
          -- callback for what to do with the url
          action_callback = require("gitlinker.actions").open_in_browser,
          -- print the url after performing the action
          print_url = false,
          -- mapping to call url generation
          mappings = "<leader>gy",
        },
      })
    end,
  },
  -- zen mode while editing
  {
    "folke/zen-mode.nvim",
    lazy = true,
    cmd = "ZenMode",
    config = function()
      require("user.zen-mode").config()
    end,
  },
  -- better quickfix menu
  {
    "kevinhwang91/nvim-bqf",
    event = "WinEnter",
    config = function()
      require("user.bqf").config()
    end,
  },

  -- extend % key for matching pairs
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_enabled = 1
      vim.g.matchup_surround_enabled = 1
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  -- better movement hilights and treesitter integrations
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = require("user.flash").keys,
  },
  -- smooth scrollbar
  {
    "declancm/cinnamon.nvim",
    config = function()
      require("cinnamon").setup {
        default_keymaps = true,
        default_delay = 4,
        extra_keymaps = true,
        extended_keymaps = false,
        centered = true,
        scroll_limit = 100,
      }
    end,
    event = "BufRead",
  },

  -- scrollbar on the right
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("user.scrollbar").config()
    end,
  },

  -- UI library
  "MunifTanjim/nui.nvim",

  -- really nice extend for f/F (flash should do the same thing)
  -- {
  --   "jinh0/eyeliner.nvim",
  --   config = function()
  --     require("eyeliner").setup {
  --       highlight_on_key = true,
  --     }
  --   end,
  -- },

  -- github copilot like but free
  "Exafunction/codeium.vim",

}

reload "user.options"
reload "user.mappings"
reload "user.autocommands"
reload "user.lsp"
reload "user.smoothie"
-- reload "user.harpoon"
reload "user.cybu"
reload "user.surround"
reload "user.bookmark"
reload "user.jaq"
reload "user.lab"
-- reload "user.inlay-hints"
reload "user.telescope"
reload "user.bqf"
reload "user.dial"
reload "user.numb"
reload "user.treesitter"
reload "user.neogit"
reload "user.lualine"
-- -- reload "user.zk"
reload "user.chatgpt"
reload "user.whichkey"
