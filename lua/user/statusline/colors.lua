-- Ui highlight color groups
--
-- This file contains the highlight group definitions for both:
--   - feline (statusline)
--   - tabby (tabline)
--
-- The colors are pulled from the current applied colorscheme.  This requires
-- that your colorscheme defines the highlight groups queried as well as
-- neovim's vim.g.terminal_color_* (s).
--
-- There is an autocmd that regenerates the highlight group colors on
-- colorscheme change.

local M = {}

local function highlight(group, color)
  local style = color.style and "gui=" .. color.style or "gui=NONE"
  local fg = color.fg and "guifg=" .. color.fg or "guifg=NONE"
  local bg = color.bg and "guibg=" .. color.bg or "guibg=NONE"
  local sp = color.sp and "guisp=" .. color.sp or ""
  local hl = "highlight " .. group .. " " .. style .. " " .. fg .. " " .. bg .. " " .. sp
  vim.cmd(hl)

  if color.link then
    vim.cmd("highlight! link " .. group .. " " .. color.link)
  end
end

local function fromhl(hl)
  local result = {}
  local list = vim.api.nvim_get_hl_by_name(hl, true)
  for k, v in pairs(list) do
    local name = k == "background" and "bg" or "fg"
    result[name] = string.format("#%06x", v)
  end
  return result
end

local function term(num, default)
  local key = "terminal_color_" .. num
  return vim.g[key] and vim.g[key] or default
end

local function colors_from_theme()
  return {
    bg = fromhl("StatusLine").bg, -- or "#2E3440",
    alt = fromhl("CursorLine").bg, -- or "#475062",
    fg = fromhl("StatusLine").fg, -- or "#8FBCBB",
    hint = fromhl("DiagnosticHint").bg or "#5E81AC",
    info = fromhl("DiagnosticInfo").bg or "#81A1C1",
    warn = fromhl("DiagnosticWarn").bg or "#EBCB8B",
    err = fromhl("DiagnosticError").bg or "#EC5F67",
    black = term(0, "#434C5E"),
    red = term(1, "#EC5F67"),
    green = term(2, "#8FBCBB"),
    yellow = term(3, "#EBCB8B"),
    blue = term(4, "#5E81AC"),
    magenta = term(5, "#B48EAD"),
    cyan = term(6, "#88C0D0"),
    white = term(7, "#ECEFF4"),
  }
end

local function tabline_colors_from_theme()
  return {
    tabl = fromhl("TabLine"),
    norm = fromhl("Normal"),
    sel = fromhl("TabLineSel"),
    fill = fromhl("TabLineFill"),
  }
end

M.gen_highlights = function()
  local c = colors_from_theme()
  local sfg = vim.o.background == "dark" and c.black or c.white
  local sbg = vim.o.background == "dark" and c.white or c.black
  local ct = tabline_colors_from_theme()
  M.colors = c
  local groups = {
    FlnViBlack = { fg = c.white, bg = c.black, style = "bold" },
    FlnViRed = { fg = c.bg, bg = c.red, style = "bold" },
    FlnViGreen = { fg = c.bg, bg = c.green, style = "bold" },
    FlnViYellow = { fg = c.bg, bg = c.yellow, style = "bold" },
    FlnViBlue = { fg = c.bg, bg = c.blue, style = "bold" },
    FlnViMagenta = { fg = c.bg, bg = c.magenta, style = "bold" },
    FlnViCyan = { fg = c.bg, bg = c.cyan, style = "bold" },
    FlnViWhite = { fg = c.bg, bg = c.white, style = "bold" },

    FlnBlack = { fg = c.black, bg = c.white, style = "bold" },
    FlnRed = { fg = c.red, bg = c.bg, style = "bold" },
    FlnGreen = { fg = c.green, bg = c.bg, style = "bold" },
    FlnYellow = { fg = c.yellow, bg = c.bg, style = "bold" },
    FlnBlue = { fg = c.blue, bg = c.bg, style = "bold" },
    FlnMagenta = { fg = c.magenta, bg = c.bg, style = "bold" },
    FlnCyan = { fg = c.cyan, bg = c.bg, style = "bold" },
    FlnWhite = { fg = c.white, bg = c.bg, style = "bold" },

    -- Diagnostics
    FlnHint = { fg = c.black, bg = c.hint, style = "bold" },
    FlnInfo = { fg = c.black, bg = c.info, style = "bold" },
    FlnWarn = { fg = c.black, bg = c.warn, style = "bold" },
    FlnError = { fg = c.black, bg = c.err, style = "bold" },
    FlnStatus = { fg = sfg, bg = sbg, style = "bold" },

    -- Dianostic Seperators
    FlnBgHint = { fg = ct.sel.bg, bg = c.hint },
    FlnHintInfo = { fg = c.hint, bg = c.info },
    FlnInfoWarn = { fg = c.info, bg = c.warn },
    FlnWarnError = { fg = c.warn, bg = c.err },
    FlnErrorStatus = { fg = c.err, bg = sbg },
    FlnStatusBg = { fg = sbg, bg = c.bg },

    FlnAlt = { fg = sbg, bg = ct.sel.bg },
    FlnFileInfo = { fg = c.fg, bg = c.alt },
    FlnAltSep = { fg = c.bg, bg = ct.sel.bg },
    FlnGitBranch = { fg = c.yellow, bg = c.bg },
    FlnGitSeperator = { fg = c.bg, bg = c.alt },

    -- Tabby
    TbyHead = { fg = ct.fill.bg, bg = c.cyan },
    TbyHeadSep = { fg = c.cyan, bg = ct.fill.bg },
    TbyActive = { fg = ct.sel.fg, bg = ct.sel.bg, style = "bold" },
    TbyActiveSep = { fg = ct.sel.bg, bg = ct.fill.bg },
    TbyBoldLine = { fg = ct.tabl.fg, bg = ct.tabl.bg, style = "bold" },
    TbyLineSep = { fg = ct.tabl.bg, bg = ct.fill.bg },

    -- Splash/Dashboard
    Dove0 = { fg = "#719CD6" },
    Dove1 = { fg = "#729AD6" },
    Dove2 = { fg = "#7499D6" },
    Dove3 = { fg = "#7697D6" },
    Dove4 = { fg = "#7697D6" },
    Dove5 = { fg = "#7995D6" },
    Dove6 = { fg = "#7B93D6" },
    Dove7 = { fg = "#7C92D6" },
    Dove8 = { fg = "#7C92D6" },
    Dove9 = { fg = "#808FD6" },
    Dove10 = { fg = "#818ED6" },
    Dove11 = { fg = "#838DD6" },
    Dove12 = { fg = "#858BD6" },
    Dove13 = { fg = "#878AD6" },
    Dove14 = { fg = "#8889D6" },
    Dove15 = { fg = "#8A87D6" },
    Dove16 = { fg = "#8C86D6" },
    Dove17 = { fg = "#8D85D6" },
    Dove18 = { fg = "#8F83D6" },
    Dove19 = { fg = "#9182D6" },
    Dove20 = { fg = "#9281D6" },
    Dove21 = { fg = "#947FD6" },
    Dove22 = { fg = "#967ED6" },
    Dove23 = { fg = "#977DD6" },
    Dove24 = { fg = "#997BD6" },
    Dove25 = { fg = "#9B7AD6" },
    Dove26 = { fg = "#9D79D6" },
    Dove27 = { fg = "#9E77D6" },
  }
  for k, v in pairs(groups) do
    highlight(k, v)
  end
end

M.gen_highlights()

