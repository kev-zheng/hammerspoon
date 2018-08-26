# Hammerspoon

My suite of hammerspoon extensions 😄 enjoy!

# Installation
Clone the repository

```
git clone https://github.com/kev-zheng/hammerspoon
```

Move the contents into your .hammerspoon folder

# init

File wrapping all of the lua files together. Each module is configured here. Global variables, such as set hyper-keys, are also set here.

I use [karabiner-elements](https://pqrs.org/osx/karabiner/) to convert my `caps lock` key into a hyperkey, which automatically presses `ctrl + alt + cmd` for me. 

The majority of my keybindings use the hyperkey in combination with other keys.

# gcal

menubar extension to interact with __Google Calendar__ events

## gcal.py

Script used to refresh google calendar events. Requires authentication via Google Calendar API.

Install these dependencies to be able to run the script:

```
pip install --upgrade google-api-python-client oauth2client python-dateutil
```

Follow instructions at [Google Calendar Python API Quickstart](https://developers.google.com/calendar/quickstart/python) to run quickstart.py to initialize your crendentials, or directly run gcal.py

You should have a credentials.json file in the working directory or in home .credentials directory

`calendar.json` contains the activated calendars where events are pulled from.

Run the following to set up your active calendars
```
python3 gcal.py -c
```

`events.json` contains the events displayed in your menubar.

The following command pulls latest events corresponding to your active calendars
```
python3 gcal.py -e
```

`colors.json` are helpful color mappings. `gcal.py` updates your default-colored events to a new color every week to keep them fresh!

## gcal.lua

Constructs the menubar. On each refresh, calls `gcal.py -e` and updates the menubar with events in `events.json`

# focus

File containing hotkey bindings. Each segment binds a hotkey to a useful application - such as `hyper + c` to launch `Google Chrome`

# monitor

Keybindings used to interact with an external monitor, or between spaces within a monitor. Very useful for moving applications back and forth.

`hyper + shift + right` cycles the current application to monitor on the right

`hyper + shift + keft` cycles the current application to monitor on the left

`hyper + shift + h` moves the current application to a space on the left

`hyper + shift + l` moves the current application to a space on the right

# position

Window positioning module [borrowed](https://gist.github.com/teknofire/a311390d0427c09e7be6044d09c8d372) from Miro Mannino.

`hyper + right` resizes window to right side of screen.

`hyper + left` resizes window to left side of screen.

`hyper + up` resizes window to upper side of screen.

`hyper + down` resizes window to bottom side of screen.

Repeated presses of above keys will cycle window to take up half, quarter, and 2/3 of screen.

`hyper + enter` resizes window to entire screen

Repeated presses of `hyper + enter` will cycle through resizing similarly.

# timer

Simple `pomodoro timer` activated through the menubar. Uses a 25-minute work duration.