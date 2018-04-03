shapes = require "libs.HC.shapes"
require "world_collisions"
require "libs.camera"
require "libs.message"
require "players"
require "levels"
require "enemies"

function love.load()
	
	maxW, maxH = 800, 240
	
	message.load()
	
	gamestate = "choose"
	
	charNUM = 1
	
	charNUM2 = 2
	
	keybind = 0
	
	playerbind = 0
	
	pause = false
	
	gameover1 = false
	
	gameover2 = false
	
	particlesSheet = love.graphics.newImage("/assets/particles.png")
	
	particlesT = {
		love.graphics.newQuad(0,0,70,25,particlesSheet:getWidth(),particlesSheet:getHeight()),
		love.graphics.newQuad(72,0,29,30,particlesSheet:getWidth(),particlesSheet:getHeight()),
		love.graphics.newQuad(102,0,21,22,particlesSheet:getWidth(),particlesSheet:getHeight()),
		love.graphics.newQuad(125,0,21,22,particlesSheet:getWidth(),particlesSheet:getHeight()),
		love.graphics.newQuad(102,23,21,22,particlesSheet:getWidth(),particlesSheet:getHeight()),
		love.graphics.newQuad(125,23,21,22,particlesSheet:getWidth(),particlesSheet:getHeight()),
	}
	
	char_spr = {
		love.graphics.newImage("/assets/char1.png"),
		love.graphics.newImage("/assets/char2.png"),
	}
	
	blank_char_spr = love.graphics.newImage("/assets/blank_icon.png")
	
	title1 = love.graphics.newImage("/assets/TITLE1.png")
	
	playerTWO = true
	
	controls1 = {"right","left","up","down","z","x"}
	
	controls2 = {"d","a","w","s","f","g"}
	
	players_load()
	
	misc_spr = {
		love.graphics.newQuad(237,0,70,87,players[1].spr:getWidth(),players[1].spr:getHeight()),
	}
	
	enemySprite_1 = love.graphics.newImage("/assets/enemies.png")
	
	enemiesFrames = {
		love.graphics.newQuad(0,0,66,81,enemySprite_1:getWidth(),enemySprite_1:getHeight()),
		love.graphics.newQuad(66,0,66,81,enemySprite_1:getWidth(),enemySprite_1:getHeight()),
		love.graphics.newQuad(132,0,37,110,enemySprite_1:getWidth(),enemySprite_1:getHeight()),
		love.graphics.newQuad(169,0,96,88,enemySprite_1:getWidth(),enemySprite_1:getHeight()),
		love.graphics.newQuad(0,106,265,75,enemySprite_1:getWidth(),enemySprite_1:getHeight()),
	}
	
	bossSprites = love.graphics.newImage("/assets/boss_spr.png")
	
	bossSpritesGroups = {
		{
			love.graphics.newQuad(0,0,153,134,bossSprites:getWidth(),bossSprites:getHeight()),
			love.graphics.newQuad(298,1,142,142,bossSprites:getWidth(),bossSprites:getHeight()),
			love.graphics.newQuad(154,1,142,142,bossSprites:getWidth(),bossSprites:getHeight()),
		},
	}
	
	world_particles = {}
	
	showcolls = false
	
	resetWorld = false
	
	loadNewLevel = false
	
	scoreP1 = 0
	
	scoreP2 = 0
	
	levelNum = 1
	
	level_load(levelNum)
	
	love.graphics.setBackgroundColor(100,100,255)
	
	love.graphics.setLineWidth(2)
	
	deathY = maxH
	
	deathX1 = love.math.random(10,maxW-50)
	
	deathX2 = love.math.random(10,maxW-50)
	
	sx = maxW/800
	sy = maxH/600
end

