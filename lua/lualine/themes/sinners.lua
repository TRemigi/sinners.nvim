-- lualine theme. Each mode takes a color from the film: normal is the sun, insert is Smoke,
-- visual is Stack, replace is the red sign, command is Sammie.
local c = require("sinners.colors").build(require("sinners.config").options)

local function mode(color)
  return {
    a = { fg = c.bg, bg = color, gui = "bold" },
    b = { fg = color, bg = c.surface },
    c = { fg = c.cream_dim, bg = c.bg_statusline },
  }
end

return {
  normal = mode(c.sun),
  insert = mode(c.smoke),
  visual = mode(c.stack),
  replace = mode(c.sign),
  command = mode(c.sammie),
  terminal = mode(c.smoke_light),
  inactive = {
    a = { fg = c.taupe, bg = c.bg_statusline },
    b = { fg = c.taupe, bg = c.bg_statusline },
    c = { fg = c.taupe, bg = c.bg_statusline },
  },
}
