function players_load()
	players = {
		{
			x = 100,
			y = 100,
			w = 35,
			h = 60,
			spr = char_spr[charNUM],
			lives = 10,
			controls = controls1,
			sprXOffset = -10,
			sprYOffset = -20,
			move = true,
			opacity = 255,
			frameN = 1,
			moveSpd = 5,
			ySpd = 3,
			falling = true,
			isJump = false,
			jumpSpd = 14,
			jumpDecS = 0.6,
			floorID = 0,
			collID = 0,
			bullets = {},
			bulletTyp = 1,
			bulletTimr = 0,
			bulletMaxT = 8,
			shooting = false,
			faceDir = "r",
			cameraMove = true,
			lastFaceDir = "",
			deadTimr = 0,
			dead = false,
			supaDead = false,
			collWithP = false,
			grabbed = false,
			propellX = false,
			propellXV = 1,
			propellXV2 = 18,
		},
		{
			x = 50,
			y = 100,
			w = 35,
			h = 60,
			spr = char_spr[charNUM2],
			lives = 10,
			controls = controls2,
			sprXOffset = -10,
			sprYOffset = -10,
			move = true,
			opacity = 255,
			frameN = 1,
			moveSpd = 5,
			ySpd = 3,
			falling = true,
			isJump = false,
			jumpSpd = 14,
			jumpDecS = 0.6,
			floorID = 0,
			collID = 0,
			bullets = {},
			bulletTyp = 1,
			bulletTimr = 0,
			bulletMaxT = 8,
			shooting = false,
			faceDir = "r",
			lastFaceDir = "",
			deadTimr = 0,
			dead = false,
			cameraMove = true,
			supaDead = false,
			collWithP = false,
			grabbed = false,
			propellX = false,
			propellXV = 1,
			propellXV2 = 18,
		}
	}
	
	players[1].shape = shapes.newPolygonShape(players[1].x,players[1].y,players[1].x+players[1].w,players[1].y,players[1].x+players[1].w,players[1].y+players[1].h,players[1].x,players[1].y+players[1].h)
	players[1].defYSpd = players[1].ySpd
	players[1].defJumpSpd = players[1].jumpSpd
	players[1].spawnX = players[1].x
	players[1].spawnY = players[1].y
	players[1].frames = {
		love.graphics.newQuad(0,5,67,82,players[1].spr:getWidth(),players[1].spr:getHeight()),
		love.graphics.newQuad(70,0,45,87,players[1].spr:getWidth(),players[1].spr:getHeight()),
		love.graphics.newQuad(118,0,46,87,players[1].spr:getWidth(),players[1].spr:getHeight()),
		love.graphics.newQuad(167,0,67,87,players[1].spr:getWidth(),players[1].spr:getHeight()),
		love.graphics.newQuad(0,90,95,45,players[1].spr:getWidth(),players[1].spr:getHeight()),
		love.graphics.newQuad(99,90,47,58,players[1].spr:getWidth(),players[1].spr:getHeight()),
		love.graphics.newQuad(149,90,47,58,players[1].spr:getWidth(),players[1].spr:getHeight()),
		love.graphics.newQuad(198,90,61,86,players[1].spr:getWidth(),players[1].spr:getHeight()),
		love.graphics.newQuad(262,90,58,86,players[1].spr:getWidth(),players[1].spr:getHeight()),
		love.graphics.newQuad(0,180,122,122,players[1].spr:getWidth(),players[1].spr:getHeight()),
		love.graphics.newQuad(124,180,122,122,players[1].spr:getWidth(),players[1].spr:getHeight()),
	}
	players[1].propellXV2DEF = players[1].propellXV2
	
	if charNUM == 1 then
		players[1].bulletTyp = 1
		players[1].bulletMaxT = 6
	elseif charNUM == 2 then
		players[1].bulletTyp = 2
		players[1].bulletMaxT = 12
	end
	
	players[2].frames = {
		love.graphics.newQuad(0,5,67,82,players[2].spr:getWidth(),players[2].spr:getHeight()),
		love.graphics.newQuad(70,0,45,87,players[2].spr:getWidth(),players[2].spr:getHeight()),
		love.graphics.newQuad(118,0,46,87,players[2].spr:getWidth(),players[2].spr:getHeight()),
		love.graphics.newQuad(167,0,67,87,players[2].spr:getWidth(),players[2].spr:getHeight()),
		love.graphics.newQuad(0,90,95,38,players[2].spr:getWidth(),players[2].spr:getHeight()),
		love.graphics.newQuad(99,90,47,58,players[2].spr:getWidth(),players[2].spr:getHeight()),
		love.graphics.newQuad(149,90,47,58,players[2].spr:getWidth(),players[2].spr:getHeight()),
		love.graphics.newQuad(195,90,61,87,players[2].spr:getWidth(),players[2].spr:getHeight()),
		love.graphics.newQuad(256,90,61,87,players[2].spr:getWidth(),players[2].spr:getHeight()),
	}
	
	if playerTWO then
		
		players[2].shape = shapes.newPolygonShape(players[2].x,players[2].y,players[2].x+players[2].w,players[2].y,players[2].x+players[2].w,players[2].y+players[2].h,players[2].x,players[2].y+players[2].h)
		players[2].defYSpd = players[2].ySpd
		players[2].defJumpSpd = players[2].jumpSpd
		players[2].spawnX = players[2].x
		players[2].spawnY = players[2].y
		
		players[2].propellXV2DEF = players[2].propellXV2
		
		if charNUM2 == 1 then
			players[2].bulletTyp = 1
			players[2].bulletMaxT = 6
		elseif charNUM2 == 2 then
			players[2].bulletTyp = 2
			players[2].bulletMaxT = 12
		end
	end