function love.draw()

	love.graphics.scale(sx,sy)

	-- love.graphics.print(players[1].x.." | "..players[1].y)

	if gamestate == "game" then
		game_draw()
	end
	if gamestate == "choose" then
		choose_draw()
	end
	if gamestate == "changeControls" then
	
		local x, y = -105,035
	
		if keybind == 1 and playerbind == 1 then
			x = 150
			y = 130
		end
		
		if keybind == 2 and playerbind == 1 then
			x = 150
			y = 170
		end
		
		if keybind == 3 and playerbind == 1 then
			x = 150
			y = 210
		end
		
		if keybind == 4 and playerbind == 1 then
			x = 150
			y = 250
		end
		
		if keybind == 5 and playerbind == 1 then
			x = 150
			y = 290
		end
		
		if keybind == 6 and playerbind == 1 then
			x = 150
			y = 330
		end
		
		if keybind == 1 and playerbind == 2 then
			x = 550
			y = 130
		end
		
		if keybind == 2 and playerbind == 2 then
			x = 550
			y = 170
		end
		
		if keybind == 3 and playerbind == 2 then
			x = 550
			y = 210
		end
		
		if keybind == 4 and playerbind == 2 then
			x = 550
			y = 250
		end
	
		if keybind == 5 and playerbind == 2 then
			x = 550
			y = 290
		end
	
		if keybind == 6 and playerbind == 2 then
			x = 550
			y = 330
		end
	
		if keybind ~= 0 then
			love.graphics.setColor(0,0,0,50)
			love.graphics.rectangle("line",x-10,y+5,100,35)
			love.graphics.setColor(255,255,255)
			love.graphics.rectangle("line",x,y,100,35)
		end
	
		love.graphics.printf("Player 1 Controls:",0,100,maxW/2,"center")
		love.graphics.printf("Right: "..players[1].controls[1],0,140,maxW/2,"center")
		love.graphics.printf("Left: "..players[1].controls[2],0,180,maxW/2,"center")
		love.graphics.printf("Up: "..players[1].controls[3],0,220,maxW/2,"center")
		love.graphics.printf("Down: "..players[1].controls[4],0,260,maxW/2,"center")
		love.graphics.printf("Jump: "..players[1].controls[5],0,300,maxW/2,"center")
		love.graphics.printf("Attack: "..players[1].controls[6],0,340,maxW/2,"center")
		
		love.graphics.printf("Player 2 Controls:",maxW/2,100,maxW/2,"center")
		love.graphics.printf("Right: "..players[2].controls[1],maxW/2,140,maxW/2,"center")
		love.graphics.printf("Left: "..players[2].controls[2],maxW/2,180,maxW/2,"center")
		love.graphics.printf("Up: "..players[2].controls[3],maxW/2,220,maxW/2,"center")
		love.graphics.printf("Down: "..players[2].controls[4],maxW/2,260,maxW/2,"center")
		love.graphics.printf("Jump: "..players[2].controls[5],maxW/2,300,maxW/2,"center")
		love.graphics.printf("Attack: "..players[2].controls[6],maxW/2,340,maxW/2,"center")
		
		love.graphics.setColor(0,0,0,50)
		love.graphics.rectangle("line",maxW/2-50-10,maxH-150+5,100,40)
		love.graphics.printf("back",maxW/2-50-10,maxH-135+5,100,"center")
		
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("line",maxW/2-50,maxH-150,100,40)
		love.graphics.printf("back",maxW/2-50,maxH-135,100,"center")
	elseif gamestate == "gameover" then
	
		love.graphics.setColor(255,255,255)
	
		love.graphics.setColor(0,0,0,50)
		love.graphics.printf("GAME OVER",-10,(maxH/2)-20+5,maxW,"center")
		love.graphics.setColor(255,255,255)
		love.graphics.printf("GAME OVER",0,(maxH/2)-20,maxW,"center")
		
		if deathY > -100 then
			love.graphics.setColor(255,255,255,50)
			
			if playerTWO then
				love.graphics.draw(players[1].spr,players[1].frames[1],deathX1,deathY)
				love.graphics.draw(players[2].spr,players[1].frames[1],deathX2,deathY)
				
				love.graphics.setColor(255,255,0,100)
				
				love.graphics.ellipse("line",deathX1+28,deathY-10,10,5)
				
				love.graphics.ellipse("line",deathX2+28,deathY-10,10,5)
			else
				love.graphics.draw(players[1].spr,players[1].frames[1],deathX1,deathY)
				
				love.graphics.setColor(255,255,0,100)
				
				love.graphics.ellipse("line",deathX1+28,deathY-10,10,5)
			end
			
			deathY = deathY - 5
		end
		
		love.graphics.setColor(255,255,255)
	elseif gamestate == "credits" then
	
		love.graphics.setColor(0,0,0,50)
		love.graphics.printf("Everything made by Joelrodiel",-10,maxH/2-20+5,maxW,"center")
		love.graphics.setColor(255,255,255)
		love.graphics.printf("Everything made by Joelrodiel",0,maxH/2-20,maxW,"center")
	
		love.graphics.setColor(0,0,0,50)
		love.graphics.rectangle("line",maxW/2-50-10,maxH-150+5,100,40)
		love.graphics.printf("back",maxW/2-50-10,maxH-135+5,100,"center")
	
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("line",maxW/2-50,maxH-150,100,40)
		love.graphics.printf("back",maxW/2-50,maxH-135,100,"center")
	end
