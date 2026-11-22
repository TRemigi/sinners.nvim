local M = {}

---@param opts? sinners.Config
function M.setup(opts)
  require("sinners.config").setup(opts)
end

--- Build every highlight group without applying it. Used by `load` and by the tests.
---@return table<string, vim.api.keyset.highlight>, sinners.Colors
function M.groups()
  local opts = require("sinners.config").options
  local c = require("sinners.colors").build(opts)
  local hl = {}
  for _, name in ipairs({ "editor", "syntax", "treesitter", "lsp", "plugins" }) do
    for group, spec in pairs(require("sinners.groups." .. name)(c, opts)) do
      hl[group] = spec
    end
  end
  if opts.on_highlights then
    opts.on_highlights(hl, c)
  end
  return hl, c
end

function M.load()
  -- Re-require the modules so :colorscheme sinners picks up edits (and Omarchy's hot reload works).
  for name in pairs(package.loaded) do
    if name:match("^sinners%.") and name ~= "sinners.config" then
      package.loaded[name] = nil
    end
  end

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end
  vim.o.termguicolors = true
  vim.o.background = "dark"
  vim.g.colors_name = "sinners"

  local hl, c = M.groups()
  for group, spec in pairs(hl) do
    vim.api.nvim_set_hl(0, group, spec)
  end

  if require("sinners.config").options.terminal_colors then
    local term = {
      c.bg, c.red, c.foliage, c.gold, c.smoke, c.stack, c.smoke_light, c.cream,
      c.taupe, c.sign, c.foliage_bright, c.neon, c.smoke_bright, c.stack_bright, c.smoke_light_bright, c.cream_bright,
    }
    for i, color in ipairs(term) do
      vim.g["terminal_color_" .. (i - 1)] = color
    end
  end
end

return M
