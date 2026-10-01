local util = require("ctender.util")

local M = {}

--- The full tender palette (jacoborus/tender.vim, estilos/palettes/tender.yml),
--- every one of its 27 colors, by tender's own names. Dark is tender verbatim.
--- tender has no light variant: light holds the counterpart of each color, the
--- same role on a neutral paper background (accents darkened along their own
--- hue until they pass WCAG AA, tints mixed from those accents, greys mirrored).
---@type table<"light"|"dark", ctender.Tender>
M.tender = {
  dark = {
    red1 = "#f43753",
    red2 = "#c5152f",
    red3 = "#79313c",
    blue1 = "#b3deef",
    blue2 = "#73cef4",
    blue3 = "#44778d",
    blue4 = "#335261",
    blue5 = "#293b44",
    green1 = "#c9d05c",
    green2 = "#9faa00",
    green3 = "#6a6b3f",
    green4 = "#464632",
    yellow1 = "#d3b987",
    yellow2 = "#ffc24b",
    yellow3 = "#715b2f",
    highlighted = "#ffffff",
    text = "#eeeeee",
    pearl = "#dadada",
    gandalf = "#bbbbbb",
    grey1 = "#999999",
    grey2 = "#666666",
    grey3 = "#444444",
    shadow = "#323232",
    bg = "#282828",
    dark = "#202020",
    darker = "#1d1d1d",
    darkest = "#000000",
  },
  light = {
    red1 = "#c5152f", -- tender red2 is already AA on paper
    red2 = "#a21127",
    red3 = "#ebcfd3",
    blue1 = "#2b5978",
    blue2 = "#096b96",
    blue3 = "#326d74",
    blue4 = "#d2dade",
    blue5 = "#dbe5e9",
    green1 = "#506e13", -- nudged toward green so it stays apart from tan
    green2 = "#636a00",
    green3 = "#cad1ba",
    green4 = "#d8ddce",
    yellow1 = "#7a612e",
    yellow2 = "#9e4f00", -- nudged toward orange so it stays apart from tan
    yellow3 = "#d0c9bb",
    highlighted = "#1f1f1f",
    text = "#383838",
    pearl = "#4b4b4b",
    gandalf = "#5a5a5a",
    grey1 = "#696969",
    grey2 = "#a8a8a8",
    grey3 = "#cdcdcd",
    shadow = "#eaeaea",
    bg = "#f2f2f2",
    dark = "#ececec",
    darker = "#e9e9e9",
    darkest = "#000000",
  },
}

--- Base roles. Code and UI are written against these nine names; each one is a
--- tender color. Two of them are lifted in dark because tender's value fails
--- WCAG AA as text on bg: red1 (3.9:1) and blue3 (3.0:1). The exact values
--- are still used where they are not text on bg (undercurls, marker fills).
--- `fg` is the color used for code. Four token kinds get a hue, the same ones
--- tender gives them under treesitter: strings (yellow = tender yellow1, tan),
--- functions (green = green1, lime), types (cyan = blue2, sky) and
--- constants/literals (orange = yellow2, amber). Their LSP kinds use the same
--- colors. Keywords, variables and operators stay `fg`.
--- There is no purple or pink, and `red` means *error* and nothing else.
---@type table<"light"|"dark", ctender.BasePalette>
M.base = {}
for variant, t in pairs(M.tender) do
  M.base[variant] = {
    bg = t.bg,
    fg = t.pearl, -- tender's Identifier; text #eeeeee is kept for emphasis
    red = variant == "dark" and "#f8778a" or t.red1,
    orange = t.yellow2,
    yellow = t.yellow1,
    green = t.green1,
    cyan = t.blue2,
    azure = variant == "dark" and "#70a9b2" or t.blue3,
    blue = t.blue1,
  }
end

