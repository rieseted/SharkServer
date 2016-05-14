----------------------------------------------------------
-- Summary: App configuration
-- 
-- Description: App configuration information
-- 
-- @author Tony Godfrey (tonygod@sharkappsllc.com)
-- @copyright 2016 shark apps, LLC
-- @license all rights reserved.
----------------------------------------------------------
local aspectRatio = display.pixelHeight / display.pixelWidth
local maxWidth = 480
local maxHeight = 960

application = {
    launchPad = false,  -- disable Corona Analytics
    content = {
--        width = aspectRatio > 1.5 and maxWidth or math.ceil( maxHeight / aspectRatio ),
--        height = aspectRatio < 1.5 and maxHeight or math.ceil( maxWidth * aspectRatio ),
        scale = "letterBox",
        width = maxWidth,
        height = maxHeight, 
        scale = "letterBox",
        fps = 60,
        imageSuffix =
        {
          ["@2x"] = 2,
          ["@3x"] = 3,
--          ["@4x"] = 4,
        },
    },
    
    license = -- IAP
    {
        google =
        {
            key = "GOOGLE IAP KEY GOES HERE"
        },
    },    
    
    --[[
    -- Push notifications

    notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert", "newsstand"
            }
        }
    }
    --]]    
}


