function screencurrentWindow()
    return function()
        local focsWin = hs.window.focusedWindow()
        focsWin:setFullScreen(not focsWin:isFullScreen())
    end
end

function closeCurrentWindow()
    return function()
        local focsWin = hs.window.focusedWindow()
        focsWin:close()
    end
end

hs.hotkey.bind({'shift', 'ctrl'}, 'o', screencurrentWindow())
hs.hotkey.bind({'shift', 'ctrl'}, 'q', closeCurrentWindow())