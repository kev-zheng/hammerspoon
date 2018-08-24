--[[

timer.lua

A simple timer that is displayed on the status bar,
triggered with a url event.

]]--

require("notify")

notif_title = "Tomato Timer"
shui_icon = hs.image.imageFromPath('~/.hammerspoon/assets/shui.png')
time = 0

clock_idx = 1

clocks = {"🕛","🕐","🕑","🕒","🕓","🕔","🕕","🕖","🕗","🕘","🕙","🕚"}

local function updateTimer()
	local min = time // 60
	local sec = time % 60
	local disp = string.format ("%s %02d:%02d ", clocks[clock_idx], min, sec)

	time = time - 1
	clock_idx = clock_idx % #clocks + 1

	menu:setTitle(disp)
	print(disp)
	
	if time == 0 then
		cancel()
		notify(notif_title, "Time's up!", shui_icon, true)
	end
end

function resume()
	watch:start()
	menu:setMenu({{title="Pause", fn=pause}, {title="Cancel", fn=cancel}})
end

function pause()
	watch:stop()
	menu:setMenu({{title="Resume", fn=resume}, {title="Cancel", fn=cancel}})
end

function cancel()
	watch:stop()
	time = nil
	startTimer()
end

function begin()
	notify(notif_title, "Starting timer!", shui_icon)

	time = 25 * 60

	menu:setMenu({{title="Pause", fn=pause}, {title="Cancel", fn=cancel}})

	if watch == nil then
		watch = hs.timer.new(1, updateTimer)
	end

	watch:start()
end

function startTimer()
	if menu == nil then
		menu = hs.menubar.new()
	end

	clocks = {"🕛","🕐","🕑","🕒","🕓","🕔","🕕","🕖","🕗","🕘","🕙","🕚"}

	if hs.timer.localTime() > (0) then
		clocks = {"🌒","🌓","🌔","🌝","🌖","🌗","🌘","🌚"}
	end

	menu:setTitle("🕛")
	menu:setMenu({{title="Start", fn=begin}})
end

startTimer()