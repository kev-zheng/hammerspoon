-- Remove window movement animation
hs.window.animationDuration = 0

-- Hack to move window between spaces
function moveWindowOneSpace(direction)
  local mouseOrigin = hs.mouse.getAbsolutePosition()
  local win = hs.window.frontmostWindow()
  local clickPoint = win:zoomButtonRect()

  clickPoint.x = clickPoint.x + clickPoint.w + 3
  clickPoint.y = clickPoint.y + (clickPoint.h / 2)

  local mouseClickEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, clickPoint)
  mouseClickEvent:post()
  hs.timer.usleep(300000)

  local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, direction, true)
  nextSpaceDownEvent:post()
  hs.timer.usleep(150000)

  local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, direction, false)
  nextSpaceUpEvent:post()
  hs.timer.usleep(150000)

  local mouseReleaseEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, clickPoint)
  mouseReleaseEvent:post()
  hs.timer.usleep(150000)

  hs.mouse.setAbsolutePosition(mouseOrigin)
end

-- Store the original position of moved windows
local origWindowPos = {}

-- cleanup original postition when window is restored or closed
local function cleanupWindowPos(_,_,_,id)
  origWindowPos[id] = nil
end

function getWindowState()
  local win = hs.window.frontmostWindow()
  local screen = win:screen():frame()
  local f = win:frame()

  state = "unknown"
  if     f.x == screen.x and 
         f.y == screen.y and 
         f.w == screen.w and 
         f.h == screen.h then
    state = "full"
  elseif f.x == screen.x and 
         f.y == screen.y and 
         f.w <= screen.w / 2 + 50 and f.w > screen.w / 2 - 50 and -- Some windows (terminal) don't resize exactly
         f.h <= screen.h + 50 and f.h > screen.h - 50 then
    state = "left"
  elseif f.x == screen.x + screen.w / 2 and 
         f.y == screen.y and 
         f.w <= screen.w / 2 + 50 and f.w > screen.w / 2 - 50 and 
         f.h <= screen.h + 50 and f.h > screen.h - 50 then
    state = "right"
  else
    state = "other"
  end

  return state
end

function resizeWindow(desired)
  local win = hs.window.frontmostWindow()
  local screen = win:screen():frame()
  local f = win:frame()
  local id = win:id()

  if desired == "full" then
    f.x = screen.x
    f.y = screen.y
    win:setFrame(f)
    f.w = screen.w
    f.h = screen.h
    win:setFrame(f)
  elseif desired == "left" then
    f.x = screen.x
    f.y = screen.y
    win:setFrame(f)
    f.w = screen.w / 2
    f.h = screen.h
    win:setFrame(f)
  elseif desired == "right" then
    f.x = screen.x + screen.w / 2
    f.y = screen.y
    win:setFrame(f)
    f.w = screen.w / 2
    f.h = screen.h
    win:setFrame(f)
  elseif desired == "center" then
    if origWindowPos[id] then
      -- restore the windowT (there is a value for origWindowPos)
      win:setFrame(origWindowPos[id])
    else
      f.x = screen.x + screen.w / 4
      f.y = screen.y + screen.h / 4
      win:setFrame(f)
      f.w = screen.w / 2
      f.h = screen.h / 2
      win:setFrame(f)
    end
  end

end

function moveWindow(direction)
  -- Check if there is a window present
  local win = hs.window.focusedWindow()
  if not win then return end

  -- Select the focused window or if not focused the front window
  win = hs.window.frontmostWindow()

  local id = win:id()

  position = getWindowState()

  if not origWindowPos[id] then
    -- add a watcher so we can clean the origWindowPos if the window is closed
    local watcher = win:newWatcher(cleanupWindowPos, id)
    watcher:start({hs.uielement.watcher.elementDestroyed})
  end
    moveWindowOneSpace(direction)
end

hs.hotkey.bind(hypershift, "h", function()
  moveWindow("left")
end)

hs.hotkey.bind(hypershift, "l", function()
  moveWindow("right")
end)



