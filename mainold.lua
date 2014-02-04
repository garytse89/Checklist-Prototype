-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )

-- include Corona's "widget" library
local widget = require "widget"
local storyboard = require "storyboard"


-- event listeners for tab buttons:
local function onFirstView( event )
	storyboard.gotoScene( "newlist" )
end

local function onSecondView( event )
	storyboard.gotoScene( "templates" )
end

local function saveList( event )
	-- write to local storage
	print( "save current list" )
end

-- create a tabBar widget with two buttons at the bottom of the screen

-- table to setup buttons
local tabButtons = {
	{   label="Create New List", 
		defaultFile="icon1.png", 
		overFile="icon1-down.png", 
		width = 64, height = 64, 
		onPress=onFirstView, 
		selected=true 
	},

	{   label="Save", 
		--defaultFile="save.png", 
		--overFile="icon2-down.png", 
		width = 64, height = 64, 
		onPress=saveList, 
		isEnabled = false,
	},

	{   label="Existing Lists", 
		defaultFile="icon2.png", 
		overFile="icon2-down.png", 
		width = 64, height = 64, 
		onPress=onSecondView 
	},
}

-- create the actual tabBar widget
local tabBar = widget.newTabBar {
	top = display.contentHeight - 100,	-- 50 is default height for tabBar widget
	height = 100,
	buttons = tabButtons
}

onFirstView()	-- invoke first tab button's onPress event manually