local M = {}

---@class sinners.Config
M.defaults = {
  -- Leave the editor background unset so the terminal's shows through.
  transparent = false,
  -- Set vim.g.terminal_color_0..15 for :terminal.
  terminal_colors = true,
  -- Give floats and sidebars the darker background.
  dark_floats = true,
  -- Highlight attributes per syntax group, passed to nvim_set_hl (italic, bold, ...).
  styles = {
    comments = { italic = true },
    keywords = {},
    functions = {},
    variables = {},
    parameters = { italic = true },
    builtins = { italic = true },
  },
  -- Change palette colors before the groups are built: function(colors) colors.sammie = "#..." end
  ---@type fun(colors: sinners.Palette)?
  on_colors = nil,
  -- Change or add groups after they are built: function(hl, colors) hl.Comment = { fg = colors.mauve } end
  ---@type fun(hl: table<string, vim.api.keyset.highlight>, colors: sinners.Palette)?
  on_highlights = nil,
}

---@type sinners.Config
M.options = vim.deepcopy(M.defaults)

---@param opts? sinners.Config
function M.setup(opts)
  M.options = vim.tbl_deep_extend("force", vim.deepcopy(M.defaults), opts or {})
end

return M
