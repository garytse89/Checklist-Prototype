--checklist.lua
local checkItem = require("checkItem")

local checklist = {}

local checklist_mt = { __index = checklist }

function checklist:new()
	local c = {}
	setmetatable( c, checklist_mt )
	c.group = display.newGroup( )
	c.listOfItems = {}
	return c
end

function checklist:textListener( event )
end

function checklist:init()
	-- Create our title Text Field
	self.defaultField = native.newTextField( 0, display.contentHeight*0.2, 500, 100 )
	self.defaultField:addEventListener( "userInput", self.textListener )
	self.defaultField.text = "Title"
	self.defaultField.font = native.newFont( "Roboto Slab" )
	self.defaultField.size = 20
	self.defaultField:setReferencePoint( display.CenterLeftReferencePoint )
	self.defaultField.x = display.contentWidth*0.2

	self.group:insert(self.defaultField)

	self:newListItem()
end

function checklist:newListItem()
	local newItem = checkItem:new(#self.listOfItems)
	table.insert(self.listOfItems, newItem)
end

function checklist:render()
	for index,item in pairs(self.listOfItems) do
		print(item.num-1)
		item.listField.y = 400+(item.num-1)*60 
		item.box.y = 400+(item.num-1)*60 
		if item.deleteBtn then
			item.deleteBtn.y = 400+(item.num-1)*60 
		end
		print(index,item.listField.text)
	end
end

function checklist:reorder()
	for index,item in pairs(self.listOfItems) do
		item.num = index
	end
end

return checklist