---@class ctender.Tender
---@field red1 string    errors; exact value for undercurls and the Replace block
---@field red2 string    FIXME/BUG markers, internal errors
---@field red3 string    deleted lines (DiffDelete)
---@field blue1 string   = blue
---@field blue2 string   = cyan
---@field blue3 string   azure; exact value for NOTE markers and scrollbar thumbs
---@field blue4 string   changed lines (DiffChange), text on the Normal block
---@field blue5 string   selection (Visual, current item in lists)
---@field green1 string  = green
---@field green2 string  olive: staged git changes, snippets, checked boxes
---@field green3 string  search matches
---@field green4 string  added lines (DiffAdd), text on the Insert block
---@field yellow1 string = yellow
---@field yellow2 string = orange
---@field yellow3 string matching paren
---@field highlighted string  text on search matches and markers, ANSI bright white
---@field text string    emphasis: titles, current line number, selected items
---@field pearl string   = fg
---@field gandalf string inactive bars and tabs
---@field grey1 string   comments
---@field grey2 string   invisible chars (NonText, Whitespace, EndOfBuffer)
---@field grey3 string   borders and separators
---@field shadow string  cursorline, color column (surface1)
---@field bg string      = bg
---@field dark string    folds
---@field darker string  inactive windows (bg_dim)
---@field darkest string shadows and backdrops

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
---@field tender ctender.Tender  every tender color, by tender's names
---@field olive string       tender green2
---@field fg_strong string   tender text: titles, current line number
---@field fg_max string      tender highlighted: text on search matches and markers
---@field subtle string      tender gandalf: inactive bars and tabs
---@field faint string       tender grey2: invisible characters
---@field bg_float string
---@field bg_dim string      background for inactive windows (dim_inactive)
---@field bg_fold string     folded lines
---@field shadow string      float shadows, backdrops
---@field surface1 string    cursorline, subtle rows
---@field surface2 string    active tab, statusline
---@field surface3 string    selection / match paren
---@field select string      current item in lists: popup menu, pickers, file explorers
---@field border string
---@field muted string       UI chrome only (line numbers) — never code
---@field comment string     comments: tender grey1, WCAG AA
---@field accent string      single UI focal color (matches, prompts)
---@field search string      background for search matches
---@field code { string: string, func: string, type: string, constant: string }  the only hues used in code
---@field git { add: string, change: string, delete: string, staged: string }
---@field diff { add: string, change: string, delete: string, text: string, text_add: string }
---@field diag { error: string, warn: string, info: string, hint: string, ok: string }

--- Build the full, derived color table for a variant.
---@param variant "light"|"dark"
---@param opts ctender.Config
---@return ctender.Colors
function M.get(variant, opts)
  local c = vim.deepcopy(M.base[variant]) --[[@as ctender.Colors]]
  local t = vim.deepcopy(M.tender[variant])
  local blend = util.blend

  c.variant = variant
  c.none = "NONE"
  c.tender = t

  c.olive = t.green2
  c.fg_strong = t.text
  c.fg_max = t.highlighted
  c.subtle = t.gandalf
  c.faint = t.grey2

  -- tender's chrome is neutral grey; only the selection leans blue.
  c.surface1 = t.shadow
  -- Statusline and active tab: a step above shadow, toward grey3. grey3 itself
  -- is too strong to keep every accent above 4.5:1 on it.
  c.surface2 = blend(t.grey3, t.shadow, variant == "light" and 0.2 or 0.3)
  c.surface3 = t.blue5
  c.select = t.blue5
  c.border = t.grey3
  c.comment = t.grey1
  -- Line numbers sit between tender's grey1 (comments) and grey2 (invisible
  -- chars, below 3:1), so they stay readable without competing with comments.
  c.muted = blend(t.grey1, t.grey2, 0.5)
  c.bg_dim = t.darker
  c.bg_fold = t.dark
  c.bg_float = c.bg
  c.shadow = t.darkest
  -- tender's UI focal color is lime (WildMenu, PmenuSel, TabLineSel).
  c.accent = c.green
  c.search = t.green3

  local mono = opts.mono
  c.code = {
    string = mono and c.fg or c.yellow,
    func = mono and c.fg or c.green,
    type = mono and c.fg or c.cyan,
    constant = mono and c.fg or c.orange,
  }
  -- tender: diffAdded lime, diffChanged pale blue, diffRemoved red;
  -- DiffAdd green4, DiffChange blue4, DiffDelete red3.
  c.git = { add = c.green, change = c.blue, delete = c.red, staged = t.green2 }
  c.diff = {
    add = t.green4,
    change = t.blue4,
    delete = t.red3,
    -- the changed part of a line: one step stronger, still AA for fg on it
    text = variant == "dark" and blend(t.blue3, t.blue4, 0.5) or blend(t.blue3, c.bg, 0.30),
    text_add = variant == "dark" and blend(t.green3, t.green4, 0.5) or blend(c.green, c.bg, 0.30),
  }
  c.diag = { error = c.red, warn = c.orange, info = c.cyan, hint = c.azure, ok = c.green }

  if opts.on_colors then
    opts.on_colors(c, variant)
  end
  return c
end

return M
