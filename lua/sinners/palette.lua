-- The Sinners palette. Each color is named for where it comes from in Ryan Coogler's
-- "Sinners" (2025): the characters' clothes, the poster's sun, the juke joint at night.
-- The terminal slots are the same values as the Omarchy theme's colors.toml (palette v0.2).
-- Contrast ratios are against `bg` (#1A0905).

---@class sinners.Palette
local M = {
  -- The juke joint: backgrounds from the poster's main art.
  bg = "#1A0905", -- darkest cluster of the main art
  bg_dark = "#140704", -- 25% toward black; floats, sidebars, statusline
  bg_darker = "#050102", -- teaser art, void black
  surface = "#371309", -- scorched brown; cursorline, raised surfaces
  rust = "#5A1F0F", -- deep rust; visual selection

  -- Cream: the teaser's title lettering and the main art's sand.
  cream = "#E8C48C", -- body text (11.7:1)
  cream_dim = "#BF9F71", -- secondary text (7.8:1)
  cream_bright = "#F8EFD9", -- title cream; cursor, emphasis (16.9:1)
  dust = "#9D8873", -- cream faded toward the background; punctuation and operators (5.7:1)
  taupe = "#857368", -- comments (4.3:1)
  mauve = "#956362", -- teaser art; quiet chrome such as inactive text (3.9:1)

  -- The sun on the poster.
  sun = "#FB7407", -- sun-edge orange, the theme's accent; constants (7.0:1)
  gold = "#F9BD06", -- sun gold; warnings, search (11.3:1)
  neon = "#F7F104", -- the neon title lettering; macros and decorators (16.2:1)
  red = "#E91A02", -- teaser red (4.3:1)
  sign = "#F8502D", -- the red painted sign; errors and tags (5.7:1)

  -- The cast.
  stack = "#D37772", -- the lit crown of Stack's fedora; keywords (6.1:1)
  stack_bright = "#F19E9B", -- (9.3:1)
  smoke = "#54ABCA", -- Smoke's newsboy cap; functions (7.4:1)
  smoke_bright = "#8BCCE5", -- (10.9:1)
  smoke_light = "#8FCBC6", -- the light on Smoke's cap and the night fog; types (10.6:1)
  smoke_light_bright = "#B1E3DE", -- escapes inside strings (13.7:1)
  sammie = "#D99F36", -- Sammie's vest in daylight; strings (8.3:1)
  foliage = "#87B188", -- the leaves behind the twins; properties, added lines (8.0:1)
  foliage_bright = "#ACD4A7", -- (11.7:1)
  strap = "#7A3C20", -- burnt umber, the leather of Sammie's guitar strap; borders and guides (2.3:1)
  chrome = "#768C82", -- the resonator guitar's chrome cone; inlay hints (5.4:1)

  none = "NONE",
}

return M
