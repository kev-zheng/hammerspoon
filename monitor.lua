local function moveToScreen(nextScreen)
	local currentScreen = hs.screen.mainScreen()
	local currentFrame = currentScreen:frame()

	local nextFrame = nextScreen:frame()
	local win = hs.window.focusedWindow()
	local f = win:frame()

	local xscale = nextFrame.w / currentFrame.w
	local yscale = nextFrame.h / currentFrame.h

	f.x = nextScreen:frame().x + (win:frame().x - currentScreen:frame().x) * xscale
	f.y = nextScreen:frame().y + (win:frame().y - currentScreen:frame().y) * yscale

	f.w = f.w * xscale
	f.h = f.h * yscale

	win:setFrame(f)

	-- Click on window to focus monitor (a bit hacky)
	local clickPoint = win:zoomButtonRect()
	
	clickPoint.x = clickPoint.x + clickPoint.w + 3
	clickPoint.y = clickPoint.y + (clickPoint.h / 2)

	-- local mouseClickEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, clickPoint)
	hs.eventtap.leftClick(clickPoint)
	
  end

hs.hotkey.bind(hypershift, "right", function () 
	moveToScreen(hs.screen.mainScreen():next())
end)

hs.hotkey.bind(hypershift, "left", function () 
	moveToScreen(hs.screen.mainScreen():previous())
end)

-- Using coredock for re-orientation
coredock = require("hs._asm.undocumented.coredock")

local DOCK_ORIENTATION_LEFT = 3
local DOCK_ORIENTATION_BOTTOM = 2

local function toggleDock()
	local num_screens = #hs.screen.allScreens()
	if num_screens == 1 then
		coredock.orientation(DOCK_ORIENTATION_LEFT)
	else
		coredock.orientation(DOCK_ORIENTATION_BOTTOM)
	end
end

toggleDock()
screen_watcher = hs.screen.watcher.new(toggleDock)
screen_watcher:start()