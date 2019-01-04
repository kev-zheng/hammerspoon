-- Globals
hyper = {"ctrl", "alt", "cmd"}
hypershift = {"ctrl", "alt", "cmd", "shift"}
hypertab = {"ctrl", "alt", "cmd", "tab"}

-- Home directory where lua code is stored
cwd = os.getenv("HOME") .. "/.hammerspoon/"
python_binary = "/Users/kevzheng/miniconda3/envs/gcal/bin/python3"


inspect = require('inspect') -- Use for looking up tables
require('position')
require('focus')
require('gcal')
require('monitor')
require('notify')
require('spaces')
require('timer')

-- Developer tools

--require('watcher') -- Use when developing
--To get names of applications
function getApps()
	hs.fnutils.each(hs.application.runningApplications(), function(app) print(app:title()) end)
end
