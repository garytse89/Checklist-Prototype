--checklist.lua
local checkItem = require("checkItem")

local checklist = {}

local checklist_mt = { __index = checklist }

function checklist:new()
	local c = {}
	setmetatable( c, checklist_mt )
	c.group = display.newGroup( )
	c.counter = 1
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

	local newItem = checkItem:new(self.counter, self)
	table.insert(self.listOfItems, newItem)
	self.counter = self.counter+1
end

function checklist:newListItem()
	local newItem = checkItem:new(self.counter, self)
	table.insert(self.listOfItems, newItem)
	self.counter = self.counter+1
end

function checklist:render()
	local count = 0
	for index,item in pairs(self.listOfItems) do
		if item ~= nil then 
			print( item.listField.text )
			count = count + 1
		end
		item.listField.y = 400+count*60 
	end
	print(count)
end

return checklist