end

function choose_draw()

	love.graphics.setColor(0,0,0,50)
	love.graphics.draw(title1,maxW/2-205-8,105)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(title1,maxW/2-205,100)

	local x, y = maxW/4-40, maxH/2-10

	if charNUM == 1 then
		x, y = maxW/4-40, maxH/2-10
	elseif charNUM == 2 then
		x, y = maxW/2-40, maxH/2-10
	end
	
	love.graphics.setColor(0,0,0,80)
	love.graphics.rectangle("line",x-10,y+5,85,85)
	love.graphics.setColor(0,0,0,80)
	love.graphics.draw(char_spr[1],players[1].frames[1],maxW/4-30-10,maxH/2-8+3)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(char_spr[1],players[1].frames[1],maxW/4-30,maxH/2-8)
	love.graphics.setColor(0,0,0,80)
	love.graphics.draw(char_spr[2],players[1].frames[1],maxW/2-30-10,maxH/2-8+3)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(char_spr[2],players[1].frames[1],maxW/2-30,maxH/2-8)
	
	love.graphics.setColor(0,0,0,80)
	love.graphics.draw(blank_char_spr,maxW-(maxW/4)-45-10,maxH/2-19+3,0,1.3)
	love.graphics.setColor(255,255,255)
	love.graphics.draw(blank_char_spr,maxW-(maxW/4)-45,maxH/2-19,0,1.3)

	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("line",x,y,85,85)

	love.graphics.setColor(0,0,0,80)
	love.graphics.printf("Joel",maxW/4-40-10,maxH/2+80+5,85,"center")
	love.graphics.printf("Nasser",maxW/2-40-10,maxH/2+80+5,85,"center")
	love.graphics.printf("???",maxW-(maxW/4)-40-10,maxH/2+80+5,85,"center")
	
	love.graphics.setColor(255,255,255)
	love.graphics.printf("Joel",maxW/4-40,maxH/2+80,85,"center")
	love.graphics.printf("Nasser",maxW/2-40,maxH/2+80,85,"center")
	love.graphics.printf("???",maxW-(maxW/4)-40,maxH/2+80,85,"center")
	
	love.graphics.setColor(0,0,0,50)
	love.graphics.rectangle("line",maxW/4-12-10,maxH-110+5,85,40)
	love.graphics.setColor(255,255,255)
	love.graphics.rectangle("line",maxW/4-12,maxH-110,85,40)
	
	if playerTWO then
		love.graphics.setColor(0,0,0,50)
		love.graphics.print("Players: 2",maxW/4-10,maxH-100+5)
		love.graphics.setColor(255,255,255)
		love.graphics.print("Players: 2",maxW/4,maxH-100)
	else
		love.graphics.setColor(0,0,0,50)
		love.graphics.print("Players: 1",maxW/4-10,maxH-100+5)
		love.graphics.setColor(255,255,255)
		love.graphics.print("Players: 1",maxW/4,maxH-100)
	end
	
	love.graphics.setColor(0,0,0,50)
	
	love.graphics.rectangle("line",maxW/2-55-10,maxH-110+5,125,40)
	
	love.graphics.print("Change controls",maxW/2-45-10,maxH-100+5)
	
	love.graphics.rectangle("line",maxW-(maxW/4)-60-10,maxH-110+5,90,40)
	
	love.graphics.print("Credits",maxW-(maxW/4)-37-10,maxH-100+5)
	
	love.graphics.setColor(255,255,255)
	
	love.graphics.rectangle("line",maxW/2-55,maxH-110,125,40)
	
	love.graphics.print("Change controls",maxW/2-45,maxH-100)
	
	love.graphics.rectangle("line",maxW-(maxW/4)-60,maxH-110,90,40)
	
	love.graphics.print("Credits",maxW-(maxW/4)-37,maxH-100)
end

