---@param c ctender.Colors
---@param o ctender.Config
return function(c, o)
  return {
    GrugFarHelpHeader = { fg = c.muted },
    GrugFarHelpHeaderKey = { fg = c.accent, bold = true },
    GrugFarHelpWinHeader = { fg = c.fg, bold = true },
    GrugFarHelpWinActionKey = { fg = c.accent, bold = true },
    GrugFarHelpWinActionPrefix = { fg = c.muted },
    GrugFarHelpWinActionText = { fg = c.fg },
    GrugFarHelpWinActionDescription = { fg = c.muted },
    GrugFarInputLabel = { fg = c.fg, bold = true },
    GrugFarInputPlaceholder = { fg = c.muted, italic = true },
    GrugFarResultsHeader = { fg = c.fg, bold = true },
    GrugFarResultsStats = { fg = c.muted },
    GrugFarResultsActionMessage = { fg = c.accent },
    GrugFarResultsCmdHeader = { fg = c.muted },
    GrugFarResultsPath = { fg = c.fg, bold = true, underline = true },
    GrugFarResultsLineNr = { fg = c.muted },
    GrugFarResultsColumnNr = { fg = c.muted },
    GrugFarResultsNumbersSeparator = { fg = c.muted },
    GrugFarResultsNumberLabel = { fg = c.muted },
    GrugFarResultsCursorLineNo = { fg = c.fg, bold = true },
    GrugFarResultsLongLineStr = { fg = c.muted },
    GrugFarResultsMatch = { fg = c.fg_max, bg = c.search, bold = true },
    GrugFarResultsMatchAdded = { fg = c.fg_strong, bg = c.diff.add },
    GrugFarResultsMatchRemoved = { fg = c.fg_strong, bg = c.diff.delete, strikethrough = true },
    GrugFarResultsAddIndicator = { fg = c.git.add },
    GrugFarResultsRemoveIndicator = { fg = c.git.delete },
    GrugFarResultsChangeIndicator = { fg = c.git.change },
    GrugFarResultsDiffSeparatorIndicator = { fg = c.muted },
    GrugFarVisualBufrange = { bg = c.surface2 },
  }
end
