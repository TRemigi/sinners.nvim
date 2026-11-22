local M = {}

local function rgb(hex)
  hex = hex:gsub("#", "")
  return tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3, 4), 16), tonumber(hex:sub(5, 6), 16)
end

--- Mix `fg` over `bg`: alpha 1 is all `fg`, 0 is all `bg`.
---@param fg string
---@param bg string
---@param alpha number
---@return string
function M.blend(fg, bg, alpha)
  local fr, fg_, fb = rgb(fg)
  local br, bg_, bb = rgb(bg)
  local function mix(a, b)
    return math.floor(a * alpha + b * (1 - alpha) + 0.5)
  end
  return string.format("#%02X%02X%02X", mix(fr, br), mix(fg_, bg_), mix(fb, bb))
end

local function lin(c)
  c = c / 255
  return c <= 0.04045 and c / 12.92 or ((c + 0.055) / 1.055) ^ 2.4
end

--- WCAG relative luminance.
---@param hex string
function M.luminance(hex)
  local r, g, b = rgb(hex)
  return 0.2126 * lin(r) + 0.7152 * lin(g) + 0.0722 * lin(b)
end

--- WCAG contrast ratio between two colors.
function M.contrast(a, b)
  local x, y = M.luminance(a), M.luminance(b)
  if x < y then
    x, y = y, x
  end
  return (x + 0.05) / (y + 0.05)
end

return M
