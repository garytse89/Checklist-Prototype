-----------------------------------------------------------------------------------------
--
-- view1.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-----------------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
-- 
-- NOTE: Code outside of listener functions (below) will only be executed once,
--		 unless storyboard.removeScene() is called.
-- 
-----------------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view
	
	-- create a white background to fill screen
	local bg = display.newRect( 0, 0, display.contentWidth, display.contentHeight )
	bg.anchorX = 0
	bg.anchorY = 0
	bg:setFillColor( 1 )

	local function textListener( event )

	    if ( event.phase == "began" ) then
	        -- user begins editing text field
	        print( event.text )
	    elseif ( event.phase == "ended" ) then
	        -- text field loses focus
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	        -- do something with defaulField's text
	    elseif ( event.phase == "editing" ) then
	        print( event.newCharacters )
	        print( event.oldText )
	        print( event.startPosition )
	        print( event.text )
	    end
	end

	-- Create our title Text Field
	defaultField = native.newTextField( display.contentWidth/2, display.contentHeight*0.2, 500, 100 )
	defaultField:addEventListener( "userInput", textListener )
	defaultField.text = "Title"
	defaultField.font = native.newFont( "Roboto Slab" )
	defaultField.size = 20

	-- displays a plus sign wherever an item can be added
	local signList = {}

	local function addPlusSign(num)
		local plusSign = display.newText( "+", 150+num*60, 400, "Roboto Slab", 50 )
		plusSign:setTextColor(0)
		table.insert( signList, plusSign )
	end	

	local function changePlusSign(num)
		signList[num].text = "[]"
	end

	local function listTextListener( event )

	    if ( event.phase == "began" ) then
	    elseif ( event.phase == "ended" ) then
	        -- text field loses focus
	        if(event.target == true) then
	        	createNewField()
		    end
	    elseif ( event.phase == "ended" or event.phase == "submitted" ) then
	        -- do something with defaulField's text
	    elseif ( event.phase == "editing" ) then
	    	changePlusSign(1)
	    end
	end	

	-- all list text fields
	local listFields = {}

	function createNewField()
		-- Create our list Text Field with y-pos based on number of current fields
		local listField = native.newTextField( display.contentWidth*0.6, 400+#listFields*60, 400, 50 )
		listField:addEventListener( "userInput", listTextListener )
		listField.text = "List item"
		listField.size = 20
		listField.new = true
		listField.font = native.newFont( "Roboto Slab" )
		listField:setTextColor( 179,179,179 )
		table.insert( listFields,listField )

		if (#listFields > 1) then -- array out of bounds
			listFields[#listFields-1].new = false
		end

		group:insert( listField )
	end
	
	createNewField()
	addPlusSign(0)

	-- all objects must be added to group (e.g. self.view)
	group:insert( bg )
	group:insert( defaultField )
end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-- Do nothing
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	group.isVisible = false
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	-- INSERT code here (e.g. remove listeners, remove widgets, save state variables, etc.)
	
end

-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene