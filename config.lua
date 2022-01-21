-- General
lvim.transparent_window = false
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.leader = "space"
lvim.colorscheme = "onedarker"

-- Default Options
vim.opt.clipboard = ""
vim.opt.relativenumber = true
vim.opt.timeoutlen = 200
vim.o.inccommand = "split"

-- LSP
lvim.lsp.diagnostics.virtual_text = true -- "gl" to show diagnostics for each error
lvim.lsp.automatic_servers_installation = false

-- Treesitter
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.project.patterns = { ".git", ".svn" }
lvim.builtin.lualine.sections.lualine_b = { "filename" }

-- Builtin
-- lvim.builtin.nvimtree.hide_dotfiles = 0
lvim.builtin.nvimtree.setup.view.width = 60
lvim.builtin.dashboard.active = true

lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.telescope.defaults.path_display = {}
lvim.builtin.bufferline.active = false

lvim.builtin.telescope.defaults.mappings = {
  i = {
    ["<esc>"] = require("telescope.actions").close,
  },
}

vim.cmd [[
  autocmd FileType harpoon setlocal wrap
]]

-- Language Specific
-- =========================================
-- local custom_servers = { "dockerls", "tsserver", "jsonls", "gopls" }
-- vim.list_extend(lvim.lsp.override, custom_servers)
require("user.null_ls").config()

-- Additional Plugins
lvim.plugins = {
  { "lunarvim/colorschemes" },
  { "tpope/vim-surround" },
  {
    "folke/tokyonight.nvim",
    config = function()
      vim.g.tokyonight_style = "night"
    end,
  },
  -- Show method signature when entering text
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("user/lsp_signature").config()
    end,
  },
  -- Match text with % like if/else
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "bkad/CamelCaseMotion",
    config = function()
      vim.g.camelcasemotion_key = ","
    end,
  },
  -- Add sneak like motion and extends f to show next occurrence
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },
  -- auto close/rename html tags
  {
    "windwp/nvim-ts-autotag",
  },
  -- really nice quickfix with preview
  -- {
  -- "kevinhwang91/nvim-bqf",
  -- event = "BufRead",
  -- },
  {
    "sindrets/diffview.nvim",
    opt = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    setup = function() end,
    config = function()
      require("diffview").setup {
        enhanced_diff_hl = true,
        key_bindings = {
          file_panel = { q = "<Cmd>DiffviewClose<CR>" },
          view = { q = "<Cmd>DiffviewClose<CR>" },
          file_history_panel = { q = "<Cmd>DiffviewClose<CR>" },
        },
      }
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    setup = function()
      require "user.indent_blankline"
    end,
  },
  {
    "kevinhwang91/rnvimr",
    config = function()
      -- Make Ranger replace netrw and be the file explorer
      -- vim.g.rnvimr_ex_enable = 1
      vim.g.rnvimr_draw_border = 1
      vim.g.rnvimr_pick_enable = 1
      vim.g.rnvimr_bw_enable = 1
      vim.api.nvim_set_keymap("n", "-", ":RnvimrToggle<CR>", { noremap = true, silent = true })
    end,
  },
  -- Search/replace panel
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("user.spectre").config()
    end,
  },
  -- todo comments styles
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("user.todo_comments").config()
    end,
    event = "BufRead",
  },

  -- colorize colors
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      local status_ok, colorizer = pcall(require, "colorizer")
      if not status_ok then
        return
      end

      colorizer.setup({ "*" }, {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      })
    end,
  },
  -- {
  --   "jose-elias-alvarez/nvim-lsp-ts-utils",
  --   before = "williamboman/nvim-lsp-installer",
  -- },
  -- Running unit tests
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    config = function()
      vim.cmd [[
          function! ToggleTermStrategy(cmd) abort
            call luaeval("require('toggleterm').exec(_A[1])", [a:cmd])
          endfunction
          let g:test#custom_strategies = {'toggleterm': function('ToggleTermStrategy')}
        ]]
      vim.g["test#strategy"] = "toggleterm"
    end,
  },
  {
    "ThePrimeagen/harpoon",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-lua/popup.nvim" },
    },
    config = function()
      require("harpoon").setup {
        menu = { width = 100, height = 10 },
      }
    end,
  },
  -- jsonnet file support
  { "google/vim-jsonnet" },

  -- json schema stores
  { "b0o/schemastore.nvim" },
  {
    "caenrique/nvim-maximize-window-toggle",
    cmd = "ToggleOnly",
  },
  {
    "f-person/git-blame.nvim",
    cmd = "GitBlameToggle",
    config = function()
      vim.g.gitblame_enabled = 0
      vim.g.gitblame_message_template = "<summary> • <date> • <author>"
      vim.g.gitblame_highlight_group = "LineNr"
    end,
  },
  {
    "filipdutescu/renamer.nvim",
    config = function()
      require("renamer").setup()
    end,
  },
  -- a different bufferline, need to disable default
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("user.bufferline").config()
    end,
    requires = "nvim-web-devicons",
  },
  -- add bulb if there are code actions available on the line
  {
    "kosayoda/nvim-lightbulb",
    config = function()
      vim.fn.sign_define(
        "LightBulbSign",
        { text = require("user.lsp_icons").icons.code_action, texthl = "DiagnosticInfo" }
      )
    end,
    event = "BufRead",
    ft = { "rust", "go", "typescript", "typescriptreact" },
  },

  -- add log hilights
  { "mtdl9/vim-log-highlighting", ft = { "text", "log" } },

  -- much faster than default hilight
  {
    "nathom/filetype.nvim",
    config = function()
      require("filetype").setup {
        overrides = {
          literal = {
            ["kitty.conf"] = "kitty",
            [".gitignore"] = "conf",
          },
          complex = {
            [".clang*"] = "yaml",
          },
          extensions = {
            tf = "terraform",
            tfvars = "terraform",
            tfstate = "json",
          },
        },
      }
    end,
  },

  {
    "sidebar-nvim/sidebar.nvim",
    cmd = "SidebarNvimToggle",
    config = function()
      require("user.sidebar").config()
    end,
  },

  -- {
  --   "beauwilliams/focus.nvim",
  --   config = function()
  --     require("focus").setup()
  --   end,
  -- },
}

require("user.mappings").config()

-- function/code annotation (comments)
-- {
--   "danymat/neogen",
--   config = function()
--     require("neogen").setup {
--       enabled = true,
--     }
--   end,
--   event = "BufRead",
--   requires = "nvim-treesitter/nvim-treesitter",
-- },
