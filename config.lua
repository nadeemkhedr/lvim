lvim.plugins = {
  "ellisonleao/gruvbox.nvim",
  "LunarVim/synthwave84.nvim",
  "roobert/tailwindcss-colorizer-cmp.nvim",
  "lunarvim/github.nvim",
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- "christianchiarulli/nvim-ts-rainbow",
  "mfussenegger/nvim-jdtls",
  -- "karb94/neoscroll.nvim",
  "opalmay/vim-smoothie",
  "j-hui/fidget.nvim",
  "christianchiarulli/nvim-ts-autotag",
  "kylechui/nvim-surround",
  "christianchiarulli/harpoon",
  "MattesGroeger/vim-bookmarks",
  "NvChad/nvim-colorizer.lua",
  "ghillb/cybu.nvim",
  "moll/vim-bbye",
  "folke/todo-comments.nvim",
  "windwp/nvim-spectre",
  "f-person/git-blame.nvim",
  "ruifm/gitlinker.nvim",
  "mattn/vim-gist",
  "mattn/webapi-vim",
  "folke/zen-mode.nvim",
  "lvimuser/lsp-inlayhints.nvim",
  "lunarvim/darkplus.nvim",
  "lunarvim/templeos.nvim",
  "kevinhwang91/nvim-bqf",
  "is0n/jaq-nvim",
  -- "hrsh7th/cmp-emoji",
  "ggandor/leap.nvim",
  "nacro90/numb.nvim",
  "TimUntersberger/neogit",
  "sindrets/diffview.nvim",
  "simrat39/rust-tools.nvim",
  "olexsmir/gopher.nvim",
  "leoluz/nvim-dap-go",
  "mfussenegger/nvim-dap-python",
  "jose-elias-alvarez/typescript.nvim",
  "mxsdev/nvim-dap-vscode-js",
  "petertriho/nvim-scrollbar",
  "renerocksai/telekasten.nvim",
  -- "renerocksai/calendar-vim",
  {
    "saecki/crates.nvim",
    version = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }
    end,
  },
  "MunifTanjim/nui.nvim",
  "jackMort/ChatGPT.nvim",
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true,
      }
    end,
  },
  { "christianchiarulli/telescope-tabs", branch = "chris" },
  "monaqa/dial.nvim",
  {
    "0x100101/lab.nvim",
    build = "cd js && npm ci",
  },
  -- { "tzachar/cmp-tabnine", build = "./install.sh" },
  {
    "zbirenbaum/copilot.lua",
    -- event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
          plugin_manager_path = os.getenv "LUNARVIM_RUNTIME_DIR" .. "/site/pack/packer",
        }
      end, 100)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup {
        formatters = {
          insert_text = require("copilot_cmp.format").remove_existing,
        },
      }
    end,
  },
}

reload "user.options"
reload "user.keymaps"
reload "user.autocommands"
reload "user.lsp"
reload "user.smoothie"
reload "user.harpoon"
reload "user.cybu"
reload "user.surround"
reload "user.bookmark"
reload "user.todo-comments"
reload "user.jaq"
reload "user.fidget"
reload "user.lab"
reload "user.git"
reload "user.zen-mode"
reload "user.inlay-hints"
reload "user.telescope"
reload "user.bqf"
reload "user.dial"
reload "user.numb"
reload "user.treesitter"
reload "user.neogit"
reload "user.colorizer"
reload "user.lualine"
reload "user.scrollbar"
-- -- reload "user.zk"
reload "user.chatgpt"
reload "user.whichkey"
