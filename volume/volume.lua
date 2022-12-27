function changeVolume(diff)
  return function()
    local current = hs.audiodevice.defaultOutputDevice():volume()
    local new = math.min(100, math.max(0, math.floor(current + diff)))
    if new > 0 then
      hs.audiodevice.defaultOutputDevice():setMuted(false)
    end
    hs.alert.closeAll(0.0)
    hs.alert.show("🔊 " .. new .. "%", {fillColor= { white = 0, alpha = 0.5 }}, 0.5)
    hs.audiodevice.defaultOutputDevice():setVolume(new)
  end
end

function changeBrightness(diff)
    return function()
        local current =  hs.brightness.get()
        local new = math.min(100, math.max(0, math.floor(current + diff)))
        hs.alert.closeAll(0.0)
        hs.alert.show("🌞 " .. new .. "%", {fillColor= { white = 0, alpha = 0.5 }}, 0.5)
        hs.brightness.set(new)
    end
end

function setVolumeMuted()
  return function()
    local current = hs.audiodevice.defaultOutputDevice():muted()
    hs.audiodevice.defaultOutputDevice():setMuted(not current)
  end
end

function showVolume()
  return function()
    local current = hs.audiodevice.defaultOutputDevice():volume()
    hs.alert.closeAll(0.0)
    hs.alert.show("🔊 " .. math.floor(current) .. "%", {fillColor= { white = 0, alpha = 0.5 }}, 0.5)
  end
end
  
hs.hotkey.bind({'shift', 'ctrl'}, 'Down', changeVolume(-3))
hs.hotkey.bind({'shift', 'ctrl'}, 'Up', changeVolume(3))
hs.hotkey.bind({'shift', 'ctrl'}, 'Space', setVolumeMuted())
hs.hotkey.bind({'shift', 'ctrl'}, 's', showVolume())

hs.hotkey.bind({'shift', 'ctrl'}, 'Left', changeBrightness(-3))
hs.hotkey.bind({'shift', 'ctrl'}, 'right', changeBrightness(3))
  