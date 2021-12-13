local M = {}
local nls_helpers = require "null-ls.helpers"

M.config = function()
  -- NOTE: By default, all null-ls providers are checked on startup.
  -- If you want to avoid that or want to only set up the provider
  -- when you opening the associated file-type,
  -- then you can use filetype plugins for this purpose.
  -- https://www.lunarvim.org/languages/#lazy-loading-the-formatter-setup
  local status_ok, nls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  -- you can either config null-ls itself
  nls.config {
    debounce = 150,
    save_after_format = false,
    sources = {
      nls_helpers.conditional(function(utils) -- eslint deamon when there is .eslintrc.js
        return utils.root_has_file ".eslintrc.js" and nls.builtins.formatting.eslint_d.with {
          prefer_local = "node_modules/.bin",
        } or nls.builtins.formatting.prettierd.with { prefer_local = "node_modules/.bin" }
      end),
      nls.builtins.diagnostics.eslint_d.with { prefer_local = "node_modules/.bin" }, -- eslint deamon
      nls.builtins.code_actions.eslint_d.with { prefer_local = "node_modules/.bin" }, -- eslint code actions

      nls.builtins.formatting.stylua, -- lua format
      nls.builtins.diagnostics.luacheck, -- lua lint

      nls.builtins.formatting.shfmt.with { extra_args = { "-i", "2", "-ci" } }, -- shell fmt
      nls.builtins.diagnostics.shellcheck, -- shell lint
      nls.builtins.code_actions.shellcheck, -- shell code actions

      nls.builtins.diagnostics.markdownlint.with {
        filetypes = { "markdown" },
      },
      nls.builtins.formatting.goimports, -- go fmt
      nls.builtins.formatting.sqlformat, -- sql fmt
      nls.builtins.formatting.terraform_fmt, -- terraform fmt
      nls.builtins.diagnostics.hadolint, -- dockerlint
      nls.builtins.hover.dictionary,
    },
  }
end

return M
