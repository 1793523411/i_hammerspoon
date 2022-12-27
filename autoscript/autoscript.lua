-- local cmdArr = {
--     "source /Users/bytedance/.hammerspoon/autoscript/charles.sh"
-- }
local t = io.popen('source /Users/bytedance/.hammerspoon/autoscript/ps.sh')
local a = t:read("*all")
-- print(a)
-- print(type(a))

local defaultProxy = string.find(a,"-e HTTPS: ✔ Yes : Yes")
if isOpen ~= nil then 
    defaultProxy = 'on'
else
    defaultProxy = 'off'
end

-- print(string.find(a,"-e HTTPS: ✔ Yes : Yes"))
local proxy = defaultProxy


function shell()
    -- print("result " .. cmd);
    -- result, obj, descriptor = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    -- result, obj, descriptor = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
    -- local t = io.execute('p off')
    -- print("result ", t);
    -- local t = os.execute('source /Users/bytedance/.hammerspoon/autoscript/ps.sh')
    -- local t = io.popen('source /Users/bytedance/.hammerspoon/autoscript/ps.sh')
    -- local a = t:read("*all")
    -- print(a)

    if proxy == 'off' then
        proxy = 'on'
        os.execute('source /Users/bytedance/.hammerspoon/autoscript/pon.sh')
    else
        proxy = 'off'
        os.execute('source /Users/bytedance/.hammerspoon/autoscript/poff.sh')
    end
    hs.alert.closeAll(0.0)
    hs.alert.show('proxy: '.. proxy)
end

function runAutoScripts()
    for key, cmd in ipairs(cmdArr) do
        shell(cmd)
    end
end

function changeCharles()
    return function()
        -- print('shell test')
        -- result, obj, descriptor = hs.osascript.applescript(string.format('do shell script "%s"', "p off"))
        -- print("result ", result, obj, descriptor);
        -- runAutoScripts()
        -- print('???')
        shell()
    end
end

-- hs.timer.doEvery(3, runAutoScripts)

function showCharles()
   return function()
    local t = io.popen('source $HOME/.hammerspoon/autoscript/ps.sh')
    local a = t:read("*all")
    local isOpen = string.find(a,"-e HTTPS: ✔ Yes : Yes")
    hs.alert.closeAll(0.0)
    if isOpen ~= nil then 
        hs.alert.show('proxy: on')
    else
        hs.alert.show('proxy: off')
    end
   end
end

hs.hotkey.bind({'shift', 'ctrl'}, 'c', changeCharles())
hs.hotkey.bind({'shift', 'ctrl'}, 's', showCharles())