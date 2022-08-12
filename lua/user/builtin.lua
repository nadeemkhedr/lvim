local M = {}
M.config = function()
  local kind = require "user.lsp_icons"

  -- NvimTree
  -- =========================================
  -- lvim.builtin.nvimtree.hide_dotfiles = 0
  -- vim.g.nvim_tree_indent_markers = 1
  lvim.builtin.nvimtree.setup.view.width = 60
  lvim.builtin.nvimtree.setup.diagnostics = {
    enable = true,
    icons = {
      hint = kind.icons.hint,
      info = kind.icons.info,
      warning = kind.icons.warn,
      error = kind.icons.error,
    },
  }
  lvim.builtin.nvimtree.setup.renderer.icons.glyphs = kind.nvim_tree_icons

  -- Telescope
  -- =========================================
  lvim.builtin.telescope.defaults.path_display = {} -- display full path
  lvim.builtin.telescope.defaults.mappings = {
    i = {
      ["<esc>"] = require("telescope.actions").close,
      ["<tab>"] = require("telescope.actions.layout").toggle_preview,
    },
  }

  -- Bufferline
  -- =========================================
  local List = require "plenary.collections.py_list"
  lvim.builtin.bufferline.options.diagnostics_indicator = function(_, _, diagnostics)
    local result = {}
    local symbols = { error = kind.icons.error, warning = kind.icons.warn, info = kind.icons.info }
    for name, count in pairs(diagnostics) do
      if symbols[name] and count > 0 then
        table.insert(result, symbols[name] .. count)
      end
    end
    result = table.concat(result, " ")
    return #result > 0 and result or ""
  end

  lvim.builtin.bufferline.options.groups = {
    options = {
      toggle_hidden_on_enter = true,
    },
    items = {
      { name = "ungrouped" },
      {
        highlight = { guisp = "#51AFEF" },
        name = "tests",
        icon = kind.icons.test,
        matcher = function(buf)
          return buf.filename:match "_spec" or buf.filename:match "test"
        end,
      },
      {
        name = "view models",
        highlight = { guisp = "#03589C" },
        matcher = function(buf)
          return buf.filename:match "view_model%.dart"
        end,
      },
      {
        name = "screens",
        icon = kind.icons.screen,
        matcher = function(buf)
          return buf.path:match "screen"
        end,
      },
      {
        highlight = { guisp = "#C678DD" },
        name = "docs",
        matcher = function(buf)
          local list = List { "md", "org", "norg", "wiki" }
          return list:contains(vim.fn.fnamemodify(buf.path, ":e"))
        end,
      },
      {
        highlight = { guisp = "#F6A878" },
        name = "config",
        matcher = function(buf)
          return buf.filename:match "go.mod"
            or buf.filename:match "go.sum"
            or buf.filename:match "Cargo.toml"
            or buf.filename:match "manage.py"
            or buf.filename:match "Makefile"
        end,
      },
    },
  }
end

return M
