 local M = {}

function M.setup()
  require('base16-colorscheme').setup({
    base00 = '#14121b',
    base01 = '#211e28',
    base02 = '#2b2933',
    base03 = '#938ea1',
    base04 = '#cac3d8',
    base05 = '#e6e0ee',
    base06 = '#e6e0ee',
    base07 = '#e6e0ee',
    base08 = '#ffb4ab',
    base09 = '#ffabf0',
    base0A = '#ccbeff',
    base0B = '#ccbeff',
    base0C = '#ffabf0',
    base0D = '#ccbeff',
    base0E = '#ccbeff',
    base0F = '#93000a',
  })

  local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  hi('TelescopeNormal',         { fg = '#e6e0ee',          bg = '#14121b' })
  hi('TelescopeBorder',         { fg = '#938ea1',             bg = '#14121b' })
  hi('TelescopePromptNormal',   { fg = '#e6e0ee',          bg = '#14121b' })
  hi('TelescopePromptBorder',   { fg = '#938ea1',             bg = '#14121b' })
  hi('TelescopePromptPrefix',   { fg = '#ccbeff',             bg = '#14121b' })
  hi('TelescopePromptCounter',  { fg = '#cac3d8',  bg = '#14121b' })
  hi('TelescopePromptTitle',    { fg = '#14121b',             bg = '#ccbeff' })
  hi('TelescopePreviewTitle',   { fg = '#14121b',             bg = '#ccbeff' })
  hi('TelescopeResultsTitle',   { fg = '#14121b',             bg = '#ffabf0' })
  hi('TelescopeSelection',      { fg = '#e6e0ee',          bg = '#2b2933' })
  hi('TelescopeSelectionCaret', { fg = '#ccbeff',             bg = '#2b2933' })
  hi('TelescopeMatching',       { fg = '#ccbeff',             bold = true })
end

 -- Register a signal handler for SIGUSR1 (matugen updates)
 local signal = vim.uv.new_signal()
 signal:start(
   'sigusr1',
   vim.schedule_wrap(function()
     package.loaded['matugen'] = nil
     require('matugen').setup()
   end)
 )

 return M
