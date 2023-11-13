--[[

focus.lua

Set application bindings here!

]]--

hs.hotkey.bind(hyper, "C", function ()
  hs.application.launchOrFocus('Google Chrome Beta')
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
  hs.application.launchOrFocus('Spotify')
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

hs.hotkey.bind(hyper,  "space", function()
  hs.application.launchOrFocus('iTerm')
end)


-- Workaround for Alacritty app
-- 
-- Searches current space for the app, then saves the window
-- if a window wasn't found, use the saved window, or default
-- to launchOrFocus()
--
--local spaces = require "hs._asm.undocumented.spaces"
--local unit_window = hs.geometry.size(0.0, 0.0)
--cached_win = nil
--
--hs.hotkey.bind(hyper, "space", function ()
-- 
--  -- Focus cached window
--  if cached_win ~= nil and cached_win:size() ~= unit_window then
--    print("focusing cached window")
--    cached_win:focus()
--    return
--  end
--
--  windows = spaces.allWindowsForSpace(spaces.activeSpace())
--
--  alacritty_win = nil
--  for k,v in pairs(windows) do
--    if v:application():name() == 'Alacritty' then
--      alacritty_win = v
--    end
--  end
--
--  -- Focus the searched window
--  if alacritty_win ~= nil then
--    print("focusing searched window")
--    cached_win = alacritty_win:focus()
--    return
--  end
--
--  -- Attempts failed, launch the app
--  print("launchOrFocus app")
--  hs.application.launchOrFocus('/Applications/Alacritty.app')
--end)
