--checkItem.lua
local widget = require( "widget" )
local checkItem = {}

local checkItem_mt = { __index = checkItem }

function checkItem:new(num)
	local c = {}
	setmetatable( c, checkItem_mt )
	c.listField = listField
	c.edited = false
	c.checked = false
	c.num = num+1
	c.group = display.newGroup() -- might not be needed
	c:init(num)	
	return c
end

function checkItem:init(num)

	local listField = native.newTextField( display.contentWidth*0.3, 0, display.contentWidth*350/720, 60 )
	listField:addEventListener( "userInput", function(event) self:textListener(event) end )
	listField.text = "List item"
	listField.font = native.newFont( "Roboto Slab" )
	listField.size = 10
	listField:setTextColor( 179,179,179 )
	listField:setReferencePoint( display.CenterReferencePoint )
	listField.y = 400+num*60

	self.listField = listField

	--self.box = display.newText( "+", display.contentWidth*0.2, 0, native.newFont( "Roboto Slab" ), 20 )
	--self.box:setTextColor( 179 )
	self.box = display.newImage( "images/plus.png", 0, 0 )
	self.box:setReferencePoint( display.CenterReferencePoint )
	self.box.x = display.contentWidth*0.2
	self.box.y = 400+num*60

	self.box:addEventListener( "touch", function(event)
	 	self:checkOff(event)
	end)

	self.group:insert(self.box)
    self.group:insert(self.listField)
end

function checkItem:initDelete()
	--self.deleteBtn = display.newText( "X", display.contentWidth*0.8, 400+(self.num-1)*60, native.newFont( "Roboto Slab" ), 20 )
	--self.deleteBtn:setTextColor( 179 )
	self.deleteBtn = display.newImage( "images/x.png", 0, 0 )
	self.deleteBtn:setReferencePoint( display.CenterReferencePoint )
	self.deleteBtn.x = display.contentWidth*0.9
	self.deleteBtn.y = 400+(self.num-1)*60
	self.deleteBtn:scale(2,2)

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
	self.box:removeSelf()
	self.box = display.newImage( "images/emptybox.png", 0, 0 )
	self.box:setReferencePoint( display.CenterReferencePoint )
	self.box.x = display.contentWidth*0.2
	self.box.y = 400+(self.num-1)*60
	self.box:addEventListener( "touch", function(event)
	 	self:checkOff(event)
	end)
	self.box:scale(2,2)
	self.group:insert(self.box)
end

function checkItem:checkOff(event)
	if event.phase == "began" and self.edited == true then
		if self.checked == false then
			self.box:removeSelf()
			self.box = display.newImage( "images/checkedbox.png", 0, 0 )
			self.box:setReferencePoint( display.CenterReferencePoint )
			self.box.x = display.contentWidth*0.2
			self.box.y = 400+(self.num-1)*60
			self.box:addEventListener( "touch", function(event)
			 	self:checkOff(event)
			end)
			self.box:scale(2,2)
			self.group:insert(self.box)

			-- cross out the text
			self.listField:setTextColor(179,179,179)
			print(string.len(self.listField.text)*10, self.listField.y)
			self.strikethough = display.newLine( self.group, display.contentWidth*0.3, self.listField.y, display.contentWidth*0.5, self.listField.y )
			self.strikethough:setColor(0)

			self.strikethough:toFront()

			self.checked = true
		else
			self.box:removeSelf()
			self.box = display.newImage( "images/emptybox.png", 0, 0 )
			self.box:setReferencePoint( display.CenterReferencePoint )
			self.box.x = display.contentWidth*0.2
			self.box.y = 400+(self.num-1)*60
			self.box:addEventListener( "touch", function(event)
			 	self:checkOff(event)
			end)
			self.box:scale(2,2)
			self.group:insert(self.box)

			self.listField:setTextColor(0)
			self.strikethough:removeSelf()

			self.checked = false
		end
	end
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
			self.listField:setTextColor(179,179,179)
		elseif self.checked == true then
			self.listField:setTextColor(179,179,179)
		end
	end
end

return checkItem