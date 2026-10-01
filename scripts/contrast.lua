-- Validates WCAG contrast of every palette color against its background.
-- Usage: nvim --headless -u NONE --cmd "set rtp^=." -l scripts/contrast.lua

local util = require("ctender.util")
local palette = require("ctender.palette")

local MIN_TEXT, MIN_UI = 4.5, 3.0
local keys = { "fg", "fg_strong", "red", "orange", "yellow", "green", "olive", "cyan", "azure", "blue", "subtle" }
local failed = false

for _, variant in ipairs({ "light", "dark" }) do
  local c = palette.get(variant, {})
  print(("\n%s  bg=%s"):format(variant:upper(), c.bg))
  for _, k in ipairs(keys) do
    local r = util.contrast(c[k], c.bg)
    local r2 = util.contrast(c[k], c.surface2)
    local ok = r >= MIN_TEXT and r2 >= MIN_TEXT
    failed = failed or not ok
    print(("  %-7s %s  on bg %5.2f  on surface2 %5.2f  %s"):format(k, c[k], r, r2, ok and "ok" or "FAIL"))
  end
  local cm = util.contrast(c.comment, c.bg)
  failed = failed or cm < MIN_TEXT
  print(("  %-7s %s  on bg %5.2f  on surface2 %5.2f  %s"):format("comment", c.comment, cm, util.contrast(c.comment, c.surface2), cm >= MIN_TEXT and "ok" or "FAIL"))
  local m = util.contrast(c.muted, c.bg)
  failed = failed or m < MIN_UI
  print(("  %-7s %s  on bg %5.2f  (UI chrome, min %.1f)"):format("muted", c.muted, m, MIN_UI))
end

-- Every group that puts text on its own fill (markers, statusline modes,
-- selected items, search, diff) must keep that text at AA too.
-- Borders, separators, powerline edges and shadows are not text.
local function skip(name)
  return name == "DiffDelete" or name:find("Sep$") or name:find("Border") or name:find("Separator")
    or name:find("Backdrop") or name:find("Shadow") or name:find("^RedrawDebug") or name == "VertSplit"
end
for _, variant in ipairs({ "light", "dark" }) do
  local c = palette.get(variant, {})
  local hl = require("ctender.groups").get(c, require("ctender.config").defaults)
  local bad = {}
  for name, spec in pairs(hl) do
    local fg, bg = spec.fg, spec.bg
    if fg and bg and fg ~= "NONE" and bg ~= "NONE" and not spec.link and not skip(name) then
      -- UI chrome (line numbers, staged signs, hidden tabs) only needs 3:1
      local ui = fg == c.muted or fg == c.faint or name:find("Staged") or name:find("Hidden")
      local min = ui and MIN_UI or MIN_TEXT
      local r = util.contrast(fg, bg)
      if r < min then
        bad[#bad + 1] = ("    %-32s %s on %s  %.2f (min %.1f)"):format(name, fg, bg, r, min)
      end
    end
  end
  table.sort(bad)
  print(("\n%s  text on fills: %s"):format(variant:upper(), #bad == 0 and "ok" or "FAIL"))
  for _, line in ipairs(bad) do
    print(line)
  end
  failed = failed or #bad > 0
end

if failed then
  os.exit(1)
end
