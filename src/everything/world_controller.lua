require 'objects'

function newColl_1(x,y,w,h,typ,objID)
	local t = {}
	if objID ~= nil then
		t.objID = objID
	end
	t.id = #colls + 1
	t.typ = typ
	t.x = x
	t.y = y
	t.w = w
	t.h = h
	
	t.shape = shapes.newPolygonShape(x,y,x+w,y,x+w,y+h,x,y+h)
	table.insert(colls,t)
end

function newObject(typ,x,y)
	if typ == 1 or typ == 4 then
		
		local t = {}
		t.class = "object"
		t.id = #objects + 1
		t.typ = typ
		t.x = x
		t.y = y
		t.center = 1
		
		local values = objectsVault(typ)
		
		t.w = values.w
		t.h = values.h
		
		t.img = values.img
		t.depth = values.depth
		
		newColl_1(t.x+values.collX,t.y+values.collY,values.collW,values.collH,values.collTyp,t.id)
		
		t.collW2 = values.collW / 2
		t.collH2 = values.collH / 2
		
		table.insert(objects,t)
		
	end
	if typ == 2 or typ == 3 then
		
		local t = {}
		t.class = "object"
		t.id = #objects + 1
		t.typ = typ
		t.x = x
		t.y = y
		
		local values = objectsVault(typ)
		
		t.w = values.w
		t.h = values.h
		
		t.img = values.img
		t.depth = values.depth
		t.rotate = values.rotate
		t.center = values.center
		
		newColl_1(t.x+values.collX,t.y+values.collY,values.collW,values.collH,values.collTyp,t.id)
		
		t.collX = values.collX
		t.collY = values.collY
		t.collW2 = values.collW / 2
		t.collH2 = values.collH / 2
		
		t.angle1 = values.angle1
		t.angle2 = values.angle2
		t.gX1 = values.gX1
		t.gY1 = values.gY1
		t.gX2 = values.gX2
		t.gY2 = values.gY2
		
		t.angle1D = t.angle1
		t.angle2D = t.angle2
		t.gX1D = t.gX1
		t.gY1D = t.gY1
		t.gX2D = t.gX2
		t.gY2D = t.gY2
		
		t.usable = values.usable
		
		table.insert(t,reactionValues())
		
		table.insert(objects,t)
		
	end
end

function reactionValues()
	local t = {}
	t.grabReaction = false
	t.grabReactionX = 0
	t.grabReactionY = 0
	t.grabReactionYSwitch = 1
	t.grabReactionYL = 0
	t.grabReactionRnum = 0
	return t
end