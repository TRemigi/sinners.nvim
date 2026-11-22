-- Diagnostics, LSP references, inlay hints and semantic tokens. Semantic tokens link to the
-- treesitter groups, so a language server never paints a token differently from the parser
-- unless it knows something the parser does not (a read-only variable, a deprecated call).
---@param c sinners.Colors
---@param opts sinners.Config
return function(c, opts)
  local hl = {
    DiagnosticError = { fg = c.error },
    DiagnosticWarn = { fg = c.warning },
    DiagnosticInfo = { fg = c.info },
    DiagnosticHint = { fg = c.hint },
    DiagnosticOk = { fg = c.ok },
    DiagnosticVirtualTextError = { fg = c.error, bg = c.error_bg },
    DiagnosticVirtualTextWarn = { fg = c.warning, bg = c.warning_bg },
    DiagnosticVirtualTextInfo = { fg = c.info, bg = c.info_bg },
    DiagnosticVirtualTextHint = { fg = c.hint, bg = c.hint_bg },
    DiagnosticVirtualTextOk = { fg = c.ok, bg = c.ok_bg },
    DiagnosticVirtualLinesError = { link = "DiagnosticVirtualTextError" },
    DiagnosticVirtualLinesWarn = { link = "DiagnosticVirtualTextWarn" },
    DiagnosticVirtualLinesInfo = { link = "DiagnosticVirtualTextInfo" },
    DiagnosticVirtualLinesHint = { link = "DiagnosticVirtualTextHint" },
    DiagnosticUnderlineError = { sp = c.error, undercurl = true },
    DiagnosticUnderlineWarn = { sp = c.warning, undercurl = true },
    DiagnosticUnderlineInfo = { sp = c.info, undercurl = true },
    DiagnosticUnderlineHint = { sp = c.hint, undercurl = true },
    DiagnosticUnderlineOk = { sp = c.ok, undercurl = true },
    DiagnosticUnnecessary = { fg = c.taupe, italic = true },
    DiagnosticDeprecated = { strikethrough = true, sp = c.taupe },

    LspReferenceText = { bg = c.reference },
    LspReferenceRead = { bg = c.reference },
    LspReferenceWrite = { bg = c.reference, underline = true, sp = c.cream_dim },
    LspReferenceTarget = { bg = c.reference },
    LspSignatureActiveParameter = { fg = c.sun, bold = true, underline = true },
    LspCodeLens = { fg = c.taupe, italic = true },
    LspCodeLensSeparator = { fg = c.guide },
    -- The guitar's chrome: text the editor adds, not text you wrote.
    LspInlayHint = { fg = c.chrome, bg = c.inlay_bg, italic = true },
    LspInfoBorder = { link = "FloatBorder" },

    ["@lsp.type.class"] = { link = "@type" },
    ["@lsp.type.comment"] = {}, -- leave comments to treesitter (keeps @comment.todo etc.)
    ["@lsp.type.decorator"] = { link = "@attribute" },
    ["@lsp.type.enum"] = { link = "@type" },
    ["@lsp.type.enumMember"] = { link = "@constant" },
    ["@lsp.type.event"] = { link = "@type" },
    ["@lsp.type.function"] = { link = "@function" },
    ["@lsp.type.interface"] = { link = "@type" },
    ["@lsp.type.keyword"] = { link = "@keyword" },
    ["@lsp.type.lifetime"] = { fg = c.keyword, italic = true },
    ["@lsp.type.macro"] = { link = "@function.macro" },
    ["@lsp.type.method"] = { link = "@function.method" },
    ["@lsp.type.namespace"] = { link = "@module" },
    ["@lsp.type.number"] = { link = "@number" },
    ["@lsp.type.operator"] = { link = "@operator" },
    ["@lsp.type.parameter"] = { link = "@variable.parameter" },
    ["@lsp.type.property"] = { link = "@property" },
    ["@lsp.type.selfKeyword"] = { link = "@variable.builtin" },
    ["@lsp.type.selfTypeKeyword"] = { link = "@type" },
    ["@lsp.type.string"] = { link = "@string" },
    ["@lsp.type.struct"] = { link = "@type" },
    ["@lsp.type.type"] = { link = "@type" },
    ["@lsp.type.typeAlias"] = { link = "@type.definition" },
    ["@lsp.type.typeParameter"] = { fg = c.type, italic = true },
    ["@lsp.type.variable"] = {}, -- treesitter already colors variables, and knows builtins better
    ["@lsp.type.builtinType"] = { link = "@type.builtin" },
    ["@lsp.type.formatSpecifier"] = { link = "@string.escape" },
    ["@lsp.type.escapeSequence"] = { link = "@string.escape" },
    ["@lsp.type.unresolvedReference"] = { sp = c.error, undercurl = true },

    ["@lsp.mod.deprecated"] = { strikethrough = true },
    ["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.method.defaultLibrary"] = { link = "@function.builtin" },
    ["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
    -- Not readonly: in TypeScript every `const` binding is readonly, and they are not all constants.
    ["@lsp.typemod.variable.static"] = { link = "@constant" },
    ["@lsp.typemod.keyword.async"] = { link = "@keyword.coroutine" },
    -- rust-analyzer: a mutable binding is underlined, so `mut` reads at every use, not only the declaration.
    ["@lsp.mod.mutable.rust"] = { underline = true, sp = c.dust },
    ["@lsp.typemod.variable.mutable.rust"] = { underline = true, sp = c.dust },
  }
  return hl
end
