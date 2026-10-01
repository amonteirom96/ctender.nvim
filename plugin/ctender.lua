if vim.g.loaded_ctender then
  return
end
vim.g.loaded_ctender = true

local cmd = vim.api.nvim_create_user_command

cmd("CtenderCompile", function()
  require("ctender").compile()
end, { desc = "ctender: rebuild the compiled highlight cache" })

cmd("CtenderClearCache", function()
  require("ctender").clear_cache()
end, { desc = "ctender: delete the compiled highlight cache" })

cmd("CtenderExtras", function(args)
  local out = require("ctender").extras(args.args ~= "" and args.args or nil)
  vim.notify("ctender: extras written to " .. out)
end, { nargs = "?", complete = "dir", desc = "ctender: generate ghostty/kitty/lazygit themes" })
