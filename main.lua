--main.lua
local checklist = require("checklist") 
local widget = require("widget")
local json = require("json")

-- create a white background to fill screen
local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
bg:setReferencePoint( display.CenterReferencePoint )
bg.x = display.contentCenterX
bg.y = display.contentCenterY
bg:setFillColor( 255 )

default = checklist:new() -- global
default:init()

local printBtn = widget.newButton{	
		left = display.contentWidth*0.4,
    	top = display.contentHeight*0.1,
    	label = "PRINT",
    	onEvent = function(event)
    		if event.phase == "began" then
    			default:render()
                local str = ""
                for i,v in pairs(default.listOfItems) do
                    if i < #default.listOfItems then
                        str = str.."• "..v.listField.text.."\n"
                    end
                end
                print (str)
    		end
    	end,
    	font = native.newFont( "Roboto Slab" ),
    	fontSize = 20,
    }

local shareBtn = widget.newButton{	
		left = display.contentWidth*0.4,
    	top = display.contentHeight*0.8,
    	label = "SHARE",
    	onEvent = function(event)
    		if event.phase == "began" then
    			local str = ""
    			for i,v in pairs(default.listOfItems) do
                    if i < #default.listOfItems then
    				    str = str.."• "..v.listField.text.."\n"
                    end
    			end
    			print (str)

    			local mailOptions = {
    				to = { "" },
    				cc = { "" },
    				subject = "Sharing my checklist: "..default.defaultField.text,
    				isBodyHtml = false,
    				body = str,
    			}

    			native.showPopup( "mail", mailOptions )
    		end
    	end,
    	font = native.newFont( "Roboto Slab" ),
    	fontSize = 20,
    }

printBtn:setReferencePoint( display.CenterReferencePoint )
printBtn.x = display.contentWidth/2

shareBtn:setReferencePoint( display.CenterReferencePoint )
shareBtn.x = display.contentWidth/2