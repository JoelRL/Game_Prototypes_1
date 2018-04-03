world_collisions = {}

world_collisions.colls = {}
world_collisions.entities = {}

function world_collisions.newFloor(x,y,w,h,draw)
	local t = {}
	t.x = x
	t.y = y
	t.w = w
	t.h = h
	t.id = #world_collisions.colls + 1
	t.shape = shapes.newPolygonShape(x,y,x+w,y,x+w,y+h,x,y+h)
	t.class = "floor"
	if draw == nil then
		t.draw = true
	else
		t.draw = draw
	end
	table.insert(world_collisions.colls,t)
end

function world_collisions.newColl(x,y,w,h,draw)
	local t = {}
	t.x = x
	t.y = y
	t.w = w
	t.h = h
	if draw == nil then
		t.draw = true
	else
		t.draw = draw
	end
	t.id = #world_collisions.colls + 1
	t.shape = shapes.newPolygonShape(x,y,x+w,y,x+w,y+h,x,y+h)
	t.class = "coll"
	world_collisions.newFloor(x+5,y,w-10,10)
	table.insert(world_collisions.colls,t)
end

function world_collisions.newEnemy(x,y,typ,Sfacedir,static)
	local t = {}
	t.x = x
	t.y = y
	t.typ = typ
	if typ == 1 or typ == 4 then
		t.w = 35
		t.h = 60
		t.spd = 3
		t.frame = 2
		t.defSpd = t.spd
		t.bulletTimr = 0
		t.bulletTimrMax = 100
		t.bullets = {}
		t.sprOffX = -20
		t.sprOffY = -25
		t.active = true
		t.hp = 70
		t.sprRot = 0
			
		if Sfacedir == nil then
			t.faceDir = "l"
		else
			t.faceDir = Sfacedir
			if Sfacedir == "r" then
				t.sprOffX = -10
				t.frame = 2
			else
				t.sprOffX = -20
				t.frame = 1
			end
		end
	end
	if typ == 2 or typ == 5 then
		t.w = 37
		t.h = 110
		t.spd = 10
		t.frame = 3
		t.defSpd = t.spd
		t.sprOffX = 0
		t.sprOffY = 0
		t.active = false
		t.faceDir = "fuck"
		t.deathTimr = 0
		t.sprRot = 0
		t.hp = 4
		if typ == 5 then
			t.spd = 7
			t.hp = 20
			t.defSpd = t.spd
		end
	end
	
	if typ == 3 then
		t.w = 42
		t.h = 256
		t.y = t.y + t.h
		t.spd = 9
		t.frame = 5
		t.sprRot = -1.57
		t.defSpd = t.spd
		t.sprOffX = 0
		t.sprOffY = 0
		t.active = false
		t.faceDir = "fuck"
		t.deathTimr = 0
		t.hp = 300
		world_collisions.newFloor(x+15,y,t.w,10,false)
		t.deleteID = #world_collisions.colls
	end
	t.id = #world_collisions.entities + 1
	if typ ~= 3 then
		t.shape = shapes.newPolygonShape(x,y,x+t.w,y,x+t.w,y+t.h,x,y+t.h)
	else
		local x1, y1 = x+15, y
		t.shape = shapes.newPolygonShape(x1,y1,x1+t.w,y1,x1+t.w,y1+t.h,x1,y1+t.h)
	end
	t.class = "enemy"
	t.maxHP = t.hp
	t.draw = true
	if static == nil then
		t.moved = false
		t.movedUnits = 0
	else
		t.moved = true
		t.movedUnits = 40
	end
	t.noticedP = false
	t.particleTimr = 0
	t.partX = 20
	t.partY = -25
	t.color = {255,255,255,255}
	t.showP = 1
	table.insert(world_collisions.entities,t)
end

function world_collisions.newBoss(id,x,y)
	local t = {}
	t.class = "boss"
	t.x = x
	t.y = y
	t.id = id
	if id == 1 then
		t.stage = "wait"
		t.fightStage = 1
		t.hp = 1000
		t.maxHP = t.hp
		t.timer1 = 0
		t.timer2 = 0
		t.fightTimer1Max = love.math.random(60,100)
		t.cameraShk = 10
		t.xSpd = 8
		t.ySpd = 2
		t.maxXspd = t.xSpd
		t.maxYspd = t.ySpd
		t.dirX = 1
		t.dirY = 1
		t.draw = true
		t.w = 150
		t.h = 90
		t.sprOffX = 0
		t.sprOffY = -50
		t.particles = {}
		t.particleTimr = 0
		t.particleTimrMax = 3
		t.talk = false
		t.talkF = 2
		t.scriptNum = 1
		t.script = {
			"well hello there you american infadels, like my new ride? custom made from north korea tesra",
			"pretty sweet heh?",
			"too bad im gonna get it dirty with you scum...",
			"either way, prepare to die!!",
		}
		t.deathScript = {
			"arg!!!",
			"youll pay for this you americans!!",
		}
		t.color = {255,255,255,255}
		t.blindspot = false
		t.aptternNUM = 1
	end
	
	t.shape = shapes.newPolygonShape(x,y,x+t.w,y,x+t.w,y+t.h,x,y+t.h)
	table.insert(world_collisions.entities,t)
end

function world_collisions.newBossTrigger(x,y,w,h,id)
	local t = {}
	t.x = x
	t.y = y
	t.w = w
	t.h = h
	t.id = id
	t.shape = shapes.newPolygonShape(x,y,x+t.w,y,x+t.w,y+t.h,x,y+t.h)
	t.class = "bossTrigger"
	t.draw = false
	table.insert(world_collisions.entities,t)
end

function world_collisions.endZone(x,y,w,h,lvl)
	local t = {}
	t.id = "end"
	t.x = x
	t.y = y
	t.w = w
	t.h = h
	t.lvl = lvl
	t.class = "endZone"
	t.shape = shapes.newPolygonShape(x,y,x+t.w,y,x+t.w,y+t.h,x,y+t.h)
	table.insert(world_collisions.colls,t)
end