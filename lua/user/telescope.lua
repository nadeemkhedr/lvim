local M = {}

local builtin = require "telescope.builtin"
local themes = require "telescope.themes"

function M.git_status()
  local opts = themes.get_dropdown {
    winblend = 10,
    previewer = false,
    shorten_path = false,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    layout_config = {
      width = 0.45,
      prompt_position = "top",
    },
  }
  -- Can change the git icons using this.
  -- opts.git_icons = {
  --   changed = "M"
  -- }

  builtin.git_status(opts)
end

function M.git_files()
  local path = vim.fn.expand "%:h"
  if path == "" then
    path = nil
  end

  local width = 0.45
  if path and string.find(path, "sourcegraph.*sourcegraph", 1, false) then
    width = 0.6
  end

  local opts = themes.get_dropdown {
    winblend = 5,
    previewer = false,
    shorten_path = false,
    borderchars = {
      prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
      results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
      preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    },
    border = {},
    cwd = path,
    layout_config = {
      width = width,
      prompt_position = "top",
    },
  }

  opts.file_ignore_patterns = {
    "^[.]vale/",
  }
  builtin.git_files(opts)
end

function M.grep_string_visual()
  local visual_selection = function()
    local save_previous = vim.fn.getreg "a"
    vim.api.nvim_command 'silent! normal! "ay'
    local selection = vim.fn.trim(vim.fn.getreg "a")
    vim.fn.setreg("a", save_previous)
    return vim.fn.substitute(selection, [[\n]], [[\\n]], "g")
  end
  require("telescope.builtin").live_grep {
    default_text = visual_selection(),
  }
end

-- show refrences to this using language server
function M.lsp_references()
  local opts = {
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  }
  builtin.lsp_references(opts)
end

M.work_studio_fe = function()
  builtin.find_files {
    cwd = "~/work/screencastify/screencastify",
    search_dirs = {
      "deployments/client/studio",
      "lib/studio",
    },
  }
end

M.work_studio_be = function()
  builtin.find_files {
    cwd = "~/work/screencastify/screencastify",
    search_dirs = {
      "deployments/http/studio-backend",
      "deployments/http/graphql-engine",
      "lib/studio",
    },
  }
end

M.work_studio_fe_search = function()
  builtin.live_grep {
    cwd = "~/work/screencastify/screencastify",
    search_dirs = {
      "deployments/client/studio",
      "lib/studio",
    },
  }
end

M.work_studio_be_search = function()
  builtin.live_grep {
    cwd = "~/work/screencastify/screencastify",
    search_dirs = {
      "deployments/http/studio-backend",
      "deployments/http/graphql-engine",
      "lib/studio",
    },
  }
end

return M
