-- Plugins: the ones a LazyVim setup loads by default, plus telescope, fzf-lua and neo-tree.
-- Defining a group for a plugin that is not installed costs nothing, so they are all set.
---@param c sinners.Colors
---@param opts sinners.Config
return function(c, opts)
  local hl = {}

  -- Completion item kinds, shared by blink.cmp, nvim-cmp, navic and the pickers. Each kind takes
  -- the color its syntax role has in code, so a completion list reads like the code it inserts.
  local kinds = {
    Array = c.punct, Boolean = c.constant, Class = c.type, Color = c.sammie, Constant = c.constant,
    Constructor = c.type, Copilot = c.smoke_light, Enum = c.type, EnumMember = c.constant,
    Event = c.sun, Field = c.property, File = c.cream, Folder = c.smoke, Function = c.func,
    Interface = c.type, Key = c.property, Keyword = c.keyword, Method = c.func, Module = c.type,
    Namespace = c.type, Null = c.constant, Number = c.constant, Object = c.type, Operator = c.punct,
    Package = c.type, Property = c.property, Reference = c.smoke, Snippet = c.neon, String = c.string,
    Struct = c.type, Text = c.cream_dim, TypeParameter = c.type, Unit = c.constant, Value = c.constant,
    Variable = c.variable,
  }
  for kind, fg in pairs(kinds) do
    hl["BlinkCmpKind" .. kind] = { fg = fg }
    hl["CmpItemKind" .. kind] = { fg = fg }
    hl["NavicIcons" .. kind] = { fg = fg }
    hl["LspKind" .. kind] = { fg = fg }
  end

  local add = function(t)
    for k, v in pairs(t) do
      hl[k] = v
    end
  end

  -- blink.cmp
  add({
    BlinkCmpMenu = { fg = c.cream, bg = c.bg_dark },
    BlinkCmpMenuBorder = { fg = c.border, bg = c.bg_dark },
    BlinkCmpMenuSelection = { bg = c.rust, bold = true },
    BlinkCmpScrollBarThumb = { bg = c.strap },
    BlinkCmpScrollBarGutter = { bg = c.bg_dark },
    BlinkCmpLabel = { fg = c.cream },
    BlinkCmpLabelDeprecated = { fg = c.taupe, strikethrough = true },
    BlinkCmpLabelMatch = { fg = c.sun, bold = true },
    BlinkCmpLabelDetail = { fg = c.cream_dim },
    BlinkCmpLabelDescription = { fg = c.cream_dim },
    BlinkCmpKind = { fg = c.type },
    BlinkCmpSource = { fg = c.taupe },
    BlinkCmpGhostText = { fg = c.chrome, italic = true },
    BlinkCmpDoc = { fg = c.cream, bg = c.bg_dark },
    BlinkCmpDocBorder = { fg = c.border, bg = c.bg_dark },
    BlinkCmpDocSeparator = { fg = c.guide, bg = c.bg_dark },
    BlinkCmpSignatureHelp = { fg = c.cream, bg = c.bg_dark },
    BlinkCmpSignatureHelpBorder = { fg = c.border, bg = c.bg_dark },
    BlinkCmpSignatureHelpActiveParameter = { link = "LspSignatureActiveParameter" },
  })

  -- nvim-cmp
  add({
    CmpItemAbbr = { fg = c.cream },
    CmpItemAbbrDeprecated = { fg = c.taupe, strikethrough = true },
    CmpItemAbbrMatch = { fg = c.sun, bold = true },
    CmpItemAbbrMatchFuzzy = { fg = c.sun },
    CmpItemMenu = { fg = c.taupe },
    CmpGhostText = { fg = c.chrome, italic = true },
  })

  -- gitsigns
  add({
    GitSignsAdd = { fg = c.git_add },
    GitSignsChange = { fg = c.git_change },
    GitSignsDelete = { fg = c.git_delete },
    GitSignsTopdelete = { fg = c.git_delete },
    GitSignsChangedelete = { fg = c.git_change },
    GitSignsUntracked = { fg = c.strap },
    GitSignsAddInline = { bg = c.diff_add_inline },
    GitSignsDeleteInline = { bg = c.diff_delete_inline },
    GitSignsChangeInline = { bg = c.diff_text },
    GitSignsCurrentLineBlame = { fg = c.chrome, italic = true },
  })

  -- flash.nvim: the label is the one thing to look at, so it gets the sun.
  add({
    FlashBackdrop = { fg = c.taupe },
    FlashMatch = { fg = c.cream_bright, bg = c.bg_search },
    FlashCurrent = { fg = c.bg, bg = c.gold },
    FlashLabel = { fg = c.bg, bg = c.sun, bold = true },
    FlashPrompt = { link = "NormalFloat" },
  })

  -- which-key
  add({
    WhichKey = { fg = c.sun },
    WhichKeyGroup = { fg = c.smoke },
    WhichKeyDesc = { fg = c.cream },
    WhichKeySeparator = { fg = c.taupe },
    WhichKeyValue = { fg = c.taupe },
    WhichKeyNormal = { link = "NormalFloat" },
    WhichKeyBorder = { link = "FloatBorder" },
    WhichKeyTitle = { link = "FloatTitle" },
    WhichKeyIcon = { fg = c.smoke },
  })

  -- noice and nvim-notify
  add({
    NoiceCmdline = { fg = c.cream, bg = c.bg_dark },
    NoiceCmdlineIcon = { fg = c.sun },
    NoiceCmdlineIconSearch = { fg = c.gold },
    NoiceCmdlinePopup = { fg = c.cream, bg = c.bg_dark },
    NoiceCmdlinePopupBorder = { fg = c.strap, bg = c.bg_dark },
    NoiceCmdlinePopupTitle = { fg = c.sun, bold = true },
    NoiceCmdlinePopupBorderSearch = { fg = c.gold, bg = c.bg_dark },
    NoiceConfirmBorder = { fg = c.sun, bg = c.bg_dark },
    NoiceMini = { fg = c.cream_dim, bg = c.bg_dark },
    NoiceFormatProgressDone = { fg = c.bg, bg = c.foliage },
    NoiceFormatProgressTodo = { fg = c.cream_dim, bg = c.surface },
    NoiceLspProgressTitle = { fg = c.cream_dim },
    NoiceLspProgressClient = { fg = c.smoke },
    NoiceLspProgressSpinner = { fg = c.sun },
    NotifyBackground = { bg = c.bg_dark },
    NotifyERRORBorder = { fg = c.error }, NotifyERRORIcon = { fg = c.error }, NotifyERRORTitle = { fg = c.error },
    NotifyWARNBorder = { fg = c.warning }, NotifyWARNIcon = { fg = c.warning }, NotifyWARNTitle = { fg = c.warning },
    NotifyINFOBorder = { fg = c.strap }, NotifyINFOIcon = { fg = c.info }, NotifyINFOTitle = { fg = c.info },
    NotifyDEBUGBorder = { fg = c.strap }, NotifyDEBUGIcon = { fg = c.taupe }, NotifyDEBUGTitle = { fg = c.taupe },
    NotifyTRACEBorder = { fg = c.strap }, NotifyTRACEIcon = { fg = c.stack }, NotifyTRACETitle = { fg = c.stack },
  })

  -- snacks.nvim
  add({
    SnacksNormal = { link = "NormalFloat" },
    SnacksWinBar = { link = "Title" },
    SnacksBackdrop = { bg = c.bg_darker },
    SnacksIndent = { fg = c.guide, nocombine = true },
    SnacksIndentScope = { fg = c.strap, nocombine = true },
    SnacksIndentChunk = { fg = c.strap, nocombine = true },
    SnacksInputNormal = { link = "NormalFloat" },
    SnacksInputBorder = { fg = c.sun, bg = c.bg_float },
    SnacksInputTitle = { fg = c.sun, bold = true },
    SnacksInputIcon = { fg = c.sun },
    SnacksDashboardHeader = { fg = c.sun },
    SnacksDashboardIcon = { fg = c.gold },
    SnacksDashboardKey = { fg = c.stack, bold = true },
    SnacksDashboardDesc = { fg = c.cream },
    SnacksDashboardFooter = { fg = c.taupe, italic = true },
    SnacksDashboardSpecial = { fg = c.smoke },
    SnacksDashboardDir = { fg = c.taupe },
    SnacksDashboardFile = { fg = c.cream },
    SnacksNotifierError = { fg = c.cream, bg = c.bg_dark }, SnacksNotifierBorderError = { fg = c.error, bg = c.bg_dark },
    SnacksNotifierIconError = { fg = c.error }, SnacksNotifierTitleError = { fg = c.error, bold = true },
    SnacksNotifierWarn = { fg = c.cream, bg = c.bg_dark }, SnacksNotifierBorderWarn = { fg = c.warning, bg = c.bg_dark },
    SnacksNotifierIconWarn = { fg = c.warning }, SnacksNotifierTitleWarn = { fg = c.warning, bold = true },
    SnacksNotifierInfo = { fg = c.cream, bg = c.bg_dark }, SnacksNotifierBorderInfo = { fg = c.strap, bg = c.bg_dark },
    SnacksNotifierIconInfo = { fg = c.info }, SnacksNotifierTitleInfo = { fg = c.info, bold = true },
    SnacksNotifierDebug = { fg = c.cream, bg = c.bg_dark }, SnacksNotifierBorderDebug = { fg = c.strap, bg = c.bg_dark },
    SnacksNotifierIconDebug = { fg = c.taupe }, SnacksNotifierTitleDebug = { fg = c.taupe, bold = true },
    SnacksNotifierTrace = { fg = c.cream, bg = c.bg_dark }, SnacksNotifierBorderTrace = { fg = c.strap, bg = c.bg_dark },
    SnacksNotifierIconTrace = { fg = c.stack }, SnacksNotifierTitleTrace = { fg = c.stack, bold = true },
    SnacksPickerBorder = { fg = c.border, bg = c.bg_float },
    SnacksPickerTitle = { fg = c.sun, bold = true },
    SnacksPickerInputBorder = { fg = c.sun, bg = c.bg_float },
    SnacksPickerInputTitle = { fg = c.sun, bold = true },
    SnacksPickerPrompt = { fg = c.sun },
    SnacksPickerMatch = { fg = c.sun, bold = true },
    SnacksPickerSelected = { fg = c.stack },
    SnacksPickerListCursorLine = { bg = c.surface },
    SnacksPickerPreviewCursorLine = { bg = c.surface },
    SnacksPickerDir = { fg = c.taupe },
    SnacksPickerFile = { fg = c.cream },
    SnacksPickerPathHidden = { fg = c.taupe },
    SnacksPickerPathIgnored = { fg = c.guide },
    SnacksPickerTotals = { fg = c.taupe },
    SnacksPickerToggle = { fg = c.bg, bg = c.smoke_light },
    SnacksPickerGitStatusAdded = { fg = c.git_add },
    SnacksPickerGitStatusModified = { fg = c.git_change },
    SnacksPickerGitStatusDeleted = { fg = c.git_delete },
    SnacksPickerGitStatusUntracked = { fg = c.taupe },
    SnacksPickerGitStatusStaged = { fg = c.foliage_bright },
    SnacksScratchKey = { fg = c.bg, bg = c.sun },
    SnacksScratchDesc = { fg = c.cream_dim },
    SnacksZenIcon = { fg = c.sun },
  })

  -- trouble.nvim
  add({
    TroubleNormal = { fg = c.cream, bg = c.bg_sidebar },
    TroubleNormalNC = { fg = c.cream, bg = c.bg_sidebar },
    TroubleText = { fg = c.cream },
    TroubleCount = { fg = c.stack, bg = c.surface },
    TroublePos = { fg = c.gutter },
    TroubleFilename = { fg = c.smoke },
    TroubleDirectory = { fg = c.taupe },
    TroubleSource = { fg = c.taupe },
    TroubleCode = { fg = c.taupe },
    TroubleIndent = { fg = c.guide },
    TroubleIndentFoldClosed = { fg = c.strap },
  })

  -- mini.nvim
  add({
    MiniIconsAzure = { fg = c.smoke },
    MiniIconsBlue = { fg = c.smoke },
    MiniIconsCyan = { fg = c.smoke_light },
    MiniIconsGreen = { fg = c.foliage },
    MiniIconsGrey = { fg = c.cream_dim },
    MiniIconsOrange = { fg = c.sun },
    MiniIconsPurple = { fg = c.stack_bright },
    MiniIconsRed = { fg = c.sign },
    MiniIconsYellow = { fg = c.sammie },
    MiniIndentscopeSymbol = { fg = c.strap, nocombine = true },
    MiniIndentscopePrefix = { nocombine = true },
    MiniHipatternsFixme = { fg = c.bg, bg = c.error, bold = true },
    MiniHipatternsHack = { fg = c.bg, bg = c.warning, bold = true },
    MiniHipatternsTodo = { fg = c.bg, bg = c.smoke_light, bold = true },
    MiniHipatternsNote = { fg = c.bg, bg = c.smoke, bold = true },
    MiniSurround = { fg = c.bg, bg = c.sun },
    MiniCursorword = { bg = c.reference },
    MiniCursorwordCurrent = { bg = c.reference },
    MiniTrailspace = { bg = c.sign },
    MiniJump = { fg = c.bg, bg = c.sun },
    MiniStatuslineModeNormal = { fg = c.bg, bg = c.sun, bold = true },
    MiniStatuslineModeInsert = { fg = c.bg, bg = c.smoke, bold = true },
    MiniStatuslineModeVisual = { fg = c.bg, bg = c.stack, bold = true },
    MiniStatuslineModeReplace = { fg = c.bg, bg = c.sign, bold = true },
    MiniStatuslineModeCommand = { fg = c.bg, bg = c.sammie, bold = true },
    MiniStatuslineModeOther = { fg = c.bg, bg = c.smoke_light, bold = true },
    MiniStatuslineDevinfo = { fg = c.cream, bg = c.surface },
    MiniStatuslineFilename = { fg = c.cream_dim, bg = c.bg_statusline },
    MiniStatuslineFileinfo = { fg = c.cream, bg = c.surface },
    MiniStatuslineInactive = { fg = c.taupe, bg = c.bg_statusline },
  })

  -- treesitter-context: the pinned lines sit on a slightly raised surface, underlined at the bottom.
  add({
    TreesitterContext = { bg = c.bg_dark },
    TreesitterContextLineNumber = { fg = c.gutter, bg = c.bg_dark },
    TreesitterContextBottom = { underline = true, sp = c.strap },
    TreesitterContextLineNumberBottom = { underline = true, sp = c.strap },
  })

  -- render-markdown
  local heads = { c.sun, c.gold, c.stack, c.smoke, c.foliage, c.cream_dim }
  for i, fg in ipairs(heads) do
    hl["RenderMarkdownH" .. i] = { fg = fg, bold = true }
    hl["RenderMarkdownH" .. i .. "Bg"] = { bg = require("sinners.util").blend(fg, c.bg, 0.12) }
  end
  add({
    RenderMarkdownCode = { bg = c.bg_dark },
    RenderMarkdownCodeInline = { fg = c.sammie, bg = c.bg_dark },
    RenderMarkdownBullet = { fg = c.sun },
    RenderMarkdownQuote = { fg = c.strap },
    RenderMarkdownDash = { fg = c.strap },
    RenderMarkdownLink = { fg = c.smoke },
    RenderMarkdownChecked = { fg = c.foliage },
    RenderMarkdownUnchecked = { fg = c.taupe },
    RenderMarkdownTableHead = { fg = c.strap },
    RenderMarkdownTableRow = { fg = c.strap },
    RenderMarkdownSuccess = { fg = c.ok }, RenderMarkdownInfo = { fg = c.info },
    RenderMarkdownHint = { fg = c.hint }, RenderMarkdownWarn = { fg = c.warning }, RenderMarkdownError = { fg = c.error },
  })

  -- grug-far (search and replace)
  add({
    GrugFarResultsMatch = { fg = c.bg, bg = c.gold },
    GrugFarResultsMatchAdded = { fg = c.git_add, bg = c.diff_add },
    GrugFarResultsMatchRemoved = { fg = c.git_delete, bg = c.diff_delete, strikethrough = true },
    GrugFarResultsPath = { fg = c.smoke },
    GrugFarResultsLineNr = { fg = c.gutter },
    GrugFarInputLabel = { fg = c.sun },
    GrugFarInputPlaceholder = { fg = c.taupe, italic = true },
    GrugFarHelpHeader = { fg = c.taupe },
  })

  -- nvim-dap, dap-ui, dap-virtual-text
  add({
    DapBreakpoint = { fg = c.sign },
    DapBreakpointCondition = { fg = c.gold },
    DapBreakpointRejected = { fg = c.taupe },
    DapLogPoint = { fg = c.smoke },
    DapStopped = { fg = c.foliage },
    DapStoppedLine = { bg = c.diff_add },
    NvimDapVirtualText = { fg = c.chrome, bg = c.inlay_bg, italic = true },
    NvimDapVirtualTextChanged = { fg = c.sun, bg = c.inlay_bg, italic = true },
    DapUIScope = { fg = c.sun, bold = true },
    DapUIType = { fg = c.type },
    DapUIValue = { fg = c.cream },
    DapUIVariable = { fg = c.cream },
    DapUIModifiedValue = { fg = c.sun, bold = true },
    DapUIDecoration = { fg = c.strap },
    DapUIThread = { fg = c.foliage },
    DapUIStoppedThread = { fg = c.smoke },
    DapUISource = { fg = c.smoke },
    DapUILineNumber = { fg = c.gutter },
    DapUIFloatBorder = { link = "FloatBorder" },
    DapUIWatchesEmpty = { fg = c.error },
    DapUIWatchesValue = { fg = c.foliage },
    DapUIWatchesError = { fg = c.error },
    DapUIBreakpointsPath = { fg = c.smoke },
    DapUIBreakpointsInfo = { fg = c.foliage },
    DapUIBreakpointsCurrentLine = { fg = c.foliage, bold = true },
    DapUIStepOver = { fg = c.smoke }, DapUIStepInto = { fg = c.smoke }, DapUIStepBack = { fg = c.smoke },
    DapUIStepOut = { fg = c.smoke }, DapUIStop = { fg = c.sign }, DapUIPlayPause = { fg = c.foliage },
    DapUIRestart = { fg = c.foliage }, DapUIUnavailable = { fg = c.taupe },
  })

  -- neotest
  add({
    NeotestPassed = { fg = c.foliage },
    NeotestFailed = { fg = c.sign },
    NeotestRunning = { fg = c.gold },
    NeotestSkipped = { fg = c.taupe },
    NeotestUnknown = { fg = c.taupe },
    NeotestWatching = { fg = c.smoke_light },
    NeotestNamespace = { fg = c.type },
    NeotestFile = { fg = c.smoke },
    NeotestDir = { fg = c.smoke },
    NeotestFocused = { bold = true, underline = true },
    NeotestAdapterName = { fg = c.stack, bold = true },
    NeotestIndent = { fg = c.guide },
    NeotestExpandMarker = { fg = c.guide },
    NeotestWinSelect = { fg = c.sun, bold = true },
    NeotestTest = { fg = c.cream },
    NeotestMarked = { fg = c.sun, bold = true },
    NeotestTarget = { fg = c.stack },
  })

  -- todo-comments: same colors as the @comment.* captures.
  add({
    TodoBgFIX = { fg = c.bg, bg = c.error, bold = true }, TodoFgFIX = { fg = c.error }, TodoSignFIX = { fg = c.error },
    TodoBgWARN = { fg = c.bg, bg = c.warning, bold = true }, TodoFgWARN = { fg = c.warning }, TodoSignWARN = { fg = c.warning },
    TodoBgHACK = { fg = c.bg, bg = c.sun, bold = true }, TodoFgHACK = { fg = c.sun }, TodoSignHACK = { fg = c.sun },
    TodoBgTODO = { fg = c.bg, bg = c.smoke_light, bold = true }, TodoFgTODO = { fg = c.smoke_light }, TodoSignTODO = { fg = c.smoke_light },
    TodoBgNOTE = { fg = c.bg, bg = c.smoke, bold = true }, TodoFgNOTE = { fg = c.smoke }, TodoSignNOTE = { fg = c.smoke },
    TodoBgPERF = { fg = c.bg, bg = c.stack, bold = true }, TodoFgPERF = { fg = c.stack }, TodoSignPERF = { fg = c.stack },
    TodoBgTEST = { fg = c.bg, bg = c.foliage, bold = true }, TodoFgTEST = { fg = c.foliage }, TodoSignTEST = { fg = c.foliage },
  })

  -- vim-illuminate
  add({
    IlluminatedWordText = { bg = c.reference },
    IlluminatedWordRead = { bg = c.reference },
    IlluminatedWordWrite = { bg = c.reference, underline = true, sp = c.cream_dim },
  })

  -- lazy.nvim and mason
  add({
    LazyNormal = { link = "NormalFloat" },
    LazyH1 = { fg = c.bg, bg = c.sun, bold = true },
    LazyH2 = { fg = c.sun, bold = true },
    LazyButton = { fg = c.cream, bg = c.surface },
    LazyButtonActive = { fg = c.bg, bg = c.sun, bold = true },
    LazyProgressDone = { fg = c.sun },
    LazyProgressTodo = { fg = c.guide },
    LazySpecial = { fg = c.smoke },
    LazyReasonPlugin = { fg = c.stack },
    LazyReasonEvent = { fg = c.gold },
    LazyReasonKeys = { fg = c.smoke_light },
    LazyReasonCmd = { fg = c.sammie },
    LazyReasonFt = { fg = c.foliage },
    LazyReasonStart = { fg = c.cream },
    LazyReasonSource = { fg = c.smoke },
    LazyReasonRuntime = { fg = c.taupe },
    LazyReasonImport = { fg = c.cream_dim },
    LazyCommit = { fg = c.taupe },
    LazyCommitType = { fg = c.stack },
    LazyDimmed = { fg = c.taupe },
    LazyProp = { fg = c.taupe },
    LazyUrl = { fg = c.smoke, underline = true },
    MasonNormal = { link = "NormalFloat" },
    MasonHeader = { fg = c.bg, bg = c.sun, bold = true },
    MasonHeaderSecondary = { fg = c.bg, bg = c.smoke, bold = true },
    MasonHighlight = { fg = c.smoke },
    MasonHighlightBlock = { fg = c.bg, bg = c.smoke },
    MasonHighlightBlockBold = { fg = c.bg, bg = c.sun, bold = true },
    MasonHighlightSecondary = { fg = c.sun },
    MasonMuted = { fg = c.taupe },
    MasonMutedBlock = { fg = c.cream, bg = c.surface },
    MasonMutedBlockBold = { fg = c.cream_bright, bg = c.surface, bold = true },
  })

  -- telescope
  add({
    TelescopeNormal = { link = "NormalFloat" },
    TelescopeBorder = { fg = c.border, bg = c.bg_float },
    TelescopeTitle = { fg = c.sun, bold = true },
    TelescopePromptBorder = { fg = c.sun, bg = c.bg_float },
    TelescopePromptTitle = { fg = c.bg, bg = c.sun, bold = true },
    TelescopePromptPrefix = { fg = c.sun },
    TelescopeSelection = { bg = c.surface, bold = true },
    TelescopeSelectionCaret = { fg = c.sun, bg = c.surface },
    TelescopeMultiSelection = { fg = c.stack },
    TelescopeMatching = { fg = c.sun, bold = true },
    TelescopeResultsComment = { fg = c.taupe },
  })

  -- fzf-lua
  add({
    FzfLuaNormal = { link = "NormalFloat" },
    FzfLuaBorder = { fg = c.border, bg = c.bg_float },
    FzfLuaTitle = { fg = c.sun, bold = true },
    FzfLuaCursorLine = { bg = c.surface },
    FzfLuaSearch = { fg = c.sun, bold = true },
    FzfLuaHeaderBind = { fg = c.stack },
    FzfLuaHeaderText = { fg = c.cream_dim },
    FzfLuaPathColNr = { fg = c.gutter },
    FzfLuaPathLineNr = { fg = c.gutter },
    FzfLuaBufName = { fg = c.smoke },
    FzfLuaTabTitle = { fg = c.sun },
  })

  -- neo-tree
  add({
    NeoTreeNormal = { fg = c.cream, bg = c.bg_sidebar },
    NeoTreeNormalNC = { fg = c.cream, bg = c.bg_sidebar },
    NeoTreeDirectoryIcon = { fg = c.smoke },
    NeoTreeDirectoryName = { fg = c.cream },
    NeoTreeRootName = { fg = c.sun, bold = true },
    NeoTreeFileName = { fg = c.cream },
    NeoTreeFileNameOpened = { fg = c.cream_bright, bold = true },
    NeoTreeIndentMarker = { fg = c.guide },
    NeoTreeExpander = { fg = c.strap },
    NeoTreeDimText = { fg = c.taupe },
    NeoTreeDotfile = { fg = c.taupe },
    NeoTreeGitAdded = { fg = c.git_add },
    NeoTreeGitModified = { fg = c.git_change },
    NeoTreeGitDeleted = { fg = c.git_delete },
    NeoTreeGitUntracked = { fg = c.taupe, italic = true },
    NeoTreeGitConflict = { fg = c.sign, bold = true },
    NeoTreeGitStaged = { fg = c.foliage_bright },
    NeoTreeWinSeparator = { fg = c.bg_dark, bg = c.bg_sidebar },
    NeoTreeTabActive = { fg = c.cream_bright, bg = c.bg, bold = true },
    NeoTreeTabInactive = { fg = c.taupe, bg = c.bg_dark },
  })

  -- harpoon
  add({
    HarpoonWindow = { link = "NormalFloat" },
    HarpoonBorder = { link = "FloatBorder" },
  })

  return hl
end