function game_draw()
	
	camera:set()
	
	if levelNum == 4 then
		love.graphics.setColor(0,0,0,50)
		love.graphics.printf("HEY YOU FINISHED THE PROTOTYPE!\nHOPE YOU LIKED IT AND UH JUST TALK TO ME ABOUT THINGS THAT CAN BE IMPROVED AND STUFF.\nIT'D BE REAL HELPFUL.\nHAVE A GOOD DAY.",-10,(maxW/2)-200+5,maxW,"center")
		love.graphics.setColor(255,255,255)
		love.graphics.printf("HEY YOU FINISHED THE PROTOTYPE!\nHOPE YOU LIKED IT AND UH JUST TALK TO ME ABOUT THINGS THAT CAN BE IMPROVED AND STUFF.\nIT'D BE REAL HELPFUL.\nHAVE A GOOD DAY.",0,(maxW/2)-200,maxW,"center")
	end
	
	for i, v in ipairs(world_particles) do
		if v.typ == 1 then
			love.graphics.setColor(0,0,0,100)
			love.graphics.rectangle("fill",v.x-10,v.y+5,v.w,v.h)
			love.graphics.setColor(v.color)
			love.graphics.rectangle("fill",v.x,v.y,v.w,v.h)
		end
	end
	
	for i, v in ipairs(world_collisions.entities) do
	
		love.graphics.setColor(255,255,255)
		
		if v.bullets ~= nil then
			for k, b in ipairs(v.bullets) do
				love.graphics.setColor(0,0,0,50)
				love.graphics.rectangle("fill",b.x-10,b.y+5,b.w,b.h)
				love.graphics.setColor(255,255,255)
				love.graphics.rectangle("fill",b.x,b.y,b.w,b.h)
			end
		end
		
		if v.draw then
			if v.class == "enemy" then
			
				love.graphics.setColor(0,0,0,100)
				
				love.graphics.draw(enemySprite_1,enemiesFrames[v.frame],v.x+v.sprOffX-10,v.y+v.sprOffY+5,v.sprRot)
			
				love.graphics.setColor(v.color)
				
				love.graphics.draw(enemySprite_1,enemiesFrames[v.frame],v.x+v.sprOffX,v.y+v.sprOffY,v.sprRot)
				
				if v.showP ~= 0 and v.noticedP then
					love.graphics.setColor(0,0,0,80)
					love.graphics.draw(particlesSheet,particlesT[1],v.x+v.partX-10,v.y+v.partY+5)
					love.graphics.setColor(255,255,255)
					love.graphics.draw(particlesSheet,particlesT[1],v.x+v.partX,v.y+v.partY)
				end
			elseif v.class == "boss" then
				if v.id == 1 then
				
					love.graphics.setColor(0,0,0,100)
					
					love.graphics.draw(bossSprites,bossSpritesGroups[v.id][1],v.x+v.sprOffX-10,v.y+v.sprOffY+8)
				
					love.graphics.setColor(v.color)
					
					love.graphics.draw(bossSprites,bossSpritesGroups[v.id][1],v.x+v.sprOffX,v.y+v.sprOffY)
					
					if v.talk then
					
						love.graphics.setColor(0,0,0,100)
						
						love.graphics.rectangle("fill",camera.x+100-10,100+10,maxW-200,140)
					
						love.graphics.setColor(100,100,100)
					
						love.graphics.rectangle("fill",camera.x+100,100,maxW-200,140)
						
						love.graphics.setColor(255,255,255)
					
						love.graphics.rectangle("line",camera.x+100,100,maxW-200,140)
						
						love.graphics.draw(bossSprites,bossSpritesGroups[1][v.talkF],camera.x+110,110,0,0.85)
						
						message.draw(camera.x+245,110,maxW-370,0,2)
						
						love.graphics.setFont(font1)
						
						if v.stage ~= "death" then
							
							love.graphics.setColor(0,0,0,100)
							
							love.graphics.printf("Press SPACE to skip...",camera.x,250,maxW,"center")
							
						end
					end
				end
			end
		end
		
		love.graphics.setColor(255,255,255)
	end
	
	players_draw()
	
	for i, v in ipairs(world_collisions.colls) do
		if v.class == "floor" or v.class == "coll" then
			if v.draw then
				love.graphics.rectangle("fill",v.x,v.y,v.w,v.h)
			end
		elseif v.class == "endZone" then
			love.graphics.printf("END",v.x,v.y+(v.h/2)-20,v.w,"center")
			love.graphics.rectangle("line",v.x,v.y,v.w,v.h)
		end
		love.graphics.setColor(255,255,255)
	end
	
	for i, v in ipairs(world_particles) do
		if v.typ == 2 then
			love.graphics.setColor(0,0,0,100)
			love.graphics.draw(particlesSheet,particlesT[2],v.x-10,v.y+5)
			love.graphics.setColor(v.color)
			love.graphics.draw(particlesSheet,particlesT[2],v.x,v.y)
		end
		if v.typ == 3 then
		
			local num = 3
			
			if v.dir == "r" then
				num = 3
			elseif v.dir == "l" then
				num = 4
			elseif v.dir == "d" then
				num = 5
			elseif v.dir == "u" then
				num = 6
			end
		
			love.graphics.setColor(0,0,0,100)
		
			love.graphics.draw(particlesSheet,particlesT[num],v.x-3,v.y+8)
		
			love.graphics.setColor(v.color)
			
			love.graphics.draw(particlesSheet,particlesT[num],v.x,v.y)
		end
	end
	
	love.graphics.setColor(255,255,255)
		
	camera:unset()
	
	for i=1, players[1].lives do
		love.graphics.setColor(0,0,0,50)
		love.graphics.draw(players[1].spr,misc_spr[1],(45*i)-40-8,15,0,0.5)
		love.graphics.setColor(255,255,255)
		love.graphics.draw(players[1].spr,misc_spr[1],(45*i)-40,10,0,0.5)
	end
	
	love.graphics.setFont(font2)
	
	love.graphics.setColor(0,0,0,50)
	
	love.graphics.printf("SCORE P1: "..scoreP1,-20,15,maxW,"right")
	
	love.graphics.setColor(255,255,255)
	
	love.graphics.printf("SCORE P1: "..scoreP1,-10,10,maxW,"right")
	
	if playerTWO then
		for i=1, players[2].lives do
			love.graphics.setColor(0,0,0,50)
			love.graphics.draw(players[2].spr,misc_spr[1],(45*i)-40-8,65,0,0.5)
			love.graphics.setColor(255,255,255)
			love.graphics.draw(players[2].spr,misc_spr[1],(45*i)-40,60,0,0.5)
		end
		
		love.graphics.setColor(0,0,0,50)
		
		love.graphics.printf("SCORE P2: "..scoreP2,-20,55,maxW,"right")
		
		love.graphics.setColor(255,255,255)
		
		love.graphics.printf("SCORE P2: "..scoreP2,-10,50,maxW,"right")
	end
	
	love.graphics.setColor(255,255,255,255)
	
	for i, v in ipairs(world_collisions.entities) do
		if v.draw then
			if v.class == "boss" then
				if v.id == 1 then
					if v.stage == "fight" then
						love.graphics.setColor(255,0,0)
					
						love.graphics.rectangle("fill",200,20,maxW-400,18)
						
						love.graphics.setColor(0,255,0)
					
						love.graphics.rectangle("fill",200,20,v.hp/2.5,18)
					end
				end
			end
		end
	end
	
	love.graphics.setColor(255,255,255,255)
	
	love.graphics.setFont(font1)
	
	if pause then
	
		love.graphics.setColor(0,0,0,80)
	
		love.graphics.printf("PAUSED",-8,(maxH/2)-12+3,maxW,"center")
		
		love.graphics.setColor(255,255,255)
		
		love.graphics.printf("PAUSED",0,(maxH/2)-12,maxW,"center")
	end
	
	love.graphics.setColor(255,255,255)
	
	if showcolls then
	
		for i, v in ipairs(world_collisions.colls) do
			love.graphics.print("ID: "..v.id.." Num: "..i.." Class: "..v.class,0,20*i)
		end
		
		love.graphics.printf("Floor ID: "..players[1].floorID,0,0,maxW,"right")
		
		love.graphics.printf("Coll ID: "..players[1].collID,0,20,maxW,"right")
		
		if players[1].falling then
			love.graphics.printf("Player falling: true",0,40,maxW,"right")
		else
			love.graphics.printf("Player falling: false",0,40,maxW,"right")
		end
	
		camera:set()
	
		love.graphics.setColor(255,0,0)
	
		for i, v in ipairs(world_collisions.colls) do
			love.graphics.setColor(255,0,0)
			v.shape:draw("line")
		end
		
		for i, v in ipairs(world_collisions.entities) do
			love.graphics.setColor(255,0,0)
			v.shape:draw("line")
		end
		
		players[1].shape:draw()
		
		if playerTWO then
			players[2].shape:draw("line")
		end
		
		camera:unset()
	end
