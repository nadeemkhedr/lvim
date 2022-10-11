local M = {}

M.config = function()
  local opts = {
    auto_enable = true,
    magic_window = true,
    auto_resize_height = false,
    preview = {
      auto_preview = false,
      show_title = true,
      delay_syntax = 50,
      wrap = false,
    },
    func_map = {
      tab = "t",
      openc = "o",
      drop = "O",
      split = "s",
      vsplit = "v",
      stoggleup = "M",
      stoggledown = "m",
      stogglevm = "m",
      filterr = "f",
      filter = "F",
      prevhist = "<",
      nexthist = ">",
      sclear = "c",
    },
  }
  require("bqf").setup(opts)
end

return M
