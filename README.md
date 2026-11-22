# sinners.nvim

A dark Neovim colorscheme from Ryan Coogler's *Sinners* (2025), made for the
[Sinners Omarchy theme](https://github.com/TRemigi/omarchy-sinners-theme) and usable on its own.

Its warm colors come from the poster: the juke joint's near-black, the sun's orange and gold, and the cream of the
title lettering. The rest come from the film, and the colors are named for the characters they come from:

| Name | From | In code |
| --- | --- | --- |
| `stack` `#D37772` | the lit crown of Stack's fedora | keywords, builtins (`self`, `this`), Rust lifetimes |
| `smoke` `#54ABCA` | Smoke's newsboy cap | functions and methods |
| `smoke_light` `#8FCBC6` | the light on Smoke's cap, and the night fog | types, classes, modules |
| `sammie` `#D99F36` | Sammie's vest, in daylight | strings |
| `sun` `#FB7407` | the sun's edge on the poster | constants, numbers, booleans; the accent |
| `foliage` `#87B188` | the leaves behind the twins | properties and fields; added lines |
| `sign` `#F8502D` | the red painted sign | tags, errors, deleted lines |
| `neon` `#F7F104` | the neon title lettering | macros, decorators, attributes |
| `cream` `#E8C48C` | the title cream | variables; parameters in italic |
| `taupe` `#857368` | the cream, faded | comments, in italic |
| `strap` `#7A3C20` | the leather of Sammie's guitar strap | borders, separators, indent guides |
| `chrome` `#768C82` | the guitar's chrome cone | inlay hints and blame: text the editor adds |

The editor modes in the statusline follow the same cast: normal is the sun, insert is Smoke, visual is Stack,
replace is the sign, command is Sammie.

Code text is at least 4.3:1 against the background (`#1A0905`), and comments are at that floor. Line numbers are
quieter on purpose, at 3.3:1. `tests/check.lua` checks this for every group.

## Install

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "TRemigi/sinners.nvim",
  name = "sinners",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("sinners")
  end,
}
```

In LazyVim, set `colorscheme = "sinners"` in the `LazyVim/LazyVim` spec's `opts` instead of the `config` function.

### With the Omarchy theme

The Omarchy theme ships a `neovim.lua` that loads this plugin, so `omarchy theme set sinners` switches Neovim too,
with Omarchy's hot reload. That works when the theme is a local copy or a link in `~/.config/omarchy/themes`.

A theme installed with `omarchy theme install <git url>` is different: Omarchy does not stage any `.lua` file from
a theme it cloned, because Lua runs code. Neovim then gets Omarchy's generic theme instead. To use this one, add the
spec above to your own Neovim config.

## Options

`setup` is optional; call it before `:colorscheme sinners`.

```lua
require("sinners").setup({
  transparent = false, -- leave the background unset so the terminal's shows through
  terminal_colors = true, -- set the 16 :terminal colors from the palette
  dark_floats = true, -- give floats and sidebars the darker background
  styles = {
    comments = { italic = true },
    keywords = {},
    functions = {},
    variables = {},
    parameters = { italic = true },
    builtins = { italic = true },
  },
  -- Change palette colors before the groups are built.
  on_colors = function(colors) end,
  -- Change or add groups after they are built.
  on_highlights = function(hl, colors) end,
})
```

The roles live in one place, `lua/sinners/colors.lua`. In `on_colors`, set a role to move every group that uses
it: `colors.string = colors.foliage` makes every string green.

For lualine, use `theme = "sinners"`.

## Languages

The theme colors nvim-treesitter's standard captures and the LSP semantic tokens, with corrections for JavaScript
and TypeScript (including JSX and TSX), Go, PHP, Python and Rust, where a capture means something different.
Some examples:

- Rust lifetimes are Stack's italic, with the `'` that marks them.
- Go format verbs (`%d`, `%q` in `Printf`, `Errorf` and the like) are colored like escapes.
- Python docstrings are Sammie in italic.
- Semantic tokens link back to the treesitter groups, so a language server never repaints a token in a different
  color unless it knows something the parser does not. For example, rust-analyzer underlines mutable bindings.

Install the treesitter parser for each language you use (LazyVim's language extras do this). Without one, Neovim
falls back to its regex syntax files, which this theme covers only roughly.

## Plugins

blink.cmp, nvim-cmp, gitsigns, flash, which-key, noice, nvim-notify, snacks (picker, dashboard, notifier, indent,
input), trouble, mini (icons, indentscope, hipatterns, statusline, surround, cursorword), treesitter-context,
render-markdown, grug-far, nvim-dap, dap-ui, dap-virtual-text, neotest, todo-comments, vim-illuminate, lazy.nvim,
mason, telescope, fzf-lua, neo-tree, harpoon, lualine.

## Checking a change

```sh
nvim --headless --clean -n -u NONE --cmd "set rtp^=." -l tests/check.lua
```

It loads the colorscheme and fails if a link points at an undefined group, a color is not a hex value, or text falls
below its contrast floor.
