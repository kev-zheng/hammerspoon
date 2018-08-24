hs.hotkey.bind(hyper, "C", function ()
  hs.application.launchOrFocus('Google Chrome')
end)

hs.hotkey.bind(hyper, 'E', function ()
  hs.application.launchOrFocus('Visual Studio Code')
end)

hs.hotkey.bind(hyper, 'F', function ()
  hs.application.launchOrFocus('Finder')
end)

-- Activates Matlab only if running
hs.hotkey.bind(hyper, 'M', function ()
  local matlab = hs.application.get('Matlab_R2017a')
  matlab:activate()
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

hs.hotkey.bind(hyper, "space", function ()
  hs.application.launchOrFocus('Terminal')
end)

hs.hotkey.bind(hyper, 'H', function()
  hs.application.launchOrFocus('Hammerspoon')
end)

hs.hotkey.bind(hyper, "tab", function ()
  hs.eventtap.keyStroke(nil, 'f3')  
end)

-- hs.hotkey.bind(hyper, 'H', function() hs.window.focusedWindow():focusWindowWest() end)
-- hs.hotkey.bind(hyper, 'L', function() hs.window.focusedWindow():focusWindowEast() end)
-- hs.hotkey.bind(hyper, 'K', function() hs.window.focusedWindow():focusWindowNorth() end)
-- hs.hotkey.bind(hyper, 'J', function() hs.window.focusedWindow():focusWindowSouth() end)