end

function players_draw()

	love.graphics.setColor(0,0,0,100)
	
	love.graphics.draw(players[1].spr,players[1].frames[players[1].frameN],players[1].x+players[1].sprXOffset-10,players[1].y+players[1].sprYOffset+5)

	love.graphics.setColor(255,255,255,players[1].opacity)
	
	love.graphics.draw(players[1].spr,players[1].frames[players[1].frameN],players[1].x+players[1].sprXOffset,players[1].y+players[1].sprYOffset)
	
	if playerTWO then
	
		love.graphics.setColor(0,0,0,100)
		
		love.graphics.draw(players[2].spr,players[2].frames[players[2].frameN],players[2].x+players[2].sprXOffset-10,players[2].y+players[2].sprYOffset+5)
	
		love.graphics.setColor(0,0,0,100)
		
		love.graphics.print("P1",players[1].x+15-5,players[1].y-50+3)
		
		love.graphics.print("P2",players[2].x+15-5,players[2].y-50+3)
	
		love.graphics.setColor(255,255,255,255)
	
		love.graphics.print("P1",players[1].x+15,players[1].y-50)
		
		love.graphics.print("P2",players[2].x+15,players[2].y-50)
	
		love.graphics.setColor(255,255,255,players[2].opacity)
		
		love.graphics.draw(players[2].spr,players[2].frames[players[2].frameN],players[2].x+players[2].sprXOffset,players[2].y+players[2].sprYOffset)
	end
	
	love.graphics.setColor(255,255,255,255)
	
	for i, v in ipairs(players[1].bullets) do
		love.graphics.setColor(0,0,0,100)
		love.graphics.rectangle("fill",v.x-10,v.y+5,v.w,v.h)
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",v.x,v.y,v.w,v.h)
	end
	
	for i, v in ipairs(players[2].bullets) do
		love.graphics.setColor(0,0,0,100)
		love.graphics.rectangle("fill",v.x-10,v.y+5,v.w,v.h)
		love.graphics.setColor(255,255,255)
		love.graphics.rectangle("fill",v.x,v.y,v.w,v.h)
	end
	
end

