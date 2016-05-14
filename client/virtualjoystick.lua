--- newfile module.
-- @author Tony Godfrey
-- @copyyright 2016 shark apps, LLC.  All rights reserved.
-- 


local joystick = {}

function joystick:create( group, joyRadius )
    local stage = display.getCurrentStage();
    local mMin = math.min;
    local mCos = math.cos;
    local mSin = math.sin;
    local mAtan2 = math.atan2;
    local mSqrt = math.sqrt;
    local mFloor = math.floor;
    local mPi = math.pi;
    
    local joyGroup = display.newGroup();
    group:insert(joyGroup);
--    local bgJoystick = display.newImageRect(joyGroup, imgBgJoystick, bgWidth, bgHeight );
--    bgJoystick.x, bgJoystick.y = 0, 0;
    local bgJoystick = display.newCircle(joyGroup, 0, 0, joyRadius);
    bgJoystick:setFillColor(0, 0.5)
    local radius = joyRadius
--    joyGroup.radius = radius;
    joyGroup.radius = radius;
    local radToDeg = 180/mPi;
    local degToRad = mPi/180;
--    local joystick = display.newImageRect(joyGroup, imgJoystick, joyWidth, joyHeight );
    local joystick = display.newCircle(joyGroup, 0, 0, joyRadius * 0.75);
    joystick:setFillColor( 64/255, 128/255, 255/255, 0.7)
    
    function joystick:touch(event)
        local phase = event.phase;
        if phase == "moved" then
            if self.isFocus then
                local parent = self.parent;
                local posX, posY = parent:contentToLocal(event.x, event.y);
                local angle = (mAtan2( posX, posY )*radToDeg)-90;
                if angle < 0 then angle = 360 + angle end;
                local distance = mSqrt((posX*posX)+(posY*posY));
                if distance >= radius then
                    local radAngle = angle*degToRad;
                    distance = radius;
                    self.x, self.y = distance*mCos(radAngle), -distance*mSin(radAngle)
                else
                    self.x, self.y = posX, posY;
                end
                parent.angle = angle;
                parent.distance = distance;
            else
                stage:setFocus(event.target, event.id);
                self.isFocus = true;
                self.parent.state = true;
                self.alpha = 0.5;    
            end
        elseif phase == "began" then
            stage:setFocus(event.target, event.id);
            self.isFocus = true;
            self.parent.state = true;
            self.alpha = 0.5;
            local parent = self.parent;
            local posX, posY = parent:contentToLocal(event.x, event.y);
            self.x, self.y = posX, posY;
            local angle = (mAtan2( posX, posY )*radToDeg)-90;
            if angle < 0 then angle = 360 + angle end;
            local distance = mSqrt((posX*posX)+(posY*posY));
            if distance >= radius then
                local radAngle = angle*degToRad;
                distance = radius;
                self.x, self.y = distance*mCos(radAngle), -distance*mSin(radAngle)
            else
                self.x, self.y = posX, posY;
            end
            parent.angle = angle;
            parent.distance = distance;
        else
            self.isFocus = false;
            self.parent.state = false;
            self.x, self.y = 0, 0;
            self.parent.distance = 0;
            self.parent.angle = 0;
            stage:setFocus(nil, event.id);
            self.alpha = 1;
        end
        return true;
    end
    
    joyGroup.activate = function()
        joyGroup[1]:addEventListener("touch", joyGroup[2]);
        joyGroup.angle, joyGroup.distance = 0, 0;
    end
    joyGroup.deactivate = function()
        joyGroup[1]:removeEventListener("touch", joyGroup[2]);
        joyGroup.angle, joyGroup.distance = 0, 0;
    end
    joyGroup.x, joyGroup.y = joyGroup.contentWidth*0.5, display.contentHeight-joyGroup.contentHeight*0.5;
    return (joyGroup);
end


return joystick

