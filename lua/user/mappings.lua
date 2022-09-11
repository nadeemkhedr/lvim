local M = {}

M.toggle_qf = function()
  local qf_open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_open = true
    end
  end
  if qf_open == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  end
end

M.config = function()
  -- keymappings
  lvim.leader = "space"
  lvim.keys.normal_mode["Y"] = "y$"
  lvim.keys.visual_mode["p"] = [["_dP]]

  -- n/N always center
  vim.api.nvim_set_keymap("n", "n", "nzzzv", { noremap = true })
  vim.api.nvim_set_keymap("n", "N", "Nzzzv", { noremap = true })

  -- Undo break points
  vim.api.nvim_set_keymap("i", ",", ",<c-g>u", { noremap = true })
  vim.api.nvim_set_keymap("i", ".", ".<c-g>u", { noremap = true })
  vim.api.nvim_set_keymap("i", "!", "!<c-g>u", { noremap = true })
  vim.api.nvim_set_keymap("i", "?", "?<c-g>u", { noremap = true })
  vim.api.nvim_set_keymap("i", "[", "[<c-g>u", { noremap = true })

  -- Easy colon, shift not needed
  vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
  vim.api.nvim_set_keymap("v", ";", ":", { noremap = true })
  vim.api.nvim_set_keymap("n", ":", ";", { noremap = true })
  vim.api.nvim_set_keymap("v", ":", ";", { noremap = true })

  -- remove alt j/k, doesn't play well in macos, when pressing esc-j/k quickly they do the mapping
  lvim.keys.normal_mode["<A-j>"] = false
  lvim.keys.normal_mode["<A-k>"] = false

  lvim.keys.insert_mode["<A-j>"] = false
  lvim.keys.insert_mode["<A-k>"] = false

  -- splitv go to def
  lvim.keys.normal_mode["gv"] = "<cmd>vsplit | lua vim.lsp.buf.definition()<cr>"
  lvim.lsp.buffer_mappings.normal_mode["ga"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" }
  lvim.lsp.buffer_mappings.normal_mode["gA"] = {
    "<cmd>lua if vim.bo.filetype == 'rust' then vim.cmd[[RustHoverActions]] else vim.lsp.codelens.run() end<CR>",
    "CodeLens Action",
  }
  lvim.lsp.buffer_mappings.normal_mode["gI"] = {
    "<cmd>lua require('user.telescope').lsp_implementations()<CR>",
    "Goto Implementation",
  }

  -- Bufferline commands
  lvim.keys.normal_mode["<S-l>"] = "<Cmd>BufferLineCycleNext<CR>"
  lvim.keys.normal_mode["<S-h>"] = "<Cmd>BufferLineCyclePrev<CR>"
  lvim.keys.normal_mode["[b"] = "<Cmd>BufferLineMoveNext<CR>"
  lvim.keys.normal_mode["]b"] = "<Cmd>BufferLineMovePrev<CR>"
  lvim.builtin.which_key.mappings["c"] = { "<CMD>bdelete!<CR>", "Close Buffer" }

  -- Whichkey

  local whk_status, whk = pcall(require, "which-key")
  if not whk_status then
    return
  end

  whk.register {
    ["<leader><leader>"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", " Harpoon" },
    ["<leader>1"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", " goto1" },
    ["<leader>2"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", " goto2" },
    ["<leader>3"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", " goto3" },
    ["<leader>4"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", " goto4" },

    ["<leader>v"] = { "<cmd>vsplit<cr>", "split right" },
    ["<leader>x"] = { "<cmd>close<cr>", "close pane" },
  }

  lvim.keys.normal_mode["<esc><esc>"] = "<cmd>nohlsearch<cr>"
  lvim.keys.normal_mode["<cr>"] = {
    "<cmd>ToggleOnly<cr>",
    { noremap = true, silent = true, nowait = true },
  }

  lvim.builtin.which_key.mappings["e"] = { "<cmd>NvimTreeFindFileToggle<CR>", "Explorer find" }

  if lvim.builtin.dap.active then
    lvim.builtin.which_key.mappings["de"] = { "<cmd>lua require('dapui').eval()<cr>", "Eval" }
    lvim.builtin.which_key.mappings["dU"] = { "<cmd>lua require('dapui').toggle()<cr>", "Toggle UI" }
  end

  -- Move packer keys to 'P', and update 'p' to paste from clipboard
  lvim.builtin.which_key.mappings["P"] = lvim.builtin.which_key.mappings["p"]
  lvim.builtin.which_key.mappings["p"] = { '"+p', "paste from clipboard" }

  lvim.builtin.which_key.mappings.s.name = " Search"
  lvim.builtin.which_key.mappings["ss"] = {
    "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>",
    "String",
  }

  lvim.builtin.which_key.vmappings["y"] = { '"+y', "yank to clipboard" }

  lvim.builtin.which_key.mappings["a"] = {
    name = "+Actions",
    a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", " Add Mark" },
    l = { "<cmd>IndentBlanklineToggle<cr>", "Toggle Indent line" },
    m = {
      "<cmd>lua require('lsp_lines').toggle()<cr>",
      "識LSP Lines",
    },
  }

  lvim.builtin.which_key.mappings.g.l = { "<cmd>GitBlameToggle<cr>", "Git blame" }
  lvim.builtin.which_key.mappings.g.d = { "<cmd>DiffviewOpen<cr>", "Diffview HEAD" }
  lvim.builtin.which_key.mappings.g.h = { "<cmd>DiffviewFileHistory<cr>", "Diffview file history" }
  -- lvim.builtin.which_key.mappings.l.d = { "<cmd>TroubleToggle<cr>", "Diagnostics" }
  -- lvim.builtin.which_key.mappings.l.R = { "<cmd>TroubleToggle lsp_references<cr>", "References" }
  lvim.builtin.which_key.mappings.l.o = { "<cmd>SymbolsOutline<cr>", "Outline" }
  lvim.builtin.which_key.mappings.l.r = { "<cmd>lua require('renamer').rename()<cr>", "Rename" }
  lvim.builtin.which_key.mappings["r"] = {
    name = "+Replace",
    r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
    f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
  }
  lvim.builtin.which_key.mappings["o"] = {
    name = "+Open",
    e = { "<cmd>lua require('user.utils').open_env_file()<cr>", "open env file" },
    c = { "<cmd>e ~/configfiles/README.md<cr>", "open configfiles" },
    v = { "<cmd>e ~/.config/lvim/config.lua<cr>", "open lvim config" },
    s = { "<cmd>e ~/.local/share/lunarvim/lvim/init.lua<cr>", "open lvim core project" },
  }
  lvim.builtin.which_key.mappings["t"] = {
    name = " +Test",
    f = { "<cmd>TestFile<cr>", "File" },
    n = { "<cmd>TestNearest<cr>", "Nearest" },
    s = { "<cmd>TestSuite<cr>", "Suite" },
  }

  lvim.builtin.which_key.mappings["n"] = {
    name = "+Work",
    t = { "<cmd>lua require('user.telescope').work_studio_fe()<cr>", "FE files" },
    p = { "<cmd>lua require('user.telescope').work_studio_fe_search()<cr>", "FE files (Search)" },
    s = { "<cmd>lua require('user.telescope').work_studio_be()<cr>", "BE files" },
    f = { "<cmd>lua require('user.telescope').work_studio_be_search()<cr>", "BE files (Search)" },
  }

  lvim.keys.normal_mode["E"] = ":SidebarNvimToggle<cr>"
end

return M
