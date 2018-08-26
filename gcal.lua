local Json = require("json")
require("table")
require("notify")

-- Function to load a json file into table
function loadTable(filename)
    local contents = ""
    local myTable = {}
    local file = io.open( cwd..filename, "r" )

    if file then
        -- read all contents of file into a string
        local contents = file:read( "*a" )
        myTable = Json.decode(contents);
        io.close( file )
        return myTable
    end
    return nil
end

function clickMenu()
    -- noop for now
end

function makeDot(hex_color)
    return hs.styledtext.new("•", {color = { hex = hex_color}})..hs.styledtext.new(" ", {color = { hex = "#1d1d1d"}})
end

-- Initial dropdown before events
-- Useful for setting bookmarks
local bookmarks = {}
bookmarks[1] = {title = "• Open Google Calendar ... ", fn=function() hs.urlevent.openURL("https://calendar.google.com") end}
bookmarks[2] = {title = "• Open Kanban Board ... ", fn=function() hs.urlevent.openURL("https://correlation-one.kanbantool.com/b/407711-technical-product") end}
bookmarks[3] = {title = "-"}

local menu = hs.menubar.new()

-- Refreshes events and sets menu to first event
function refreshMenu()
    notify("Google Calendar", "Refreshing events ... ", nil, nil)
    
    -- Execute python script to fetch calendar events
    os.execute(python_binary.." "..cwd.."gcal/gcal.py -e")

    print(python_binary.." "..cwd.."gcal/gcal.py -e", nil, nil, nil)

    events = loadTable("gcal/events.json")['events']

    -- Deep copy of bookmarks to build dropdown from
    local dropdown = {table.unpack(bookmarks)}

    -- Set up dropdown
    if menu then
        for k, v in pairs(events) do
            dropdown[#dropdown + 1] = {title = makeDot(v['color'])..v['time'].." - "..v['title'], fn=clickMenu}
        end

        menu:setMenu(dropdown)

        if #events > 0 then
            menu:setTitle(events[1]['time'].." - "..events[1]['title'])
        else
            menu:setTitle("No events found!")
        end
    end 
end

-- First call initializes menu
refreshMenu()

-- Refreshes menu every 30 minutes
timer = hs.timer.doEvery(3600, refreshMenu)

-- Binds hotkey to refresh menu
hs.hotkey.bind(hyper, "-", refreshMenu)