end

function love.update(dt)

	if gamestate == "game" and pause == false then
		player_update(1)
		
		if playerTWO then
			player_update(2)
		end
		
		if playerTWO then
			if players[1].supaDead and players[2].supaDead then
				gamestate = "gameover"
			end
		end
		
		if levelNum == 4 then
			if #world_collisions.entities == 0 then
				local typ = love.math.random(1,4)
				local x = love.math.random(0,maxW-100)
				world_collisions.newEnemy(x,250,typ)
				local typ = love.math.random(1,4)
				local x = love.math.random(0,maxW-100)
				world_collisions.newEnemy(x,250,typ)
				local typ = love.math.random(1,4)
				local x = love.math.random(0,maxW-100)
				world_collisions.newEnemy(x,250,typ)
				local typ = love.math.random(1,4)
				local x = love.math.random(0,maxW-100)
				world_collisions.newEnemy(x,250,typ)
			end
			players[1].cameraMove = false
		end
		
		enemies_update(dt)
		
		if resetWorld then
			for i=1, #world_collisions.colls do
				table.remove(world_collisions.colls,i)
			end
			for i=1, #world_collisions.entities do
				table.remove(world_collisions.entities,i)
			end
			if #world_collisions.colls == 0 and #world_collisions.entities == 0 then
				players[1].x = 100
				players[1].y = 100
				players[1].shape:moveTo(players[1].x+(players[1].w/2),players[1].y+(players[1].h/2))
				players[1].falling = true
				
				if playerTWO then
					players[2].x = 100
					players[2].y = 100
					players[2].shape:moveTo(players[2].x+(players[2].w/2),players[2].y+(players[2].h/2))
					players[2].falling = true
				end
				
				camera.x = 0
				
				loadNewLevel = true
				resetWorld = false
			end
		end
		
		if loadNewLevel then
			level_load(levelNum)
			loadNewLevel = false
		end
		
		for i, v in ipairs(world_particles) do
			if v.typ == 1 then
				v.y = v.y + v.ySpd
				v.ySpd = v.ySpd + 0.1
				v.x = v.x + v.xSpd
				if v.y > maxW + 10 then
					table.remove(world_particles,i)
				end
			end
			if v.typ == 2 then
				if v.color[4] > 0 then
					v.color[4] = v.color[4] - 50
				else
					table.remove(world_particles,i)
				end
			end
			if v.typ == 3 then
				if v.color[4] > 0 then
					v.color[4] = v.color[4] - 30
				else
					table.remove(world_particles,i)
				end
			end
		end
	end
	
	if gamestate == "gameover" then
		if #world_collisions.colls == 0 and #world_collisions.entities == 0 then
			players[1].x = 100
			players[1].y = 100
			players[1].shape:moveTo(players[1].x+(players[1].w/2),players[1].y+(players[1].h/2))
			players[1].falling = true
			camera.x = 0
			
			resetWorld = false
		else
			for i=1, #world_collisions.colls do
				table.remove(world_collisions.colls,i)
			end
			
			for i=1, #world_collisions.entities do
				table.remove(world_collisions.entities,i)
			end
		end
	end
