--checkItem.lua
local widget = require( "widget" )
local box = require("box")
local checkItem = {}

local checkItem_mt = { __index = checkItem }

function checkItem:new(num)
	local c = {}
	setmetatable( c, checkItem_mt )
	c.listField = listField
	c.edited = false
	c.num = num
	c.group = display.newGroup() -- might not be needed
	c:init(num)	
	return c
end

function checkItem:init(num)
	local listField = native.newTextField( display.contentWidth*0.3, 0, 200, 50 )
	listField:addEventListener( "userInput", function(event) self:textListener(event) end )
	listField.text = "List item"
	listField.size = 20
	listField.new = true
	listField.font = native.newFont( "Roboto Slab" )
	listField:setTextColor( 179,179,179 )
	listField:setReferencePoint( display.CenterReferencePoint )
	listField.y = 400+num*60

	self.listField = listField

	local newBox = box:new(num)
	self.box = newBox
	self.group:insert(self.box.box)
    self.group:insert(self.listField)
end

function checkItem:initDelete()
	local deleteBtn = widget.newButton{	
		left = display.contentWidth*0.8,
    	top = 400+self.num*60,
    	id = "delete",
    	label = "X",
    	onEvent = function(event)
    		if event.phase == "began" then
    			table.remove(default.listOfItems,self.num)
    			self.group:removeSelf()
    			default:render()
    		end
    	end,
    	font = native.newFont( "Roboto Slab" ),
    	fontSize = 20,
    	labelColor = { default = {179} },
    	labelAlign = "left",  	
    }

    self.group:insert(deleteBtn)
end

function checkItem:turnPlusToBox()
	self.box.box.text = "[]"
end

function checkItem:textListener( event )
	if event.phase == "began" then
		if self.listField.text == "List item" then
			self.listField.text = ""
		end
		self.listField:setTextColor(0)
	elseif event.phase == "editing" and self.edited == false then
		self.listField:setTextColor(0)
		default:newListItem()
		self.edited = true
		self:initDelete()
		self:turnPlusToBox()
	elseif event.phase == "ended" then
		if self.listField.text == "" then
			self.listField.text = "List item"
		end
		self.listField:setTextColor(179,179,179)
	end
end

return checkItem