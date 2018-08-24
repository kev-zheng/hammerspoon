local Json = require("json")
require("table")
require("notify")

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

function clickMenu(keys, event)
    print(inspect(event))
    print("clicked this! "..event['title'].." "..event['time'])
end

local num_events = 0
local current_idx = 1

local menu = hs.menubar.new()
local data = loadTable("events.json")
local dropdown = {}
for k,v in pairs(data['events']) do
    dropdown[k] = {title = v['time'].." - "..v['title'], fn=clickMenu}
end

menu:setMenu(dropdown)

num_events = #data['events']

-- Sets menubar to first element
if num_events ~= 0 then
    menu:setTitle(data['events'][1]['title'])
end

hs.hotkey.bind(hyper, "-", function ()
    notify("Google Calendar", "Refreshing events ... ", nil, nil)
    os.execute("/usr/local/bin/python3 /Users/kevzheng/dotfiles/hammerspoon/.hammerspoon/gcal.py -e")
    events = loadTable("events.json")
    num_events = #data['events']

    if menu then
        menu:setTitle(data['events'][current_idx]['time'].." - "..data['events'][current_idx]['title'])
    end
end)

hs.hotkey.bind(hyper, "[", function ()
    print(current_idx)
    if current_idx > 1 then
        current_idx = current_idx - 1
        menu:setTitle(data['events'][current_idx]['title'])
    end
end)

hs.hotkey.bind(hyper, "]", function ()
    print(current_idx)
    if current_idx < num_events then
        current_idx = current_idx + 1
        menu:setTitle(data['events'][current_idx]['title'])
    end
end)
