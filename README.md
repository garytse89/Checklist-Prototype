Checklist-Prototype
===================

Corona SDK used to prototype a checklist application.

In [commit 1b88cfa825b53c43a44bbe94d7ed5d6a36d28020](https://github.com/garytse89/Checklist-Prototype/commit/1b88cfa825b53c43a44bbe94d7ed5d6a36d28020) I made a very fundamental mistake.

A class in Lua, such as Foo.lua, will be able to use methods from Bar.lua by adding the following line at the top of Foo.lua:
local Bar = require( "Bar" )

For some reason, I wanted to avoid circular dependency; a checklist would be a list with its own list of items.
I passed the checklist object as part of the constructor of a new item, so that in my item class (checkItem.lua), I could now access checklist.lua's methods. And why didn't I require "checklist" in checkItem.lua? To avoid this circular dependency.

Of course, this was wrong, but still functioned well, until I wanted to remove the item from the checklist's list of items:

> table.remove( self.list, self.num )

This led to me trying to remove the item from the checklist... but self.list referred to the checklist class, not the checklist's list of items.

In [commit 17565f24860af74195e61fa3179af4786d4ce776](https://github.com/garytse89/Checklist-Prototype/commit/17565f24860af74195e61fa3179af4786d4ce776), I fixed this, but you see that the syntax gets very confusing:

> self.list.listOfItems

The easiest fix is to just make the default checklist in main.lua global. So now I wouldn't have to attach a reference to an item's own list every time I made a new item. That would be odd.