function player_update(playerN)

	if playerN == 2 then
		if players[playerN].x + players[playerN].w < camera.x + 20 then
			players[playerN].x = players[playerN].x + players[playerN].moveSpd
			players[playerN].shape:move(players[playerN].moveSpd,0)
			
			for i, v in ipairs(world_collisions.colls) do
		
				local colls, sx, sy = players[playerN].shape:collidesWith(v.shape)
				
				if colls then
					if v.class == "coll" and sx ~= 0 then
						players[2].dead = true
						players[playerN].x = players[playerN].spawnX + camera.x
						players[playerN].y = players[playerN].spawnY + camera.y
						players[playerN].shape:moveTo(players[playerN].x+(players[playerN].w/2),players[playerN].y+(players[playerN].h/2))
					end
				end
			end
		end
		if players[1].supaDead then
			if players[2].shape:collidesWith(players[1].shape) then
				players[2].collWithP = true
			else
				players[2].collWithP = false
			end
		end
	elseif playerN == 1 then
		if players[2].supaDead then
			if players[1].shape:collidesWith(players[2].shape) then
				players[1].collWithP = true
			else
				players[1].collWithP = false
			end
			if players[1].cameraMove == false then
				if players[2].x > camera.x + maxW then
					players[2].x = players[2].x - players[2].propellXV2
				end
			end
		end
	end
	
	if players[playerN].supaDead then
		if playerN == 1 then
			if players[playerN].x + players[playerN].w < camera.x + 20 then
				players[playerN].x = players[playerN].x + players[playerN].moveSpd
				players[playerN].shape:move(players[playerN].moveSpd,0)
			end
			if players[playerN].y > maxH then
				players[playerN].x = players[playerN].spawnX + camera.x
				players[playerN].y = players[playerN].spawnY + camera.y
				players[playerN].shape:moveTo(players[playerN].x+(players[playerN].w/2),players[playerN].y+(players[playerN].h/2))
			end
			for i, v in ipairs(world_collisions.colls) do
		
				local colls, sx, sy = players[playerN].shape:collidesWith(v.shape)
				
				if colls then
					if v.class == "coll" and sx ~= 0 then
						players[2].dead = true
						players[playerN].x = players[playerN].spawnX + camera.x
						players[playerN].y = players[playerN].spawnY + camera.y
						players[playerN].shape:moveTo(players[playerN].x+(players[playerN].w/2),players[playerN].y+(players[playerN].h/2))
					end
				end
			end
		end
		if playerN == 2 then
			if players[playerN].y > maxH then
				players[playerN].x = players[playerN].spawnX + camera.x
				players[playerN].y = players[playerN].spawnY + camera.y
				players[playerN].shape:moveTo(players[playerN].x+(players[playerN].w/2),players[playerN].y+(players[playerN].h/2))
			end
		end
	end

	if players[playerN].move then
		if love.keyboard.isDown(players[playerN].controls[1]) and players[playerN].x + players[playerN].w < camera.x + maxW then
			if playerN == 1 then
				players[playerN].x = players[playerN].x + players[playerN].moveSpd
				players[playerN].shape:move(players[playerN].moveSpd,0)
				
				if not players[playerN].shooting then
					players[playerN].faceDir = "r"
				end
				
				if players[playerN].x + players[playerN].w > camera.x + maxW / 2 and players[playerN].cameraMove and playerN == 1 then
					if lvlCameraEnd then
						camera.x = camera.x + players[playerN].moveSpd
					else
						if camera.x + maxW < lvlCameraEndV then
							camera.x = camera.x + players[playerN].moveSpd
						end
					end
				end
				
				if players[2].grabbed then
					players[2].x = players[2].x + players[2].moveSpd
					players[2].shape:move(players[2].moveSpd,0)
				end
			elseif playerN == 2 then
				if players[playerN].x + players[playerN].w < camera.x + maxW then
					players[playerN].x = players[playerN].x + players[playerN].moveSpd
					players[playerN].shape:move(players[playerN].moveSpd,0)
					
					if not players[playerN].shooting then
						players[playerN].faceDir = "r"
					end
				end
				
				if players[1].supaDead then
					if players[playerN].x + players[playerN].w > camera.x + maxW / 2 and players[playerN].cameraMove then
						camera.x = camera.x + players[playerN].moveSpd
					end
				end
				
				if players[1].grabbed then
					players[1].x = players[1].x + players[1].moveSpd
					players[1].shape:move(players[1].moveSpd,0)
				end
			end
		elseif love.keyboard.isDown(players[playerN].controls[2]) and players[playerN].x > camera.x then
			players[playerN].x = players[playerN].x - players[playerN].moveSpd
			players[playerN].shape:move(players[playerN].moveSpd * -1,0)
			
			if not players[playerN].shooting then
				players[playerN].faceDir = "l"
			end
			
			if players[2].grabbed then
				players[2].x = players[2].x - players[2].moveSpd
				players[2].shape:move(players[2].moveSpd*-1,0)
			end
			
			if players[1].grabbed then
				players[1].x = players[1].x - players[1].moveSpd
				players[1].shape:move(players[1].moveSpd*-1,0)
			end
			
			if levelNum == 4 then
				if camera.x > 0 and players[playerN].cameraMove and players[1].x < camera.x + (maxW/2) then
					camera.x = camera.x - players[playerN].moveSpd
				end
			end
		end
	end
	
	if players[playerN].y > maxH then
		players[1].cameraMove = false
		players[playerN].falling = true
		if players[playerN].y > maxH + 1000 then
			players[playerN].dead = true
		end
		if players[1].grabbed then
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
		
		if players[2].grabbed then
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
	
	if players[playerN].move then
		if love.keyboard.isDown(players[playerN].controls[3]) then
			if players[playerN].faceDir ~= "u" then
				players[playerN].lastFaceDir = players[playerN].faceDir
			end
			
			players[playerN].faceDir = "u"
		else
			if players[playerN].faceDir == "u" then
				players[playerN].faceDir = players[playerN].lastFaceDir
			end
		end
		if love.keyboard.isDown(players[playerN].controls[4]) then
			if players[playerN].isJump or players[playerN].falling then
			
				if players[playerN].faceDir ~= "d" then
					players[playerN].lastFaceDir = players[playerN].faceDir
				end
			
				players[playerN].faceDir = "d"
			else
				if players[playerN].faceDir == "d" then
					players[playerN].faceDir = players[playerN].faceDir
				end
			end
		end
	end
	
	for i, v in ipairs(world_collisions.entities) do
	
		local colls, sx, sy = players[playerN].shape:collidesWith(v.shape)
	
		if colls then
			if v.class == "enemy" then
				if v.typ == 1 or v.typ == 3 then
					if not players[playerN].supaDead then
						local speed = 0
							
						if players[playerN].faceDir == "r" then
							speed = players[playerN].moveSpd * -1
						elseif players[playerN].faceDir == "l" then
							speed = players[playerN].moveSpd
						end
					
						players[playerN].x = players[playerN].x + sx + speed
						
						if players[2].grabbed then
							players[2].x = players[2].x + sx + speed
							players[2].shape:move(sx + speed,0)
						end
						
						if playerN == 1 and players[1].cameraMove and sx > 0 and speed > 0 and players[1].x > camera.x + maxW / 2 and players[playerN].supaDead == false then
							camera.x = camera.x + sx + speed
						end
						
						players[playerN].shape:move(sx + speed,0)
						
					end
				elseif v.typ == 2 or v.typ == 5 then
					if players[playerN].dead == false and players[playerN].deadTimr < 1 then
						players[playerN].dead = true
						if players[playerN].isJump == false then
							players[playerN].isJump = true
						end
						v.active = false
						v.frame = 4
					end
				elseif v.typ == 3 then
					players[1].cameraMove = false
				end
			elseif v.class == "bossTrigger" then
				if v.id == 1 then
					if playerTWO then
						if players[1].supaDead then
							players[2].cameraMove = false
							world_collisions.newBoss(v.id,players[1].x-30,600)
							
							table.remove(world_collisions.entities,i)
						else
							if playerN == 1 then
								players[1].cameraMove = false
								world_collisions.newBoss(v.id,players[1].x-30,600)
								
								table.remove(world_collisions.entities,i)
							end
						end
					else
						players[1].cameraMove = false
						world_collisions.newBoss(v.id,players[1].x-30,600)
						
						table.remove(world_collisions.entities,i)
					end
				end
				if v.id == 2 then
					if playerTWO then
						if players[1].supaDead then
							players[2].cameraMove = false
						else
							if playerN == 1 then
								players[1].cameraMove = false
							end
						end
					end
					
					if playerN == 1 then
						for i, v in ipairs(world_collisions.entities) do
							if v.class == "boss" and v.id == 2 then
								if v.stage == "wait" then
									v.stage = "reveal1" -- "start"
									-- v.talk = true
								end
							end
						end
					
					-- players[1].move = false
					
					-- players[1].cameraMove = false
					
					end
					
					if playerTWO then
						players[2].move = false
					end
						
					if playerN == 1 then
						table.remove(world_collisions.entities,i)
					end
				end
			elseif v.class == "boss" then
				if v.id == 1 then
					if players[playerN].dead == false and players[playerN].deadTimr < 1 and v.stage == "fight" then
						players[playerN].dead = true
						if players[playerN].isJump == false then
							players[playerN].isJump = true
						end
						v.active = false
						v.frame = 4
					end
				end
			end
		end
		
		if v.class == "boss" and v.id == 3 then
			local colls1, sx1, sy1 = players[playerN].shape:collidesWith(v.shape1)
			local colls2, sx2, sy2 = players[playerN].shape:collidesWith(v.shape2)
			
			if colls1 or colls2 then
				if not players[playerN].dead then
					players[playerN].dead = true
					if players[playerN].isJump == false then
						players[playerN].isJump = true
					end
				end
			end
		end
	end
	
	for i, v in ipairs(world_collisions.colls) do
		
		local colls, sx, sy = players[playerN].shape:collidesWith(v.shape)
		
		if colls then
			if v.class == "floor" then
				if players[playerN].falling then
				
					local speed = 0
				
					if players[playerN].faceDir == "r" then
						speed = players[playerN].moveSpd * -1
					elseif players[playerN].faceDir == "l" then
						speed = players[playerN].moveSpd
					end
					
					if players[playerN].faceDir == "d" then
						players[playerN].faceDir = players[playerN].lastFaceDir
					end
					
					players[playerN].y = players[playerN].y + sy
					players[playerN].shape:move(sx,sy)
					players[playerN].ySpd = players[playerN].defYSpd
					players[playerN].floorID = v.id
					players[playerN].falling = false
					
					if players[2].grabbed then
						players[2].x = players[2].x + sx
						players[2].shape:move(sx,0)
					end
					
					sfx_sounds[3]:play()
				else
					if players[playerN].y + players[playerN].h > v.y + players[playerN].ySpd and players[playerN].collID == 0 then
					
						local speed = 0
					
						if players[playerN].faceDir == "r" or players[playerN].lastFaceDir == "r" then
							speed = players[playerN].moveSpd * -1
						elseif players[playerN].faceDir == "l" or players[playerN].lastFaceDir == "r" then
							speed = players[playerN].moveSpd
						end
					
						players[playerN].x = players[playerN].x + sx + speed
						if players[playerN].x + players[playerN].w > maxW / 2 and playerN == 1 and players[1].cameraMove then
							camera.x = camera.x + sx + speed
						end
						players[playerN].shape:move(sx + speed,10)
						players[playerN].y = players[playerN].y + 10
						players[playerN].falling = false
					end
				end
			end
			if v.class == "coll" then
				players[playerN].collID = v.id
				players[playerN].x = players[playerN].x + sx
				players[playerN].shape:move(sx,0)
			else
				players[playerN].collID = 0
			end
			if v.class == "endZone" then
				resetWorld = true
				levelNum = v.lvl
			end
		else
			if v.class == "floor" then
				if players[playerN].falling == false and i == players[playerN].floorID then
					players[playerN].falling = true
					players[playerN].floorID = 0
				end
			end
			if v.class == "coll" then
				if i == players[playerN].collID then
					players[playerN].falling = true
					players[playerN].collID = 0
				end
			end
		end
	end
	
	if players[playerN].isJump then
		players[playerN].falling = false
		players[playerN].y = players[playerN].y - players[playerN].jumpSpd
		players[playerN].shape:move(0,players[playerN].jumpSpd * -1)
		
		if players[2].grabbed then
			players[2].y = players[2].y - players[1].jumpSpd
			players[2].shape:move(0,players[1].jumpSpd * -1)
		end
		
		players[playerN].jumpSpd = players[playerN].jumpSpd - players[playerN].jumpDecS
		if players[playerN].jumpSpd < 0 then
			for i, v in ipairs(world_collisions.colls) do
				if players[playerN].shape:collidesWith(v.shape) then
					if v.class == "floor" then
						players[playerN].falling = true
						players[playerN].jumpSpd = players[playerN].defJumpSpd
						players[playerN].shape:moveTo(players[playerN].x+(players[playerN].w/2),players[playerN].y+(players[playerN].h/2))
						
						if players[2].grabbed then
							players[2].x = players[1].x
							players[2].y = players[1].y - 80
							players[2].shape:moveTo(players[1].x+20,players[1].y - 60)
						end
						
						if players[playerN].faceDir == "d" then
							players[playerN].faceDir = players[playerN].lastFaceDir
						end
						players[playerN].isJump = false
						sfx_sounds[2]:play()
					end
				end
			end
		end
	end
	
	if players[playerN].propellX then
		if players[playerN].propellXV == 1 then
			players[playerN].x = players[playerN].x + players[playerN].propellXV2
			players[playerN].propellXV2 = players[playerN].propellXV2 - 0.5
			players[playerN].shape:move(players[playerN].propellXV2,0)
			
			if players[playerN].propellXV2 < 0 then
				players[playerN].propellX = false
				players[playerN].propellXV2 = players[playerN].propellXV2DEF
			end
		elseif players[playerN].propellXV == -1 then
			players[playerN].x = players[playerN].x - players[playerN].propellXV2
			players[playerN].propellXV2 = players[playerN].propellXV2 - 0.5
			players[playerN].shape:move(players[playerN].propellXV2*-1,0)
			
			if players[playerN].propellXV2 < 0 then
				players[playerN].propellX = false
				players[playerN].propellXV2 = players[playerN].propellXV2DEF
			end
		end
	end
	
	if players[playerN].falling and players[playerN].grabbed == false then
		players[playerN].y = players[playerN].y + players[playerN].ySpd
		players[playerN].shape:move(0,players[playerN].ySpd)
		players[playerN].ySpd = players[playerN].ySpd + 0.3
		
		if players[2].grabbed then
			players[2].y = players[2].y + players[1].ySpd
			players[2].shape:move(0,players[1].ySpd)
		end
		if players[1].grabbed then
			players[1].y = players[1].y + players[1].ySpd
			players[1].shape:move(0,players[2].ySpd)
		end
	end
	
	if love.keyboard.isDown(players[playerN].controls[6]) and players[playerN].move then
		if players[2].grabbed or players[1].grabbed then
			
		else
			players[playerN].shooting = true
			players[playerN].bulletTimr = players[playerN].bulletTimr + 1
			
			if players[playerN].bulletTimr > players[playerN].bulletMaxT then
				newBullet(playerN)
				
				local x, y = 0, 0
				
				if players[playerN].faceDir == "r" then
					x = players[playerN].x + players[playerN].w + 10
					y = players[playerN].y + (players[playerN].h / 2) - 20
				elseif players[playerN].faceDir == "l" then
					x = players[playerN].x - 36
					y = players[playerN].y + (players[playerN].h / 2) - 25
				elseif players[playerN].faceDir == "u" then
					x = players[playerN].x + (players[playerN].w / 2) - 15
					y = players[playerN].y - 40
				elseif players[playerN].faceDir == "d" then
					x = players[playerN].x + (players[playerN].w / 2) - 15
					y = players[playerN].y + players[playerN].h - 18
				end
				
				newParticle(x,y,2)
				sfx_sounds[4]:play()
				players[playerN].bulletTimr = 0
			end
		end
	else
		if players[playerN].shooting then
			players[playerN].shooting = false
			players[playerN].bulletTimr = 0
		end
	end
	
	for i, v in ipairs(players[playerN].bullets) do
		if v.dir == "r" then
			v.x = v.x + v.spd
		end
		
		if v.dir == "l" then
			v.x = v.x - v.spd
		end
		
		if v.dir == "u" then
			v.y = v.y - v.spd
		end
		
		if v.dir == "d" then
			v.y = v.y + v.spd
		end
		
		for k, b in ipairs(world_collisions.entities) do
			if b.class == "enemy" then
				if b.typ == 3 then
					local t2 = {}
					t2.x = b.x
					t2.y = b.y - b.h
					t2.w = b.w
					t2.h = b.h
					
					if checkCollision(t2,v) then
						if b.x < camera.x + maxW then
							b.hp = b.hp - 5 -- CHANGE THIS YOU FUCKING ASSHOLE WHO DO YOU THINK YOU ARE YOU PIECE OF SHIT COME ON DUDE FIGHT ME
							b.color[2] = 0
							b.color[3] = 0
							if playerN == 1 then
								scoreP1 = scoreP1 + 7
							end
							if playerN == 2 then
								scoreP2 = scoreP2 + 7
							end
							table.remove(players[playerN].bullets,i)
						end
					end
				else
					if checkCollision(b,v) then
						if b.x < camera.x + maxW then
							b.hp = b.hp - 5 -- CHANGE THIS YOU FUCKING ASSHOLE WHO DO YOU THINK YOU ARE YOU PIECE OF SHIT COME ON DUDE FIGHT ME
							b.color[2] = 0
							b.color[3] = 0
							if playerN == 1 then
								scoreP1 = scoreP1 + 5
							end
							if playerN == 2 then
								scoreP2 = scoreP2 + 5
							end
							table.remove(players[playerN].bullets,i)
						end
					end
				end
			end
			if b.class == "boss" then
				if b.id == 2 then
					local t = {
						x = b.x1,
						y = b.y1,
						w = b.w1,
						h = b.h1,
					}
					
					local d = {
						x = b.x2,
						y = b.y2,
						w = b.w2,
						h = b.h2,
					}
					
					if checkCollision(t,v) and b.stage == "fight" or checkCollision(d,v) and b.stage == "fight" then
						b.hp = b.hp - 5
						b.color[2] = 0
						b.color[3] = 0
						if playerN == 1 then
							scoreP1 = scoreP1 + 10
						end
						if playerN == 2 then
							scoreP2 = scoreP2 + 10
						end
						table.remove(players[playerN].bullets,i)
					end
				else
					if checkCollision(b,v) and b.stage == "fight" then
						b.hp = b.hp - 5
						b.color[2] = 0
						b.color[3] = 0
						if playerN == 1 then
							scoreP1 = scoreP1 + 10
						end
						if playerN == 2 then
							scoreP2 = scoreP2 + 10
						end
						table.remove(players[playerN].bullets,i)
					end
				end
			end
		end
		
		for k, b in ipairs(world_collisions.colls) do
			if checkCollision(b,v) then
				if b.class == "floor" or b.class == "coll" then
					table.remove(players[playerN].bullets,i)
					
					local offsetX, offsetY = -20, -10
					
					if v.dir == "l" then
						offsetX = 10
					end
					
					if v.dir == "d" then
						offsetY = -20
					end
					
					if v.dir == "u" then
						offsetY = 8
					end
					
					newParticle(v.x+offsetX,v.y+offsetY,3,0,v.dir)
				end
			end
		end
		
		if v.x > camera.x + maxW or v.x < camera.x or v.y > camera.y + maxH or v.y < camera.y then
			table.remove(players[playerN].bullets,i)
		end
	end
	
	if players[playerN].opacity < 255 then
		players[playerN].opacity = players[playerN].opacity + 5
	end
	
	if playerN == 1 and players[2].grabbed or playerN == 2 and players[1].grabbed then
		if players[playerN].faceDir == "r" then
			players[playerN].frameN = 8
			players[playerN].sprXOffset = -10
			players[playerN].sprYOffset = -25
		elseif players[playerN].faceDir == "l" then
			players[playerN].frameN = 9
			players[playerN].sprXOffset = -20
			players[playerN].sprYOffset = -25
		end
	else
		if players[playerN].faceDir == "r" then
			players[playerN].frameN = 1
			players[playerN].sprXOffset = -10
			players[playerN].sprYOffset = -21
		elseif players[playerN].faceDir == "l" then
			players[playerN].frameN = 4
			players[playerN].sprXOffset = -20
			players[playerN].sprYOffset = -25
		elseif players[playerN].faceDir == "u" then
			if players[playerN].lastFaceDir == "r" then
				players[playerN].frameN = 2
				players[playerN].sprXOffset = -8
				players[playerN].sprYOffset = -25
			elseif players[playerN].lastFaceDir == "l" then
				players[playerN].frameN = 3
				players[playerN].sprXOffset = 0
				players[playerN].sprYOffset = -25
			else
				players[playerN].frameN = 1
				players[playerN].sprXOffset = -10
				players[playerN].sprYOffset = -10
			end
		elseif players[playerN].faceDir == "d" then
			if players[playerN].lastFaceDir == "r" then
				players[playerN].frameN = 6
				players[playerN].sprXOffset = -5
				players[playerN].sprYOffset = -8
			elseif players[playerN].lastFaceDir == "l" then
				players[playerN].frameN = 7
				players[playerN].sprXOffset = -5
				players[playerN].sprYOffset = -8
			end
		end
	end
	
	if players[playerN].dead then
		players[playerN].deadTimr = players[playerN].deadTimr + 1
		players[playerN].frameN = 5
		players[playerN].sprYOffset = 20
		players[playerN].move = false
		
		if players[playerN].lives == 1 and playerTWO then
			players[playerN].supaDead = true
			if players[playerN].cameraMove then
				players[playerN].cameraMove = false
			end
			players[playerN].lives = players[playerN].lives - 1
		end
		
		if playerN == 1 then
			if players[2].supaDead and players[2].grabbed then
				players[2].grabbed = false
				players[2].isJump = true
				players[2].propellX = true
				if players[1].faceDir == "r" then
					players[2].propellXV = 1
				elseif players[1].faceDir == "l" then
					players[2].propellXV = -1
					players[2].propellXV2 = 10
				end
			end
		end
		
		if players[playerN].deadTimr > 80 and not players[playerN].supaDead then
			if players[playerN].lives == 1 then
				players[playerN].lives = players[playerN].lives - 1
				if playerTWO then
					if players[1].lives == 0 then
						gameover1 = true
					end
					if players[2].lives == 0 then
						gameover2 = true
					end
				else
					gamestate = "gameover"
				end
			else
				players[playerN].x = players[playerN].spawnX + camera.x
				players[playerN].y = players[playerN].spawnY + camera.y
				players[playerN].ySpd = 0
				players[playerN].shape:moveTo(players[playerN].x+(players[playerN].w/2),players[playerN].y+(players[playerN].h/2))
				players[playerN].falling = true
				players[1].cameraMove = true
				players[playerN].jumpSpd = players[playerN].defJumpSpd
				players[playerN].isJump = false
				players[playerN].sprYOffset = -10
				players[playerN].deadTimr = 0
				players[playerN].move = true
				players[playerN].opacity = 50
				players[playerN].collID = 0
				players[playerN].floorID = 0
				players[playerN].frameN = 1
				players[playerN].sprXOffset = -10
				players[playerN].sprYOffset = -10
				players[playerN].lives = players[playerN].lives - 1
				players[playerN].dead = false
				players[playerN].deadTimr = 100
			end
		end
	else
		if players[playerN].deadTimr > 0 then
			players[playerN].deadTimr = players[playerN].deadTimr - 1
		end
	end
end