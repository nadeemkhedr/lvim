local M = {}

local builtin = require "telescope.builtin"

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
