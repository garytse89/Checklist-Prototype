--box.lua
local box = {}

local box_mt = { __index = box }

function box:new(num)
	local b = {}
	setmetatable( b, box_mt )
	local newBox = display.newText( "+", display.contentWidth*0.2, 400+num*60, native.newFont( "Roboto Slab" ), 20 )
	--newBox:setTextColor( 179,179,179 )
	newBox:setTextColor( 179 )
	b.box = newBox

	return b
end

return box