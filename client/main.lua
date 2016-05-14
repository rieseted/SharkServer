--- Corona client for SharkServer.
-- Adapted from luamatch Love client

local love = require( "LoveCorona" )

local json = require "json"
local socket = require "socket"
local address, port = "192.168.1.175", 12345
local entity
local updaterate = 0.1
local world = {}
local t

function love.load()
    udp = socket.udp()
    udp:settimeout(0)
    udp:setpeername(address, port)
    love.graphics.setBackgroundColor(255, 255, 255)
    entity_img = love.graphics.newImage("unitR.png")
    math.randomseed(os.time()) 
    entity = tostring(math.random(9999))
    t = 0
end

function love.update(deltatime)
    t = t + deltatime
--    print( "t=" .. t )
    if t > updaterate then
        local x, y = 0, 0
        if love.keyboard.isDown("up") or love.keyboard.isDown("w") then 
            y = y - (70 * t)
--            print( "y=" .. y )
        end
        if love.keyboard.isDown("down") or love.keyboard.isDown("s") then 
            y = y + (70 * t)
--            print( "y=" .. y )
        end
        if love.keyboard.isDown("left") or love.keyboard.isDown("a") then 
            x = x - (70 * t) 
--            print( "x=" .. x )
        end
        if love.keyboard.isDown("right") or love.keyboard.isDown("d") then 
            x = x + (70 * t) 
--            print( "x=" .. x )
        end
        local dg = string.format("%s %s %f %f", entity, "bad", x, y)
        udp:send(dg)
        t = t - updaterate
--        print( "send: " .. dg )
    end

    repeat
        data, msg = udp:receive()
        if data then
--            print( "received datagram" )
            world = json.decode(data)
        elseif msg ~= "timeout" then print("Unknown network error: " .. tostring(msg)) end
    until not data 
end

function love.draw()
    for k, v in pairs(world) do
--        print( "draw: x=" .. v.x .. ", y=" .. v.y )
        love.graphics.draw(entity_img, v.x, v.y)
    end
end

function love.quit()
    print( "quitting udp session" )
    udp:send(string.format("%s %s %d %d", entity, "quit", 0, 0))
end


local runtime = 0
 
local function getDeltaTime()
    local temp = system.getTimer()  -- Get current game time in ms
    local dt = (temp-runtime) / 1000 -- / (1000/60) -- 60 fps or 30 fps as base
    runtime = temp  -- Store game time
    return dt
end

local function update()
    love.update( getDeltaTime() )
    love.draw()
end

local function onSystemEvent( event )
    print( "onSystemEvent: " .. event.type )
    if ( event.type == "applicationStart" ) then
        
    elseif ( event.type == "applicationOpen" ) then
        
    elseif ( event.type == "applicationResume" ) then
        
    elseif ( event.type == "applicationSuspend" ) then
        love.quit()
    
    elseif ( event.type == "applicationExit" ) then
        love.quit()
    end
    
    return true
end


love.load()
Runtime:addEventListener( "enterFrame", update )
Runtime:addEventListener( "system", onSystemEvent )

--local imgJoystick = display.newCircle(0, 0, 50 )
--imgJoystick:setFillColor(0, 0.8)
--local imgBgJoystick = display.newCircle(0, 0, 75 )
--imgBgJoystick:setFillColor(0, 0.5)
local joyGroup = display.newGroup()
local joy1 = require( "virtualjoystick" ):create( joyGroup, 75 )
joy1.x = 100
joy1.y = display.contentHeight - 100
