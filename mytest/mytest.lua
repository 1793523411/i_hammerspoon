-- local notify = hs.notify.register('???', action)

local msg = ""

function action()
    hs.notify.new({title=msg, informativeText=''}):send()
end

function getAllWindows()
    return function()
        local choices = {
            { ["text"] = hs.styledtext.new("Third Possibility", {font={size=18}, color=hs.drawing.color.definedCollections.hammerspoon.green}),
              ["subText"] = "What a lot of choosing there is going on here!",
              ["uuid"] = "III3"
            },
        }
        -- hs.notify.new({title="???", informativeText="Hi Hi"}):send()
        hs.chooser.new(action)
        :bgDark(true)        
        :choices(choices)
        -- :rightClickCallback(
        --     function(a)
        --         hs.alert.show(a)
        --     end
        -- )
        :queryChangedCallback(
            function(input)
                msg = input
            end
        )
        :show()
    end
end

getAllWindows()
hs.hotkey.bind({'shift', 'ctrl'}, 't', getAllWindows())