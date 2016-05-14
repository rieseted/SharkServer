--- newfile module.
-- @author Tony Godfrey
-- @copyyright 2016 shark apps, LLC.  All rights reserved.
-- 


local _ = {}

local keyDown = {}

_.keyboard = {
    isDown = function( key )
--        print( "keyboard.isDown: " .. key )
        return keyDown[key]
    end,
    
}


_.graphics = {
    newImage = function( imageName )
        local img = display.newImage( imageName )
        img.isVisible = false
        return img
    end,
    
    draw = function( imageName, x, y )
        imageName.x = x
        imageName.y = y
        imageName.isVisible = true
    end,
    
    setBackgroundColor = function( r, g, b, a )
        local r1 = r or 0
        local g1 = g or 0
        local b1 = b or 0
        local a1 = a or 255
        display.setDefault( "background", r1/255, g1/255, b1/255, a1/255 )
    end

}


local function onKeyEvent( event )
    local phase = event.phase
    
    if ( phase == "down" ) then
        print( "onKeyEvent: " .. event.keyName .. " down" )
        keyDown[event.keyName] = true
        
    elseif ( phase == "up" ) then
        print( "onKeyEvent: " .. event.keyName .. " up" )
        keyDown[event.keyName] = nil
    
    end
end

--- initializes the module
-- @usage:
-- local mod = require( "mod" )
-- mod.init() 
function _.init()
    Runtime:addEventListener( "key", onKeyEvent )
    print( "LoveCorona module initialized" )
end


--- stops the key event listener
-- @usage:
-- local mod = require( "mod" )
-- mod.init() 
-- mod.stop() 
function _.stop()
    Runtime:removeEventListener( "key", onKeyEvent )
    print( "LoveCorona module stopped" )
end


-- on module load, run init
_.init()

return _

