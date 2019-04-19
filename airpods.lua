
local BLUETOOTH_DEVICE_STRING = "com.apple.bluetooth.deviceUpdated"

local menu = hs.menubar.new()

local function getBatteryLife(name, object, userInfo)
    if userInfo ~= nil then
        -- print(string.format("name: %s\nobject: %s\nuserInfo: %s\n", name, object, hs.inspect(userInfo)))
        battery_percent_left = userInfo['BatteryPercentLeft']
        battery_percent_right = userInfo['BatteryPercentRight']
        
        if battery_percent_left ~= nil and battery_percent_right ~= nil then
            menu:setTitle(battery_percent_left.."% 🎧 "..battery_percent_right.."%")
        end
    end
end

local listener = hs.distributednotifications.new(
    getBatteryLife,
    BLUETOOTH_DEVICE_STRING,
    nil
)

listener:start()