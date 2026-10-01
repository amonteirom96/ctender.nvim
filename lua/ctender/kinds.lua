--- LSP CompletionItemKind / SymbolKind -> palette key.
--- Shared by blink.cmp, dropbar and anything else that shows kinds, so the same
--- symbol has the same color everywhere. Functions green (lime), strings yellow
--- (tan), types cyan (sky) and constants orange (amber), exactly as in the
--- code. Fields take tender's pale blue, modules and keywords its teal,
--- snippets its olive. No red (red is for errors) and no purple.
return {
  Text = "muted",
  Method = "green",
  Function = "green",
  Constructor = "cyan",
  Field = "blue",
  Variable = "fg",
  Class = "cyan",
  Interface = "cyan",
  Module = "azure",
  Property = "blue",
  Unit = "orange",
  Value = "orange",
  Enum = "orange",
  Keyword = "azure",
  Snippet = "olive",
  Color = "orange",
  File = "fg",
  Reference = "blue",
  Folder = "blue",
  EnumMember = "orange",
  Constant = "orange",
  Struct = "cyan",
  Event = "cyan",
  Operator = "fg",
  TypeParameter = "orange",
  -- SymbolKind extras
  Namespace = "azure",
  Package = "azure",
  String = "yellow",
  Number = "orange",
  Boolean = "orange",
  Array = "orange",
  Object = "cyan",
  Key = "blue",
  Null = "muted",
  -- Sources
  Copilot = "azure",
  Codeium = "azure",
  Supermaven = "azure",
}
