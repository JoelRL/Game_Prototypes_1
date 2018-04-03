function objectsVault(id)
	if id == 1 then
		local t = {}
		
		t.w = 50
		t.h = 120
		t.img = love.graphics.newImage("assets/tree.png")
		t.depth = 1
		t.rotate = 0
		
		t.collX = 10
		t.collY = 0
		t.collW = 30
		t.collH = 121
		t.collTyp = "solid"
		
		return t
	end
	if id == 2 then
		local t = {}
		
		t.w = 85/2
		t.h = 15/2
		t.img = love.graphics.newImage("assets/stick.png")
		t.depth = -1
		t.rotate = 0
		t.center = 0
		
		t.collX = (t.w/2)*-1
		t.collY = (t.h/2)*-1
		t.collW = t.w
		t.collH = t.h
		t.collTyp = "grab"
		
		-- Grabing vars
		t.angle1 = 2
		t.angle2 = 1.4
		t.gX1 = 46
		t.gY1 = 12
		t.gX2 = 20
		t.gY2 = 12
		t.usable = false
		
		return t
	end
	if id == 3 then
		local t = {}
		
		t.w = 70
		t.h = 12
		t.img = love.graphics.newImage("assets/sword.png")
		t.depth = -1
		t.rotate = 0
		t.center = 0
		
		t.collX = (t.w/2)*-1
		t.collY = (t.h/2)*-1
		t.collW = t.w
		t.collH = t.h
		t.collTyp = "grab"
		
		-- Grabing vars
		t.angle1 = 2
		t.angle2 = 1.4
		t.gX1 = 52
		t.gY1 = 5
		t.gX2 = 22
		t.gY2 = 2
		t.usable = true
		
		return t
	end
	if id == 4 then
		local t = {}
		
		t.w = 55
		t.h = 45
		t.img = love.graphics.newImage("assets/fire.png")
		t.depth = -1
		t.rotate = 0
		t.center = 1
		
		t.collX = 0
		t.collY = 0
		t.collW = t.w
		t.collH = t.h
		t.collTyp = "solid"
		
		-- Grabing vars
		t.angle1 = 2
		t.angle2 = 1.4
		t.gX1 = 52
		t.gY1 = 5
		t.gX2 = 22
		t.gY2 = 2
		t.usable = true
		
		return t
	end
end