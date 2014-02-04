--main.lua
local checklist = require("checklist") 
local widget = require("widget")

-- create a white background to fill screen
local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
bg.anchorX = 0
bg.anchorY = 0
bg:setFillColor( 255 )

default = checklist:new() -- global
default:init()

local printBtn = widget.newButton{	
		left = display.contentWidth*0.5,
    	top = display.contentHeight*0.1,
    	label = "PRINT",
    	onEvent = function(event)
    		if event.phase == "began" then
    			default:render()
    		end
    	end,
    	font = native.newFont( "Roboto Slab" ),
    	fontSize = 20,
    }