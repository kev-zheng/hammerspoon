--[[

timer.lua

A simple timer that is displayed on the status bar :)

]]--

require("notify")

local NOTIFICATION_TITLE = "Tomato Timer"
local NOTIFICATION_IMAGE = hs.image.imageFromPath('~/.hammerspoon/assets/shui.png')
local EVENING_IN_SEC = 64800

local menu = hs.menubar.new()
local clock_idx = 1
local time = 0

-- Function declarations
local updateTimer, resume, pause, cancel, begin, initTimer

updateTimer = function()
	local min = time // 60
	local sec = time % 60
	local disp = string.format ("%s %02d:%02d ", clocks[clock_idx], min, sec)

	time = time - 1
	clock_idx = clock_idx % #clocks + 1

	menu:setTitle(disp)
	print(disp)
	
	if time == 0 then
		cancel()
		notify(NOTIFICATION_TITLE, "Time's up!", NOTIFICATION_IMAGE, true)
	end
end

resume = function()
	watch:start()
	menu:setMenu({{title="Pause", fn=pause}, {title="Cancel", fn=cancel}})
end

pause = function()
	watch:stop()
	menu:setMenu({{title="Resume", fn=resume}, {title="Cancel", fn=cancel}})
end

cancel = function()
	watch:stop()
	time = nil
	initTimer()
end

begin = function()
	notify(NOTIFICATION_TITLE, "Starting timer!", NOTIFICATION_IMAGE)

	time = 25 * 60

	menu:setMenu({{title="Pause", fn=pause}, {title="Cancel", fn=cancel}})

	if watch == nil then
		watch = hs.timer.new(1, updateTimer)
	end

	watch:start()
end

initTimer = function()

	clocks = {"🕛","🕐","🕑","🕒","🕓","🕔","🕕","🕖","🕗","🕘","🕙","🕚"}

	if hs.timer.localTime() > EVENING_IN_SEC then
		clocks = {"🌒","🌓","🌔","🌝","🌖","🌗","🌘","🌚"}
	end

	menu:setTitle("🕛")
	menu:setMenu({{title="Start", fn=begin}})
end

initTimer()