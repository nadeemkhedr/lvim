local M = {}

local builtin = require "telescope.builtin"

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