end

function newBullet(playerN)
	local t = {}
	if players[playerN].faceDir == "r" then
		t.x = players[playerN].x + players[playerN].w + 10
		t.y = players[playerN].y + (players[playerN].h / 2) - 12
	elseif players[playerN].faceDir == "l" then
		t.x = players[playerN].x - 21
		t.y = players[playerN].y + (players[playerN].h / 2) - 12
	elseif players[playerN].faceDir == "u" then
		t.x = players[playerN].x + (players[playerN].w / 2) - 1.5
		t.y = players[playerN].y - 22
	elseif players[playerN].faceDir == "d" then
		t.x = players[playerN].x + (players[playerN].w / 2) - 1.5
		t.y = players[playerN].y + players[playerN].h - 18
	end
	
	t.dir = players[playerN].faceDir
	t.typ = players[playerN].bulletTyp
	
	if t.typ == 1 then
		t.w = 10
		t.h = 10
		t.spd = 15
	end
	if t.typ == 2 then
		t.w = 12
		t.h = 12
		t.spd = 12
	end
	table.insert(players[playerN].bullets,t)
end

function newParticle(x,y,typ,color,var1)
	local t = {}
	if typ == 1 then
		t.typ = 1
		t.x = x
		t.y = y
		t.w = 10
		t.h = 10
		t.ySpd = 5
		t.xSpd = love.math.random(-7,-2)
		if color == nil then
			t.color = {255,255,0,255}
		else
			t.color = color
		end
	end
	if typ == 2 or typ == 3 then
		t.typ = typ
		t.x = x
		t.y = y
		t.w = 30
		t.h = 30
		t.dir = var1
		t.color = {255,255,255,255}
	end
	table.insert(world_particles,t)
