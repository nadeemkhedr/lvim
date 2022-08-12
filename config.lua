-- General
lvim.transparent_window = false
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.leader = "space"
lvim.colorscheme = "pablo"

-- Default Options
vim.opt.clipboard = ""
vim.opt.relativenumber = true
vim.opt.timeoutlen = 200
vim.o.inccommand = "split"

-- LSP
lvim.lsp.diagnostics.virtual_text = true -- "gl" to show diagnostics for each error
lvim.lsp.automatic_servers_installation = false

-- Treesitter
local languages = vim.tbl_flatten {
  { "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css", "d", "dart" },
  { "dockerfile", "elixir", "elm", "erlang", "fennel", "fish", "go" },
  { "gomod", "graphql", "hcl", "help", "html", "java", "javascript", "jsdoc" },
  { "json", "jsonc", "julia", "kotlin", "latex", "ledger", "lua", "make" },
  { "markdown", "nix", "ocaml", "perl", "php", "python", "query", "r" },
  { "regex", "rego", "ruby", "rust", "scala", "scss", "solidity", "swift" },
  { "teal", "toml", "tsx", "typescript", "vim", "vue", "yaml", "zig", "prisma" },
}
lvim.builtin.treesitter.ensure_installed = languages

lvim.builtin.global_statusline = true
lvim.builtin.lualine.sections.lualine_b = { "filename" }
lvim.builtin.lualine.options.globalstatus = lvim.builtin.global_statusline

lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.project.patterns = { ".git", ".svn" }
lvim.builtin.notify.active = true

-- Builtin
lvim.builtin.alpha.active = true
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true

-- Debugging
-- =========================================
if lvim.builtin.dap.active then
  require("user.dap").config()
end

vim.cmd [[
  autocmd FileType harpoon setlocal wrap
]]

-- Language Specific
-- =========================================
-- local custom_servers = { "dockerls", "tsserver", "jsonls", "gopls" }
-- vim.list_extend(lvim.lsp.override, custom_servers)
require("user.null_ls").config()

require("user.builtin").config()

-- Additional Plugins
lvim.plugins = {
  {
    "rose-pine/neovim",
    as = "rose-pine",
    config = function()
      require("user.theme").rose_pine()
      vim.cmd [[colorscheme rose-pine]]
    end,
    cond = function()
      local _time = os.date "*t"
      return (_time.hour >= 1 and _time.hour < 9)
    end,
  },
  {
    "abzcoding/tokyonight.nvim",
    branch = "feat/local",
    config = function()
      require("user.theme").tokyonight()
      vim.cmd [[colorscheme tokyonight]]
    end,
    cond = function()
      local _time = os.date "*t"
      return _time.hour >= 9 and _time.hour < 17
    end,
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("user.theme").catppuccin()
      vim.cmd [[colorscheme catppuccin]]
    end,
    cond = function()
      local _time = os.date "*t"
      return (_time.hour >= 17 and _time.hour < 21)
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("user.theme").kanagawa()
      vim.cmd [[colorscheme kanagawa]]
    end,
    cond = function()
      local _time = os.date "*t"
      return (_time.hour >= 21 and _time.hour < 24) or (_time.hour >= 0 and _time.hour < 1)
    end,
  },
  { "tpope/vim-surround" },
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
    config = function()
      vim.cmd [[
          let test#javascript#runner = 'nx'
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
            [".*%.env.*"] = "sh",
            [".*ignore"] = "conf",
          },
          extensions = {
            tf = "terraform",
            tfvars = "terraform",
            tfstate = "json",
            eslintrc = "json",
            prettierrc = "json",
            mdx = "markdown",
            prisma = "prisma",
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
  -- better dap UI
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()
    end,
    ft = { "python", "rust", "go" },
    event = "BufReadPost",
    requires = { "mfussenegger/nvim-dap" },
    disable = not lvim.builtin.dap.active,
  },
  {
    "ruifm/gitlinker.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("gitlinker").setup()
    end,
  },
  {
    "b0o/incline.nvim",
    config = function()
      require("user.incline").config()
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
