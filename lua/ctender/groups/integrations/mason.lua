---@param c ctender.Colors
---@param o ctender.Config
return function(c, o)
  return {
    MasonNormal = { link = "NormalFloat" },
    MasonBackdrop = { bg = c.shadow, blend = 100 },
    MasonHeader = { fg = c.bg, bg = c.accent, bold = true },
    MasonHeaderSecondary = { fg = c.bg, bg = c.green, bold = true },
    MasonHeading = { fg = c.fg_strong, bold = true },
    MasonHighlight = { fg = c.accent },
    MasonHighlightSecondary = { fg = c.green },
    MasonHighlightBlock = { fg = c.bg, bg = c.accent },
    MasonHighlightBlockBold = { fg = c.bg, bg = c.accent, bold = true },
    MasonHighlightBlockSecondary = { fg = c.bg, bg = c.green },
    MasonHighlightBlockBoldSecondary = { fg = c.bg, bg = c.green, bold = true },
    MasonLink = { fg = c.accent, underline = true },
    MasonMuted = { fg = c.muted },
    MasonMutedBlock = { fg = c.fg, bg = c.surface2 },
    MasonMutedBlockBold = { fg = c.fg, bg = c.surface2, bold = true },
    MasonError = { fg = c.red },
    MasonWarning = { fg = c.diag.warn },
  }
end