end

function love.keypressed(key)

	if gamestate == "game" then
		if pause == false then
			if key == "tab" then
				if showcolls then
					showcolls = false
				else
					showcolls = true
				end
			end
			
			if key == players[1].controls[5] and players[1].move then
				if not players[1].falling then
					if not players[1].isJump then
						players[1].isJump = true
					end
				end
			end
			
			if playerTWO then
				if key == players[2].controls[5] and players[2].move then
					if not players[2].falling then
						if not players[2].isJump then
							players[2].isJump = true
						end
					end
				end
			end
			
			if key == players[1].controls[6] and players[1].move then
				if not players[1].collWithP and players[2].grabbed == false then
					newBullet(1)
					
					local x, y = 0, 0
				
					if players[1].faceDir == "r" then
						x = players[1].x + players[1].w + 10
						y = players[1].y + (players[1].h / 2) - 20
					elseif players[1].faceDir == "l" then
						x = players[1].x - 36
						y = players[1].y + (players[1].h / 2) - 25
					elseif players[1].faceDir == "u" then
						x = players[1].x + (players[1].w / 2) - 15
						y = players[1].y - 40
					elseif players[1].faceDir == "d" then
						x = players[1].x + (players[1].w / 2) - 15
						y = players[1].y + players[1].h - 18
					end
					
					newParticle(x,y,2)
					
				else
					if players[1].collWithP then
						players[2].x = players[1].x
						players[2].y = players[1].y - 80
						players[2].shape:moveTo(players[1].x+20,players[1].y - 60)
						players[2].grabbed = true
					else
						if players[1].faceDir == "r" then
							players[2].propellXV = 1
						elseif players[1].faceDir == "l" then
							players[2].propellXV = -1
							players[2].propellXV2 = 10
						elseif players[1].faceDir == "d" then
							players[2].grabbed = false
							return
						elseif players[1].faceDir == "u" then
							players[2].propellXV2 = 0
						end
						
						players[2].isJump = true
						players[2].propellX = true
						players[2].grabbed = false
					end
				end
			end
			
			if key == players[2].controls[6] and players[2].move and playerTWO then
				if not players[2].collWithP and players[1].grabbed == false then
					newBullet(2)
					
					local x, y = 0, 0
				
					if players[2].faceDir == "r" then
						x = players[2].x + players[2].w + 10
						y = players[2].y + (players[2].h / 2) - 20
					elseif players[2].faceDir == "l" then
						x = players[2].x - 36
						y = players[2].y + (players[2].h / 2) - 25
					elseif players[2].faceDir == "u" then
						x = players[2].x + (players[2].w / 2) - 15
						y = players[2].y - 40
					elseif players[2].faceDir == "d" then
						x = players[2].x + (players[2].w / 2) - 15
						y = players[2].y + players[2].h - 18
					end
					
					newParticle(x,y,2)
				else
					if players[2].collWithP then
						players[1].x = players[2].x
						players[1].y = players[2].y - 80
						players[1].shape:moveTo(players[2].x+20,players[2].y - 60)
						players[1].grabbed = true
					else
						if players[2].faceDir == "r" then
							players[1].propellXV = 1
						elseif players[2].faceDir == "l" then
							players[1].propellXV = -1
							players[1].propellXV2 = 10
						elseif players[2].faceDir == "d" then
							players[1].grabbed = false
							return
						elseif players[2].faceDir == "u" then
							players[1].propellXV2 = 0
						end
						
						players[1].isJump = true
						players[1].propellX = true
						players[1].grabbed = false
					end
				end
			end
		end
		if key == "return" then
			if pause then
				pause = false
			else
				pause = true
			end
		end
		if key == "space" then
			for i, v in ipairs(world_collisions.entities) do
				if v.class == "boss" then
					if v.stage == "intro" then
						message.close()
						v.talk = false
						v.stage = "fight"
					end
				end
			end
		end
	end
	
	if gamestate == "choose" then
		if key == "right" then
			charNUM = charNUM + 1
			
			if charNUM > 2 then
				charNUM = 1
			end
		end
		if key == "left" then
			charNUM = charNUM - 1
			
			if charNUM < 1 then
				charNUM = 2
			end
		end
		if key == "space" or key == "return" then
		
			if charNUM == 1 then
				charNUM2 = 2
			else
				charNUM2 = 1
			end
		
			players_load()
			gamestate = "game"
		end
		if key == "2" then
			if playerTWO then
				playerTWO = false
			else
				playerTWO = true
			end
		end
		
	end
	
	if gamestate == "changeControls" then
		if keybind ~= 0 then
			players[playerbind].controls[keybind] = key
			if playerbind == 1 then
				controls1[keybind] = key
			else
				controls2[keybind] = key
			end
			playerbind = 0
			keybind = 0
		end
	end
	
	if gamestate == "gameover" then
		if key == "return" or key == "space" then
			love.load()
		end
	end
	
	if key == "escape" then
		love.event.quit()
	end
