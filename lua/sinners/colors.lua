-- The palette plus the colors derived from it: tinted backgrounds for diffs, diagnostics and
-- search, and the role names the highlight groups use. Groups refer to roles (c.keyword), not
-- to raw palette names, so the role map lives in one place.
local util = require("sinners.util")

local M = {}

---@param opts sinners.Config
function M.build(opts)
  ---@class sinners.Colors: sinners.Palette
  local c = vim.deepcopy(require("sinners.palette"))
  if opts.on_colors then
    opts.on_colors(c)
  end
  local blend = function(fg, a)
    return util.blend(fg, c.bg, a)
  end

  -- Syntax roles.
  c.keyword = c.stack
  c.func = c.smoke
  c.string = c.sammie
  c.escape = c.smoke_light_bright
  c.type = c.smoke_light
  c.property = c.foliage
  c.constant = c.sun
  c.builtin = c.stack
  c.tag = c.sign
  c.macro = c.neon
  c.variable = c.cream
  c.punct = c.dust
  c.comment = c.taupe

  -- Diagnostics.
  c.error = c.sign
  c.warning = c.gold
  c.info = c.smoke
  c.hint = c.smoke_light
  c.ok = c.foliage

  -- Git.
  c.git_add = c.foliage
  c.git_change = c.smoke
  c.git_delete = c.sign

  -- Surfaces.
  c.bg_editor = opts.transparent and c.none or c.bg
  c.bg_float = opts.transparent and c.none or (opts.dark_floats and c.bg_dark or c.bg)
  c.bg_sidebar = c.bg_float
  c.bg_statusline = c.bg_dark
  c.bg_visual = c.rust
  c.bg_search = blend(c.gold, 0.30)
  c.bg_current_search = c.gold
  c.border = c.strap
  c.gutter = blend(c.taupe, 0.82) -- line numbers: quiet, but readable (3.3:1)
  c.guide = blend(c.strap, 0.55)

  -- Tinted backgrounds. Diffs are strong enough to read at a glance; the rest stay quiet.
  c.diff_add = blend(c.foliage, 0.20)
  c.diff_change = blend(c.smoke, 0.16)
  c.diff_text = blend(c.smoke, 0.34)
  c.diff_delete = blend(c.sign, 0.20)
  c.diff_add_inline = blend(c.foliage, 0.36)
  c.diff_delete_inline = blend(c.sign, 0.36)
  c.error_bg = blend(c.error, 0.12)
  c.warning_bg = blend(c.warning, 0.10)
  c.info_bg = blend(c.info, 0.12)
  c.hint_bg = blend(c.hint, 0.10)
  c.ok_bg = blend(c.ok, 0.12)
  c.inlay_bg = blend(c.chrome, 0.10)
  c.reference = blend(c.cream, 0.10)

  return c
end

return M
