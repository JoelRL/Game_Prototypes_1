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
	if id == 2 then
		t.stage = "wait"
		t.frame = 1
		t.draw = true
		t.w = 45
		t.h = 66
		t.color = {255,255,255,255}
		t.sprOffX = 0
		t.sprOffY = 0
		t.scale = 1
		t.timer1 = 0
		t.talk = false
		t.talkF = 3
		t.scriptNum = 1
		t.script = {
			"Hi :)",
			"hehe! thanks for rescuing me from the bwad bwad man ;)",
			"i gwuess youll want a reward now, right? ;;;;;)",
			"step aside bitch, we got business to do.",
			"hey thats not very ni--",
			"sorry gal, no survivors.",
			"uhhhhh what?",
			"!?!?!?!??!?!?!?!?!?!?",
			"beep boop. need key to open.",
			"hahahahahahahahahahahahahahahahaha",
		}
		t.x1 = t.x - 70
		t.y1 = -400
		t.w1 = 200
		t.h1 = 200/2
		
		t.hp = 100
		
		t.shape1 = shapes.newPolygonShape(t.x1,t.y1,t.x1+t.w1,t.y1,t.x1+t.w1,t.y1+t.h1,t.x1,t.y1+t.h1)
		
		t.x2 = t.x1 + 100
		t.y2 = t.y1 - 75
		t.w2 = 180
		t.h2 = 100
		
		t.shape2 = shapes.newPolygonShape(t.x2,t.y2,t.x2+t.w2,t.y2,t.x2+t.w2,t.y2+t.h2,t.x2,t.y2+t.h2)
		
		t.y1Def = 394
		t.y2Def = 394 - 75
		
		t.var1 = 0
		t.var2 = 0
		t.fightStage = 1
		t.fightPattern = 2
		t.frame1 = 9
		t.frameT = 0
		t.sprOff1X = 0
		t.sprOff1Y = 100
		t.scale1X = 1
		t.scale1Y = -1
		t.dir = "r"
		
		t.jumpT = 0
		t.jumpTM = love.math.random(90,150)
		t.isJump = true
		t.jumpSpd = 12
		t.jumpDecS = 0.2
		t.defJumpSpd = t.jumpSpd
		t.rumbleSwitch = 1
		
		t.walkingTicks = 0
		t.walkingTicksMax = 400--love.math.random(700,1000)
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