end

function love.mousepressed(x,y)
	if gamestate == "choose" then
		if x > maxW/4-40 and x < (maxW/4-40) + 85 and y > maxH/2-10 and y < (maxH/2-10) + 85 then
			if charNUM == 1 then
				charNUM2 = 2
				players_load()
				gamestate = "game"
			else
				charNUM = 1
			end
		end
		if x > maxW/2-40 and x < (maxW/2-40) + 85 and y > maxH/2-10 and y < (maxH/2-10) + 85 then
			if charNUM == 2 then
				charNUM2 = 1
				players_load()
				gamestate = "game"
			else
				charNUM = 2
			end
		end
		
		if x > maxW/4-12 and x < maxW/4-12 + 85 and y > maxH-110 and y < maxH-110 + 40 then
			if playerTWO then
				playerTWO = false
			else
				playerTWO = true
			end
		end
		
		if x > maxW/2-55 and x < maxW/2-55 + 125 and y > maxH-110 and y < maxH-110 + 40 then
			gamestate = "changeControls"
		end
		
		-- maxW-(maxW/4)-60,maxH-110,90,40)
		
		if x > maxW-(maxW/4)-60 and x < maxW-(maxW/4)-60 + 90 and y > maxH-110 and y < maxH-110 + 40 then
			gamestate = "credits"
		end
	end

	if gamestate == "credits" then
		if x > maxW/2-50 and x < maxW/2-50 + 100 and y > maxH-150 and y < maxH-150 + 40 then
			gamestate = "choose"
		end
	end
	
	if gamestate == "changeControls" then
		if x > maxW/2-50 and x < maxW/2-50 + 100 and y > maxH-150 and y < maxH-150 + 40 then
			gamestate = "choose"
		end
		
		if x > 150 and x < 250 and y > 130 and y < 165 then
			playerbind = 1
			keybind = 1
		elseif x > 150 and x < 250 and y > 170 and y < 170 + 35 then
			playerbind = 1
			keybind = 2
		elseif x > 150 and x < 250 and y > 210 and y < 210 + 35 then
			playerbind = 1
			keybind = 3
		elseif x > 150 and x < 250 and y > 250 and y < 250 + 35 then
			playerbind = 1
			keybind = 4
		elseif x > 150 and x < 250 and y > 290 and y < 290 + 35 then
			playerbind = 1
			keybind = 5
		elseif x > 150 and x < 250 and y > 330 and y < 330 + 35 then
			playerbind = 1
			keybind = 6
		elseif x > 550 and x < 650 and y > 130 and y < 130 + 35 then
			playerbind = 2
			keybind = 1
		elseif x > 550 and x < 650 and y > 170 and y < 170 + 35 then
			playerbind = 2
			keybind = 2
		elseif x > 550 and x < 650 and y > 210 and y < 210 + 35 then
			playerbind = 2
			keybind = 3
		elseif x > 550 and x < 650 and y > 250 and y < 250 + 35 then
			playerbind = 2
			keybind = 4
		elseif x > 550 and x < 650 and y > 290 and y < 290 + 35 then
			playerbind = 2
			keybind = 5
		elseif x > 550 and x < 650 and y > 330 and y < 330 + 35 then
			playerbind = 2
			keybind = 6
		else
			keybind = 0
			playerbind = 0
		end
	end
end

function love.focus(f)
	if not f then
		pause = true
	end
end
	
function checkCollision(a, b)
    local a_left = a.x
    local a_right = a.x + a.w
    local a_top = a.y
    local a_bottom = a.y + a.h

    local b_left = b.x
    local b_right = b.x + b.w
    local b_top = b.y
    local b_bottom = b.y + b.h

    if a_right > b_left and
    a_left < b_right and
    a_bottom > b_top and
    a_top < b_bottom then
        return true
    else
        return false
    end
end