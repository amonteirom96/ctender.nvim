---@class ctender
local M = {}

--- Bump to invalidate every user's compiled cache after changing highlights.
M.version = "1.0.0"

local cache_dir = vim.fn.stdpath("cache") .. "/ctender"
local configured = false
local key ---@type string?

---@param opts? ctender.Config
function M.setup(opts)
  require("ctender.config").set(opts)
  configured = true
  key = nil
end

---@return ctender.Config
local function options()
  return require("ctender.config").options
end

---@return string
local function cache_key()
  if not key then
    key = configured and require("ctender.config").hash() or ("default-" .. M.version)
  end
  return key
end

---@param name string
---@return ctender.Variant
local function resolve_variant(name)
  if name == "ctender-light" then
    return "light"
  elseif name == "ctender-dark" then
    return "dark"
  end
  local v = options().variant
  if v == "light" or v == "dark" then
    return v
  end
  return vim.o.background == "light" and "light" or "dark"
end

--- Full palette (base + derived) for a variant, after `on_colors`.
---@param variant? ctender.Variant defaults to the current 'background'
---@return ctender.Colors
function M.colors(variant)
  return require("ctender.palette").get(variant or resolve_variant("ctender"), options())
end

--- Final highlight table for a variant, after `on_highlights`.
---@param variant? ctender.Variant
---@return table<string, ctender.Style>
function M.highlights(variant)
  local o = options()
  return require("ctender.groups").get(M.colors(variant), o)
end

---@param name string
---@param variant ctender.Variant
---@return string
local function build(name, variant)
  local o = options()
  local c = require("ctender.palette").get(variant, o)
  local hl = require("ctender.groups").get(c, o)
  local term = o.terminal_colors and require("ctender.terminal").ansi(c) or nil
  return require("ctender.compiler").source(name, variant, hl, term)
end

---@param prefix string
---@param keep string
local function prune(prefix, keep)
  for file in vim.fs.dir(cache_dir) do
    if vim.startswith(file, prefix) and file ~= keep then
      os.remove(cache_dir .. "/" .. file)
    end
  end
end

--- Entry point used by `colors/*.lua`.
---@param name? "ctender"|"ctender-light"|"ctender-dark"
function M.load(name)
  name = name or "ctender"
  local variant = resolve_variant(name)

  if not options().cache then
    return assert(load(build(name, variant), "=ctender"))()
  end

  local prefix = name .. "_" .. variant .. "_"
  local file = prefix .. cache_key()
  local path = cache_dir .. "/" .. file
  local fn = loadfile(path)
  if not fn then
    fn = require("ctender.compiler").write(build(name, variant), path)
    prune(prefix, file)
  end
  fn()
end

--- Rebuild the cache for the active colorscheme (e.g. after editing an
--- `on_highlights` closure whose upvalues changed).
function M.compile()
  M.clear_cache()
  local name = vim.g.colors_name
  if name and vim.startswith(name, "ctender") then
    vim.cmd.colorscheme(name)
  end
end

function M.clear_cache()
  vim.fn.delete(cache_dir, "rf")
  key = nil
end

--- Generate terminal/tool themes (ghostty, kitty, lazygit) from the palette.
---@param dir? string output directory, defaults to `<plugin>/extras`
function M.extras(dir)
  return require("ctender.extras").generate(dir)
end

return M
