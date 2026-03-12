---
name: hammerspoon-development
description: Use when working with Hammerspoon, writing Lua automation scripts for macOS, binding hotkeys, creating menu bar items, or using hs.* APIs.
---

# Hammerspoon Development

Hammerspoon is a desktop automation framework for macOS, written in Lua. It bridges native macOS APIs with Lua scripting for system-level automation.

## Core Concepts

### Module System
Hammerspoon modules are accessed via `hs.module_name`:
- `hs.hotkey` — key binding and hotkey management
- `hs.task` — execute external commands and capture output
- `hs.application` — interact with running applications
- `hs.pasteboard` — clipboard operations
- `hs.canvas` — drawing primitives for UI elements
- `hs.menubar` — menu bar icons and menus
- `hs.timer` — delayed or recurring execution

### Configuration Location
- Main config: `~/.hammerspoon/init.lua` (loaded on startup)
- Modules: `~/.hammerspoon/` directory (require statements load from here)
- Logs: `~/.hammerspoon/` (use `hs.logger` for debugging)

## Common Patterns

### Menu Bar Icons
```lua
local menuIcon = hs.menubar.new()
menuIcon:setIcon(image)
menuIcon:setMenu(menu_table)
```

### Hotkey Bindings
```lua
hs.hotkey.bind({"cmd", "alt"}, "R", function()
  -- Called when Cmd+Alt+R is pressed
end)
```

### Running External Commands
Use `hs.task` for external processes:
```lua
hs.task.new("/usr/bin/curl", callback, {"-s", "http://example.com"}):start()
```
The callback receives `(exitCode, stdout, stderr)`.

### Working with Timers
```lua
local timer = hs.timer.doEvery(1.0, function()
  -- Runs every 1 second
end)
timer:stop()  -- Cancel the timer
```

### JSON Handling
```lua
local obj = hs.json.decode(jsonString)
local str = hs.json.encode(obj)
```

### Canvas-Based UI
Use `hs.canvas` to draw custom UI elements (icons, animations):
```lua
local c = hs.canvas.new({x=0, y=0, w=22, h=22})
c[1] = {type = "text", text = "Hello", frame = {x=0, y=0, w=22, h=22}}
local img = c:imageFromCanvas()
c:delete()
```

## Best Practices

### State Management
- Use local variables at the top of your script to track global state
- Avoid storing heavy objects; pass them as needed
- Reset state when Hammerspoon reloads (on config change)

### Async Operations
- `hs.task` callbacks are asynchronous; plan for long-running operations
- Store context in closures or module state, not global variables
- Use error handling: check for nil returns and error codes

### Performance
- Avoid tight loops in callbacks; use timers with appropriate intervals
- Cache frequently-used values (e.g., application references)
- Be cautious with file I/O in event handlers; do it asynchronously

### Debugging
- Use `print()` for debug output (visible in Console.app)
- Enable Hammerspoon's built-in logger: `hs.logger.setLogLevel("debug")`
- Check `~/.hammerspoon/` for log files if modules provide logging

### Reload Pattern
Hammerspoon reloads the config file when it changes. Handle cleanup:
```lua
-- Stop previous timers, delete menu icons, unbind hotkeys
if oldTimer then oldTimer:stop() end
if oldMenuIcon then oldMenuIcon:delete() end

-- Set up fresh instances
local newTimer = hs.timer.doEvery(1, function() end)
```

## Integration with External Services

### HTTP Requests
Use `hs.task.new` with `curl`:
```lua
local curlArgs = {"-s", "-X", "POST", "http://localhost:9000", "-d", jsonData}
hs.task.new("/usr/bin/curl", callback, curlArgs):start()
```

### Audio and File Operations
- `sox` for audio recording and processing
- `ffmpeg` for audio/video conversion
- Standard Lua `io` module for file operations (with `os.getenv("HOME")` for paths)

### Interacting with Applications
```lua
local app = hs.application.get("Emacs")
if app then
  app:activate()
  -- app:focusedWindow():focusWindowDown()
end
```
