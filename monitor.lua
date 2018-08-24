function moveToScreen(nextScreen)
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

function moveWindowLeft()
moveWindow(hs.screen.mainScreen():next())
end

function moveWindowRight()
moveWindow(hs.screen.mainScreen():previous())
end

hs.hotkey.bind(hypershift, "right", function () 
	moveToScreen(hs.screen.mainScreen():next())
end)

hs.hotkey.bind(hypershift, "left", function () 
	moveToScreen(hs.screen.mainScreen():previous())
end)
  
