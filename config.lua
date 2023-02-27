-- General
lvim.colorscheme = "tokyonight"
lvim.builtin.time_based_themes = true -- will change the active theme based on time
lvim.transparent_window = false
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.leader = "space"

-- LSP
-- disable because we are using lsp_lines
lvim.lsp.diagnostics.virtual_text = true -- "gl" to show diagnostics for each error when true
lvim.lsp.automatic_servers_installation = false

vim.g.camelcasemotion_key = ","
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

vim.cmd [[
  autocmd FileType harpoon setlocal wrap
]]

-- Default Options
vim.opt.clipboard = ""
vim.opt.relativenumber = true
vim.opt.timeoutlen = 200
vim.o.inccommand = "split"
vim.opt.cmdheight = 1
vim.opt.fillchars = {
  fold = " ",
  eob = " ", -- suppress ~ at EndOfBuffer
  diff = "╱", -- alternatives = ⣿ ░ ─
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  verthoriz = "╋",
}

vim.opt.wildignore = {
  "*.aux,*.out,*.toc",
  "*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
  -- media
  "*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
  "*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
  "*.eot,*.otf,*.ttf,*.woff",
  "*.doc,*.pdf",
  -- archives
  "*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
  -- temp/system
  "*.*~,*~ ",
  "*.swp,.lock,.DS_Store,._*,tags.lock",
  -- version control
  ".git,.svn",
}

vim.opt.listchars = {
  eol = nil,
  tab = "│ ",
  extends = "›", -- Alternatives: … »
  precedes = "‹", -- Alternatives: … «
  trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
}

vim.filetype.add {
  extension = {
    fnl = "fennel",
    wiki = "markdown",
  },
  filename = {
    ["go.sum"] = "gosum",
    ["go.mod"] = "gomod",
  },
  pattern = {
    ["*.tml"] = "gohtmltmpl",
    ["%.env.*"] = "sh",
  },
}
require("user.null_ls").config()
require("user.builtin").config()
require("user.bufferline").config()
require("user.cmp").config()

-- Additional Plugins
lvim.plugins = {
  {
    "rose-pine/neovim",
    name = "rose-pine",
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
    "catppuccin/nvim",
    name = "catppuccin",
    init = function()
      vim.g.catppuccin_flavour = "mocha"
    end,
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
    config = function() end,
  },
  -- Add sneak like motion and extends f to show next occurrence
  {
    "ggandor/leap.nvim",
    event = "BufRead",
    config = function()
      require("leap").set_default_keymaps()
    end,
  },
  -- auto close/rename html tags
  {
    "windwp/nvim-ts-autotag",
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
  -- todo comments styles
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
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

      -- doing colorize({ "*" }), slows telescope rg
      colorizer.setup({ "css" }, {
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
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-lua/popup.nvim" },
    },
    config = function()
      require("harpoon").setup {
        menu = { width = 100, height = 10 },
      }
    end,
  },
  {
    "caenrique/nvim-maximize-window-toggle",
    cmd = "ToggleOnly",
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

  -- better git
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
  },
  -- a way to open visually selected lines in github
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitlinker").setup()
    end,
  },
  -- show file name top
  {
    "b0o/incline.nvim",
    config = function()
      require("user.incline").config()
    end,
    enabled = false,
  },

  -- use builtin breadcrumb option
  {
    "fgheng/winbar.nvim",
    config = function()
      require("user.winb").config()
    end,
    event = { "InsertEnter", "CursorMoved" },
    enabled = false,
  },
  {
    "nvim-telescope/telescope-live-grep-args.nvim",
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("user.symbols_outline").config()
    end,
    cmd = "SymbolsOutline",
  },
  -- sticky scroll
  {
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup()
    end,
  },
  -- extend text objects
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  },

  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("user.rust_tools").config()
    end,
    ft = { "rust", "rs" },
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup {
          -- LunarVim users need to specify path to the plugin manager
          plugin_manager_path = os.getenv "LUNARVIM_RUNTIME_DIR" .. "/site/pack/packer",
        }
      end, 100)
    end,
    enabled = false,
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
    enabled = false,
  },

  -- copilot integration
  {
    "github/copilot.vim",
    config = function()
      require("user.copilot").config()
    end,
  },
  -- better tab, integrates with cmp and copilot
  {
    "abecodes/tabout.nvim",
    after = { "nvim-cmp" },
    config = function()
      require("user.tabout").config()
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    config = function()
      require("user.bqf").config()
    end,
  },
  -- cmp completeion for cmdline
  {
    "hrsh7th/cmp-cmdline",
  },

  -- better virtual text errors, disable causing busy moving messages
  {
    url = "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
    enabled = false,
  },
  -- better f/F
  {
    "jinh0/eyeliner.nvim",
    config = function()
      require("eyeliner").setup {
        highlight_on_key = true,
      }
    end,
  },

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

  -- {
  --   "beauwilliams/focus.nvim",
  --   config = function()
  --     require("focus").setup()
  --   end,
  -- },
}

require("user.mappings").config()
