--[[

focus.lua

Set application bindings here!

]]--

hs.hotkey.bind(hyper, "C", function ()
  hs.application.launchOrFocus('Google Chrome')
end)

hs.hotkey.bind(hyper, 'E', function ()
  hs.application.launchOrFocus('Visual Studio Code')
end)

hs.hotkey.bind(hyper, 'F', function ()
  hs.application.launchOrFocus('Finder')
end)

hs.hotkey.bind(hyper, "I", function ()
  hs.application.launchOrFocus('Xcode')
end)

hs.hotkey.bind(hyper, 'N', function()
  hs.application.launchOrFocus('Notes')
end)

hs.hotkey.bind(hyper, 'P', function ()
  hs.application.launchOrFocus('Preview')
end)

hs.hotkey.bind(hyper, 'R', function ()
  hs.application.launchOrFocus('RStudio')
end)

hs.hotkey.bind(hyper, 'S', function ()
  hs.application.launchOrFocus('Slack')
end)

hs.hotkey.bind(hyper, 'T', function ()
  hs.application.launchOrFocus('TextEdit')
end)

hs.hotkey.bind(hyper, "W", function ()
  hs.application.launchOrFocus('Wechat')
end)

hs.hotkey.bind(hyper, 'H', function()
  hs.application.launchOrFocus('Hammerspoon')
end)


-- Workaround for Alacritty app
-- 
-- Searches current space for the app, then saves the window
-- if a window wasn't found, use the saved window, or default
-- to launchOrFocus()

local spaces = require "hs._asm.undocumented.spaces"
cached_win = nil

hs.hotkey.bind(hyper, "space", function ()
  windows = spaces.allWindowsForSpace(spaces.activeSpace())
  
  alacritty_win = nil
  for k,v in pairs(windows) do
    if v:application():name() == 'Alacritty' then
      alacritty_win = v
    end
  end

  if alacritty_win ~= nil then
    cached_win = alacritty_win:focus()
  elseif cached_win ~= nil then
    cached_win:focus()
  end

  if cached_win == nil then
    hs.application.launchOrFocus('/Applications/Alacritty.app')
  end
end)
