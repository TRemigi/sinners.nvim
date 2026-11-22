-- The legacy Vim syntax groups. Treesitter and LSP groups link back to these where they agree,
-- so a language without a parser still gets the same colors.
---@param c sinners.Colors
---@param opts sinners.Config
return function(c, opts)
  local s = opts.styles
  return {
    Comment = vim.tbl_extend("force", { fg = c.comment }, s.comments),
    SpecialComment = { fg = c.cream_dim, italic = true },
    Todo = { fg = c.bg, bg = c.gold, bold = true },

    Constant = { fg = c.constant },
    String = { fg = c.string },
    Character = { fg = c.string },
    Number = { fg = c.constant },
    Float = { fg = c.constant },
    Boolean = { fg = c.constant },

    Identifier = vim.tbl_extend("force", { fg = c.variable }, s.variables),
    Function = vim.tbl_extend("force", { fg = c.func }, s.functions),

    Statement = vim.tbl_extend("force", { fg = c.keyword }, s.keywords),
    Conditional = { link = "Statement" },
    Repeat = { link = "Statement" },
    Label = { fg = c.keyword },
    Operator = { fg = c.punct },
    Keyword = { link = "Statement" },
    Exception = { link = "Statement" },

    PreProc = { fg = c.macro },
    Include = { link = "Statement" },
    Define = { fg = c.macro },
    Macro = { fg = c.macro },
    PreCondit = { fg = c.macro },

    Type = { fg = c.type },
    StorageClass = { link = "Statement" },
    Structure = { fg = c.type },
    Typedef = { fg = c.type },

    Special = { fg = c.escape },
    SpecialChar = { fg = c.escape },
    Tag = { fg = c.tag },
    Delimiter = { fg = c.punct },
    Debug = { fg = c.sign },

    -- Vim's regex syntax for Rust, used when the treesitter parser is not installed.
    rustSelf = vim.tbl_extend("force", { fg = c.builtin }, s.builtins),
    rustLifetime = { fg = c.keyword, italic = true },
    rustAttribute = { fg = c.macro },
    rustDerive = { fg = c.macro },
    rustDeriveTrait = { fg = c.type },

    Underlined = { underline = true },
    Bold = { bold = true },
    Italic = { italic = true },
    Ignore = { fg = c.guide },
    Error = { fg = c.error },
  }
end
