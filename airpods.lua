--[[

airpods.lua

Keeps track of airpod battery in the menu bar

]]--

local BLUETOOTH_DEVICE_STRING = "com.apple.bluetooth"

local menu = hs.menubar.new()
menu:removeFromMenuBar()

local function isAirpods(device_table) 
    for k, v in pairs(device_table) do
        if string.find(v['NAME'], "AirPods") then
            return true
        end
    end

    return false
end

local function listenBluetoothMessage(name, object, userInfo)
    if userInfo == nil then
        do return end
    end

    -- For debugging
    -- print(string.format("name: %s\nobject: %s\nuserInfo: %s\n", name, object, hs.inspect(userInfo)))

    if name == BLUETOOTH_DEVICE_STRING..".status" then
        num_connected_devices = userInfo['CONNECTED_DEVICES_COUNT']
        if num_connected_devices == 0 then
            menu:removeFromMenuBar()
        elseif isAirpods(userInfo['CONNECTED_DEVICES']) and not menu:isInMenuBar() then
            menu:returnToMenuBar()
            menu:setTitle("🎧")
        end
    elseif name == BLUETOOTH_DEVICE_STRING..".deviceUpdated" then
        battery_percent_left = userInfo['BatteryPercentLeft']
        battery_percent_right = userInfo['BatteryPercentRight']
        
        if battery_percent_left ~= nil and battery_percent_right ~= nil then
            menu:setTitle(battery_percent_left.."% 🎧 "..battery_percent_right.."%")
        end
    end
end

local listener = hs.distributednotifications.new(
    listenBluetoothMessage,
    nil,
    nil
)

listener:start()