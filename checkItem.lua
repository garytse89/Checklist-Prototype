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
	c.num = num+1
	c.group = display.newGroup() -- might not be needed
	c:init(num)	
	return c
end

function checkItem:init(num)
	local listField = native.newTextField( display.contentWidth*0.3, 0, 200, 40 )
	listField:addEventListener( "userInput", function(event) self:textListener(event) end )
	listField.text = "List item"
	listField.size = 20
	listField.new = true
	listField.font = native.newFont( "Roboto Slab" )
	listField:setTextColor( 179,179,179 )
	listField:setReferencePoint( display.CenterReferencePoint )
	listField.y = 400+num*60 - 10

	self.listField = listField

	self.box = display.newText( "+", display.contentWidth*0.2, 0, native.newFont( "Roboto Slab" ), 20 )
	self.box:setTextColor( 179 )
	self.box:setReferencePoint( display.CenterReferencePoint )
	self.box.y = 400+num*60

	self.group:insert(self.box)
    self.group:insert(self.listField)
end

function checkItem:initDelete()
	self.deleteBtn = display.newText( "X", display.contentWidth*0.8, 400+(self.num-1)*60, native.newFont( "Roboto Slab" ), 20 )
	self.deleteBtn:setTextColor( 179 )
	self.deleteBtn:setReferencePoint( display.CenterReferencePoint )
	self.deleteBtn.y = 400+(self.num-1)*60

	self.deleteBtn:addEventListener( "touch", 
		function(event)
    		if event.phase == "began" then
    			print(self.listField.text, self.num)
    			table.remove(default.listOfItems,self.num)
    			self.group:removeSelf()
    			default:reorder()
    			default:render()
    			
    		end
    	end)

    self.group:insert(self.deleteBtn)
end

function checkItem:turnPlusToBox()
	self.box.text = "[]"
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