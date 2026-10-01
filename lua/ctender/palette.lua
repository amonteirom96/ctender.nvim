local util = require("ctender.util")

local M = {}

--- Base palettes, taken from tender (jacoborus/tender.vim). Everything else is
--- derived from these nine colors.
--- `fg` is the color used for code. Four token kinds get a hue, the same ones
--- tender gives them under treesitter: strings (yellow, tender's tan),
--- functions (green, tender's lime), types (cyan, tender's sky blue) and
--- constants/literals (orange, tender's amber). Their LSP kinds use the same
--- colors. Keywords, variables and operators stay `fg`.
--- There is no purple or pink, and `red` means *error* and nothing else
--- (diagnostics, error messages, FIXME, git deletions).
---@type table<"light"|"dark", ctender.BasePalette>
M.base = {
  light = {
    -- tender has no light variant. This one keeps tender's neutral grey (no
    -- tint) and moves each accent along its own hue until it passes WCAG AA on
    -- bg and surface2.
    bg = "#f2f2f2",
    fg = "#4b4b4b",
    red = "#c5152f", -- tender red2
    orange = "#9e4f00", -- amber, nudged toward orange so it stays apart from tan
    yellow = "#7a612e", -- tan
    green = "#506e13", -- lime, nudged toward green so it stays apart from tan
    cyan = "#096b96", -- sky
    azure = "#326d74", -- teal (tender blue3)
    blue = "#2b5978", -- pale blue: like in dark, the accent closest to fg
  },
  dark = {
    bg = "#282828", -- tender bg
    fg = "#dadada", -- tender pearl (text #eeeeee is a notch too bright)
    red = "#f8778a", -- tender red1, lightened just enough for AA
    orange = "#ffc24b", -- tender yellow2
    yellow = "#d3b987", -- tender yellow1
    green = "#c9d05c", -- tender green1
    cyan = "#73cef4", -- tender blue2
    azure = "#70a9b2", -- tender blue3, lightened for AA
    blue = "#b3deef", -- tender blue1
  },
}

---@class ctender.BasePalette
---@field bg string
---@field fg string
---@field red string
---@field orange string
---@field yellow string
---@field green string
---@field cyan string
---@field azure string
---@field blue string

---@class ctender.Colors: ctender.BasePalette
---@field variant "light"|"dark"
---@field none "NONE"
---@field bg_float string
---@field bg_dim string      background for inactive windows (dim_inactive)
---@field surface1 string    cursorline, subtle rows
---@field surface2 string    active tab, statusline
---@field surface3 string    selection / match paren
---@field select string      current item in lists: popup menu, pickers, file explorers
---@field border string
---@field muted string       UI chrome only (line numbers, whitespace) — never code
---@field comment string     comments: fg faded toward bg, still WCAG AA
---@field accent string      single UI focal color (matches, prompts)
---@field search string      background for search matches
---@field code { string: string, func: string, type: string, constant: string }  the only hues used in code
---@field git { add: string, change: string, delete: string }
---@field diag { error: string, warn: string, info: string, hint: string, ok: string }

--- Build the full, derived color table for a variant.
---@param variant "light"|"dark"
---@param opts ctender.Config
---@return ctender.Colors
function M.get(variant, opts)
  local b = vim.deepcopy(M.base[variant])
  local c = b --[[@as ctender.Colors]]
  local is_light = variant == "light"
  local blend = util.blend

  c.variant = variant
  c.none = "NONE"

  -- tender's chrome is neutral grey (shadow #323232, grey3 #444444); only the
  -- selection leans blue (blue5 #293b44). Same here: surface1/2 and border are
  -- plain fg-on-bg, surface3 takes a touch of sky.
  c.surface1 = blend(c.fg, c.bg, is_light and 0.05 or 0.055)
  c.surface2 = blend(c.fg, c.bg, is_light and 0.08 or 0.085)
  c.surface3 = blend(c.cyan, c.bg, is_light and 0.14 or 0.16)
  -- Current item in every list (Pmenu, pickers, explorers). surface2 is too
  -- faint to spot at a glance, so both variants use surface3.
  c.select = c.surface3
  c.border = blend(c.fg, c.bg, is_light and 0.22 or 0.2)
  c.muted = blend(c.fg, c.bg, is_light and 0.64 or 0.50)
  -- Comments step back from the code without dropping below AA (4.5:1):
  -- tender's neutral grey, faded toward bg. Italic does the rest.
  c.comment = blend(c.fg, c.bg, is_light and 0.82 or 0.62)
  c.bg_dim = is_light and blend(c.fg, c.bg, 0.03) or util.darken(c.bg, 0.12)
  c.bg_float = c.bg
  -- tender's UI focal color is lime (WildMenu, PmenuSel, TabLineSel).
  c.accent = c.green
  -- Tinted accent, stronger than surface3 so it reads apart from Visual.
  c.search = blend(c.accent, c.bg, is_light and 0.25 or 0.30)

  local mono = opts.mono
  c.code = {
    string = mono and c.fg or c.yellow,
    func = mono and c.fg or c.green,
    type = mono and c.fg or c.cyan,
    constant = mono and c.fg or c.orange,
  }
  -- tender: diffAdded lime, diffChanged pale blue, diffRemoved red
  c.git = { add = c.green, change = c.blue, delete = c.red }
  c.diag = { error = c.red, warn = c.orange, info = c.cyan, hint = c.azure, ok = c.green }

  if opts.on_colors then
    opts.on_colors(c, variant)
  end
  return c
end

return M
