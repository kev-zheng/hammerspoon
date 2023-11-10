-- Globals
-- Set these values in karabiner
hyper = {"ctrl", "cmd"}
hypershift = {"ctrl", "cmd", "shift"}
hypertab = {"ctrl", "cmd", "tab"}

-- Home directory where lua code is stored
cwd = os.getenv("HOME") .. "/.hammerspoon/"

-- Path of your python3 executable
PYTHON_BINARY = "/usr/bin/python3"

-- Toggle modules here
inspect = require('inspect')
require('position')
require('focus')
require('gcal')
-- require('monitor')
-- require('notify')
-- require('timer')
-- require('spaces')
-- require('airpods')

--require('watcher') -- Use when developing
--To get names of applications
function getApps()
	hs.fnutils.each(hs.application.runningApplications(), function(app) print(app:title()) end)
end
