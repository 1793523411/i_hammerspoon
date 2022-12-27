---@diagnostic disable: undefined-global, lowercase-global
function showPasteBoard()
	return function()
		local content = hs.pasteboard.getContents()
		hs.alert.closeAll(0.0)
		hs.alert.show(content)
	end
end

hs.hotkey.bind({ "shift", "ctrl" }, "a", showPasteBoard())
