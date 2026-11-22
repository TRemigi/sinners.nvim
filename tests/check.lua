-- Run from the repo root:
--   nvim --headless --clean -n -u NONE --cmd "set rtp^=." -l tests/check.lua
-- Loads the colorscheme and checks that every link points at a defined group, every color is
-- a valid hex value, and every text color can be read on the background it is drawn on.
-- Exits 1 on any failure.

vim.cmd.colorscheme("sinners")
local util = require("sinners.util")
local hl, c = require("sinners").groups()
local failures = {}
local function fail(msg)
  failures[#failures + 1] = msg
end

-- Minimum contrast for text against the editor background. Comments, line numbers and other
-- deliberately quiet text get a lower floor; borders and guides are not text and are skipped.
local QUIET = 3.2
local TEXT = 4.3
local quiet = {
  Comment = true, ["@comment"] = true, LineNr = true, LineNrAbove = true, LineNrBelow = true,
  SignColumn = true, FoldColumn = true, DiagnosticUnnecessary = true, LspCodeLens = true,
  StatusLineNC = true, WinBarNC = true, TabLine = true, NonText = true, Whitespace = true,
  SpecialKey = true, EndOfBuffer = true, Ignore = true, Conceal = true,
}
-- Colors that are quiet on purpose (comments, metadata, line numbers) get the lower floor
-- wherever they are used; borders and guides are lines, not text, and are skipped.
local quiet_colors = { taupe = true, comment = true, mauve = true, chrome = true, gutter = true }
local not_text = { strap = true, guide = true, border = true, bg = true, bg_dark = true, bg_darker = true }

-- Invisible on purpose: the ~ past the last line, and a separator that should vanish.
local hidden = { EndOfBuffer = true, NeoTreeWinSeparator = true }

local reverse = {}
for name, value in pairs(c) do
  if type(value) == "string" then
    reverse[value:upper()] = reverse[value:upper()] or name
  end
end

local checked = 0
for group, spec in pairs(hl) do
  if hidden[group] then
    goto continue
  end
  if spec.link then
    if hl[spec.link] == nil and vim.fn.hlexists(spec.link) == 0 then
      fail(("%s links to undefined group %s"):format(group, spec.link))
    end
  end
  for _, key in ipairs({ "fg", "bg", "sp" }) do
    local v = spec[key]
    if v ~= nil and v ~= "NONE" and not (type(v) == "string" and v:match("^#%x%x%x%x%x%x$")) then
      fail(("%s.%s is not a hex color: %s"):format(group, key, tostring(v)))
    end
  end
  -- Contrast: only foregrounds drawn on the editor background (no bg of their own).
  local fg = spec.fg
  if fg and fg ~= "NONE" and not spec.bg and not spec.link then
    local name = reverse[fg:upper()]
    if not (name and not_text[name]) then
      checked = checked + 1
      local ratio = util.contrast(fg, c.bg)
      local floor = (quiet[group] or quiet_colors[name]) and QUIET or TEXT
      if ratio < floor then
        fail(("%s: %s (%s) is %.2f:1 on the background, below %.1f"):format(group, fg, name or "?", ratio, floor))
      end
    end
  end
  -- Text on its own background (badges, selections) must also be readable.
  local fg_name = spec.fg and reverse[spec.fg:upper()]
  if spec.fg and spec.bg and spec.fg ~= "NONE" and spec.bg ~= "NONE" and not not_text[fg_name or ""] then
    checked = checked + 1
    local ratio = util.contrast(spec.fg, spec.bg)
    local floor = (quiet[group] or quiet_colors[fg_name or ""]) and QUIET or TEXT
    if ratio < floor then
      fail(("%s: %s on %s is %.2f:1, below %.1f"):format(group, spec.fg, spec.bg, ratio, floor))
    end
  end
  ::continue::
end

local count = vim.tbl_count(hl)
if #failures > 0 then
  table.sort(failures)
  io.stderr:write(table.concat(failures, "\n") .. "\n")
  io.stderr:write(("%d of %d groups failed (%d color pairs checked)\n"):format(#failures, count, checked))
  os.exit(1)
end
print(("ok: %d groups, %d color pairs checked"):format(count, checked))
