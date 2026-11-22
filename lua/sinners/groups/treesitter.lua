-- Treesitter captures (nvim-treesitter's standard names), then per-language corrections
-- for JavaScript/TypeScript, Go, PHP, Python and Rust where a capture means something else.
---@param c sinners.Colors
---@param opts sinners.Config
return function(c, opts)
  local s = opts.styles
  local italic = function(fg, extra)
    return vim.tbl_extend("force", { fg = fg, italic = true }, extra or {})
  end
  local builtin = vim.tbl_extend("force", { fg = c.builtin }, s.builtins)
  local param = vim.tbl_extend("force", { fg = c.variable }, s.parameters)

  return {
    -- Identifiers
    ["@variable"] = { link = "Identifier" },
    ["@variable.builtin"] = builtin, -- this, self, $this
    ["@variable.parameter"] = param,
    ["@variable.parameter.builtin"] = vim.tbl_extend("force", param, { fg = c.builtin }), -- _, it
    ["@variable.member"] = { fg = c.property },

    ["@constant"] = { link = "Constant" },
    ["@constant.builtin"] = { fg = c.constant }, -- nil, None, true, iota
    ["@constant.macro"] = { fg = c.macro },

    ["@module"] = italic(c.type), -- packages, namespaces, imports
    ["@module.builtin"] = italic(c.type),
    ["@label"] = { fg = c.keyword },

    -- Literals
    ["@string"] = { link = "String" },
    ["@string.documentation"] = italic(c.string), -- Python docstrings
    ["@string.regexp"] = { fg = c.escape },
    ["@string.escape"] = { fg = c.escape },
    ["@string.special"] = { fg = c.escape },
    ["@string.special.symbol"] = { fg = c.constant },
    ["@string.special.path"] = { fg = c.string, underline = true },
    ["@string.special.url"] = { fg = c.smoke, underline = true },
    ["@character"] = { link = "Character" },
    ["@character.special"] = { fg = c.escape },
    ["@boolean"] = { link = "Boolean" },
    ["@number"] = { link = "Number" },
    ["@number.float"] = { link = "Float" },

    -- Types
    ["@type"] = { link = "Type" },
    ["@type.builtin"] = { fg = c.type },
    ["@type.definition"] = { fg = c.type },
    ["@attribute"] = { fg = c.macro }, -- decorators, PHP attributes
    ["@attribute.builtin"] = { fg = c.macro },
    ["@property"] = { fg = c.property },

    -- Functions
    ["@function"] = { link = "Function" },
    ["@function.builtin"] = vim.tbl_extend("force", { fg = c.func }, s.builtins), -- len, print
    ["@function.call"] = { link = "@function" },
    ["@function.macro"] = { fg = c.macro }, -- println!, #[derive]
    ["@function.method"] = { link = "@function" },
    ["@function.method.call"] = { link = "@function" },
    ["@constructor"] = { fg = c.type }, -- new Foo(), Foo{}
    ["@operator"] = { link = "Operator" },

    -- Keywords
    ["@keyword"] = { link = "Keyword" },
    ["@keyword.coroutine"] = { link = "Keyword" },
    ["@keyword.function"] = { link = "Keyword" },
    ["@keyword.operator"] = { link = "Keyword" }, -- and, or, not, in, instanceof
    ["@keyword.import"] = { link = "Keyword" },
    ["@keyword.type"] = { link = "Keyword" },
    ["@keyword.modifier"] = { link = "Keyword" },
    ["@keyword.repeat"] = { link = "Keyword" },
    ["@keyword.return"] = { link = "Keyword" },
    ["@keyword.debug"] = { fg = c.sign },
    ["@keyword.exception"] = { link = "Keyword" },
    ["@keyword.conditional"] = { link = "Keyword" },
    ["@keyword.conditional.ternary"] = { fg = c.punct },
    ["@keyword.directive"] = { fg = c.macro }, -- <?php, #!, "use strict"
    ["@keyword.directive.define"] = { fg = c.macro },

    -- Punctuation
    ["@punctuation.delimiter"] = { fg = c.punct },
    ["@punctuation.bracket"] = { fg = c.punct },
    ["@punctuation.special"] = { fg = c.escape }, -- ${ } in template strings, f-string braces

    -- Comments
    ["@comment"] = { link = "Comment" },
    ["@comment.documentation"] = { link = "Comment" },
    ["@comment.error"] = { fg = c.bg, bg = c.error, bold = true },
    ["@comment.warning"] = { fg = c.bg, bg = c.warning, bold = true },
    ["@comment.todo"] = { fg = c.bg, bg = c.smoke_light, bold = true },
    ["@comment.note"] = { fg = c.bg, bg = c.smoke, bold = true },

    -- Markup (Markdown, docs)
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.strikethrough"] = { strikethrough = true },
    ["@markup.underline"] = { underline = true },
    ["@markup.heading"] = { fg = c.sun, bold = true },
    ["@markup.heading.1"] = { fg = c.sun, bold = true },
    ["@markup.heading.2"] = { fg = c.gold, bold = true },
    ["@markup.heading.3"] = { fg = c.stack, bold = true },
    ["@markup.heading.4"] = { fg = c.smoke, bold = true },
    ["@markup.heading.5"] = { fg = c.foliage, bold = true },
    ["@markup.heading.6"] = { fg = c.cream_dim, bold = true },
    ["@markup.quote"] = { fg = c.cream_dim, italic = true },
    ["@markup.math"] = { fg = c.smoke_light },
    ["@markup.link"] = { fg = c.smoke },
    ["@markup.link.label"] = { fg = c.smoke },
    ["@markup.link.url"] = { fg = c.smoke_light, underline = true },
    ["@markup.raw"] = { fg = c.sammie },
    ["@markup.raw.block"] = { fg = c.cream },
    ["@markup.list"] = { fg = c.sun },
    ["@markup.list.checked"] = { fg = c.foliage },
    ["@markup.list.unchecked"] = { fg = c.taupe },

    ["@diff.plus"] = { link = "Added" },
    ["@diff.minus"] = { link = "Removed" },
    ["@diff.delta"] = { link = "Changed" },

    -- Tags (HTML, JSX, TSX, Vue, PHP templates)
    ["@tag"] = { fg = c.tag }, -- components and elements
    ["@tag.builtin"] = { fg = c.tag }, -- <div>, <section>
    ["@tag.attribute"] = italic(c.property),
    ["@tag.delimiter"] = { fg = c.punct },

    -- Per language.
    -- Rust: lifetime names are @attribute; they sit with the ' that the query marks as a keyword.
    ["@attribute.rust"] = italic(c.keyword),
    ["@attribute.builtin.rust"] = italic(c.keyword), -- 'static, '_
    -- Rust: `self` in a method signature reads as a parameter, but it is the receiver.
    ["@variable.builtin.rust"] = builtin,
    -- Go: the package clause and import paths.
    ["@module.go"] = italic(c.type),
    -- Format verbs (%d, %q) come from the printf injection, which captures them as @character.
    ["@character.printf"] = { fg = c.escape },
    -- Python: decorators are the call, so the @ and the name are both the macro color.
    ["@attribute.python"] = { fg = c.macro },
    -- PHP: `$` sigils stay with their variable; namespaces are modules.
    ["@module.php"] = italic(c.type),
    ["@module.php_only"] = italic(c.type),
    -- JS/TS: `this` and `super`; JSX text between tags is plain text.
    ["@variable.builtin.javascript"] = builtin,
    ["@variable.builtin.typescript"] = builtin,
    ["@variable.builtin.tsx"] = builtin,
  }
end
