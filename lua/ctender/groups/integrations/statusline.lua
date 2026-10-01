--- Groups for a hand-written statusline (`%#StModeNormal#`, `%#StGit#`, ...).
--- Each mode gets a filled block plus a `Sep` group for the powerline edge.

local util = require("ctender.util")

---@param c ctender.Colors
---@param o ctender.Config
return function(c, o)
  local bg = c.surface2
  local hl = {
    StProject = { fg = c.blue, bg = bg },
    StGit = { fg = c.green, bg = bg },
    StError = { fg = c.diag.error, bg = bg },
    StWarn = { fg = c.diag.warn, bg = bg },
    StInfo = { fg = c.diag.info, bg = bg },
    StHint = { fg = c.diag.hint, bg = bg },
    StLsp = { fg = c.accent, bg = bg },
  }

  -- Modes follow tender's airline theme: normal blue4 on blue1, insert green4
  -- on green1, visual on amber, replace on red1. No purple in the palette:
  -- Command takes azure, like ANSI magenta does. When tender's shade is not
  -- AA on its block (light variant), the text falls back to the most readable
  -- of bg and black.
  local t = c.tender
  local modes = {
    Normal = { c.blue, t.blue4 },
    Insert = { c.green, t.green4 },
    Visual = { c.orange },
    Replace = { t.red1 },
    Command = { c.azure },
    Other = { c.cyan },
  }
  for mode, m in pairs(modes) do
    local color, shade = m[1], m[2]
    local text = (shade and util.contrast(shade, color) >= 4.5) and shade or util.readable(color, c.bg, t.darkest)
    hl["StMode" .. mode] = { fg = text, bg = color, bold = true }
    hl["StMode" .. mode .. "Sep"] = { fg = color, bg = bg }
  end

  return hl
end
