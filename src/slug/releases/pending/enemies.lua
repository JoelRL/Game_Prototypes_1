
-- ENEMIES UPDATE FUNCTION --
function enemies_update(dt)	
	enemies_enemUPDATE()
		
	enemies_bossUPDATE(dt)
end

function enemies_enemUPDATE()
	for i, v in ipairs(world_collisions.entities) do
		if v.class == "enemy" then
			if v.typ == 1 or v.typ == 4 then
				if v.x < camera.x + maxW + 100 then
					
					local falling = true
					
					for k, b in ipairs(world_collisions.colls) do
						if b.class == "floor" then
							local colls, sx, sy = v.shape:collidesWith(b.shape)
							if colls then
								if v.spd > 8 then
									v.color[2] = 0
									v.color[3] = 0
									v.hp = v.hp - 45
								end
								falling = false
								v.spd = v.defSpd
								v.shape:move(sx,sy)
							end
						end
					end
					
					if playerTWO then
						if players[2].supaDead then
							if v.shape:collidesWith(players[2].shape) then
								v.hp = v.hp - 10
								v.color[2] = 0
								v.color[3] = 0
							end
						end
						if players[1].supaDead then
							if v.shape:collidesWith(players[1].shape) then
								v.hp = v.hp - 10
								v.color[2] = 0
								v.color[3] = 0
							end
						end
					end
					
					if falling then
						v.y = v.y + v.spd
						v.shape:move(0,v.spd)
						v.spd = v.spd + 0.3
					end
					
					if v.y > maxH or v.hp < 0 then
						v.color[2] = 0
						v.color[3] = 0
						table.remove(world_collisions.entities,i)
					end
					
					if v.active and v.noticedP then
						if not players[1].supaDead then
							if players[1].dead == false and players[1].deadTimr < 1 then
								v.bulletTimr = v.bulletTimr + 1
							end
						end
						if not players[2].supaDead then
							if v.typ == 4 then
								if players[2].dead == false and players[2].deadTimr < 1 then
									v.bulletTimr = v.bulletTimr + 1
								end
							else							
								if players[2].dead == false and players[2].deadTimr < 1 and playerTWO then
									v.bulletTimr = v.bulletTimr + 1
								end
							end
						end
					end
				
					if v.color[2] < 255 then
						v.color[2] = v.color[2] + 40
					end
					
					if v.color[3] < 255 then
						v.color[3] = v.color[2] + 40
					end
					
					if players[1].supaDead then
						if players[2].y > v.y - 200 then
							if players[2].x + maxW - 300 > v.x then
								if v.x > players[2].x then
									v.faceDir = "l"
									v.frame = 1
									v.sprOffX = -20
									
									v.noticedP = true
								
									if v.particleTimr < 40 then
										v.showP = 1
										if v.partY > -33 then
											v.partY = v.partY - 4
										end
										v.particleTimr = v.particleTimr + 1
									else
										if v.showP ~= 0 then
											v.showP = 0
										end
									end
									
									if v.x < camera.x + maxW and v.particleTimr > 20 then
									
										local collis = false
									
										for k, b in ipairs(world_collisions.entities) do
											if b.class == "enemy" then
												local colls, sx, sy = v.shape:collidesWith(b.shape)
												if colls then
													collis = true
												end
											end
										end
									
										if v.x > players[2].x + 250 and v.moved == false and collis == false then
											v.x = v.x - v.spd
											v.shape:move(v.spd * -1,0)
											v.movedUnits = v.movedUnits + 1
											if v.movedUnits > 30 then
												v.moved = true
											end
										end
									end
								else
									v.faceDir = "r"
									v.frame = 2
									v.sprOffX = -10
									
									if v.particleTimr < 40 then
										v.showP = 1
										if v.partY > -33 then
											v.partY = v.partY - 4
										end
										v.particleTimr = v.particleTimr + 1
									else
										if v.showP ~= 0 then
											v.showP = 0
										end
									end
									
									v.noticedP = true
								end
							end
						else
							v.noticedP = false
						end
					else
						if players[1].y > v.y - 200 then
							if players[1].x + maxW - 300 > v.x then
								if v.x > players[1].x then
									v.faceDir = "l"
									v.frame = 1
									v.sprOffX = -20
									
									v.noticedP = true
								
									if v.particleTimr < 40 then
										v.showP = 1
										if v.partY > -33 then
											v.partY = v.partY - 4
										end
										v.particleTimr = v.particleTimr + 1
									else
										if v.showP ~= 0 then
											v.showP = 0
										end
									end
									
									if v.x < camera.x + maxW and v.particleTimr > 20 then
									
										local collis = false
									
										for k, b in ipairs(world_collisions.entities) do
											if b.class == "enemy" then
												local colls, sx, sy = v.shape:collidesWith(b.shape)
												if colls then
													collis = true
												end
											end
										end
									
										if v.x > players[1].x + 250 and v.moved == false and collis == false then
											v.x = v.x - v.spd
											v.shape:move(v.spd * -1,0)
											v.movedUnits = v.movedUnits + 1
											if v.movedUnits > 30 then
												v.moved = true
											end
										end
									end
								else
									v.faceDir = "r"
									v.frame = 2
									v.sprOffX = -10
									
									if v.particleTimr < 40 then
										v.showP = 1
										if v.partY > -33 then
											v.partY = v.partY - 4
										end
										v.particleTimr = v.particleTimr + 1
									else
										if v.showP ~= 0 then
											v.showP = 0
										end
									end
									
									v.noticedP = true
								end
							end
						else
							v.noticedP = false
						end
					end
					
					if v.bulletTimr > v.bulletTimrMax then
						local t = {}
						if v.faceDir == "r" then
							t.x = v.x + v.w
							t.dir = "r"
						elseif v.faceDir == "l" then
							t.x = v.x
							t.dir = "l"
						end
						t.y = v.y + (v.h / 2) - 10
						t.w = 10
						t.h = 10
						t.spd = 16
						if v.typ == 4 then
							t.angle = math.atan2(players[1].y - v.y, players[1].x - v.x)
							t.spd = 25
							t.w = 15
							t.h = 15
							
							local num1 = love.math.random(0,30)
							t.speedX = 0
							t.speedY = 0
							
							if num1 < 10 then
								if players[1].dir == "r" or players[1].lastFaceDir == "r" then
									t.speedX = players[1].moveSpd
								elseif players[1].dir == "l" or players[1].lastFaceDir == "l" then
									t.speedX = players[1].moveSpd * -1
								end
							elseif num1 > 10 and num1 < 20 then
								if players[1].dir == "r" or players[1].lastFaceDir == "r" then
									t.speedX = players[1].moveSpd
								elseif players[1].dir == "l" or players[1].lastFaceDir == "l" then
									t.speedX = players[1].moveSpd * -1
								end
								t.speedY = -4
							end
						end
						table.insert(v.bullets,t)
						v.bulletTimr = 0
					end
					
					for k, b in ipairs(v.bullets) do
					
						for t, l in ipairs(world_collisions.colls) do
							if l.class == "floor" or l.class == "coll" then
								if checkCollision(b,l) then
									table.remove(v.bullets,k)
								end
							end
						end
						
						for t, l in ipairs(world_collisions.entities) do
							if l.class == "enemy" and l.typ == 3 then

								local t2 = {}
								t2.x = l.x + 15
								t2.y = l.y - l.h
								t2.w = l.w
								t2.h = l.h
								
								if checkCollision(b,t2) then
									table.remove(v.bullets,k)
								end
							end
						end
					
						if v.typ == 1 then
							if b.dir == "r" then
								b.x = b.x + b.spd
							elseif b.dir == "l" then
								b.x = b.x - b.spd
							end
						elseif v.typ == 4 then
							local cos = math.cos(b.angle)
							local sin = math.sin(b.angle)
							
							b.x = (b.x + b.spd * cos) + b.speedX
							b.y = (b.y + b.spd * sin) + b.speedY
						end
						
						if b.x < camera.x or b.x > camera.x + maxW then
							table.remove(v.bullets,k)
						end
					
						if checkCollision(b,players[1]) then
							players[1].dead = true
							if players[1].isJump == false then
								players[1].isJump = true
							end
							table.remove(v.bullets,k)
						end
						
						if checkCollision(b,players[2]) then
							players[2].dead = true
							if players[2].isJump == false then
								players[2].isJump = true
							end
							table.remove(v.bullets,k)
						end
					end
				else
					if #v.bullets > 0 then
						table.remove(v.bullets,1)
					end
				end
			elseif v.typ == 2 or v.typ == 5 then
				if v.x < camera.x + maxW or v.typ == 5 then
					if players[1].x > v.x - 80 and v.spd == v.defSpd and players[1].deadTimr < 1 or players[2].x > v.x - 80 and v.spd == v.defSpd and players[2].deadTimr < 1  or v.typ == 5 and v.spd == v.defSpd and players[1].deadTimr < 1 and players[2].deadTimr < 1   then
						v.active = true
					end
					
					if playerTWO then
						if players[2].supaDead then
							if v.shape:collidesWith(players[2].shape) then
								v.hp = v.hp - 10
								v.color[2] = 0
								v.color[3] = 0
							end
						end
						if players[1].supaDead then
							if v.shape:collidesWith(players[1].shape) then
								v.hp = v.hp - 10
								v.color[2] = 0
								v.color[3] = 0
							end
						end
					end
					
					if v.color[2] < 255 then
						v.color[2] = v.color[2] + 40
					end
					
					if v.color[3] < 255 then
						v.color[3] = v.color[2] + 40
					end
					
					if v.hp < 0 then
						v.frame = 4
						v.active = false
					end
					
					if v.active then
						v.y = v.y + v.spd
						v.spd = v.spd + 0.5
						v.shape:move(0,v.spd)
						
						for k, b in ipairs(world_collisions.colls) do
							local colls, sx, sy = v.shape:collidesWith(b.shape)
							
							if colls then
								if b.class == "floor" then
									v.frame = 4
									v.sprOffY = 26
									v.active = false
								end
							end
						end
					end
					if v.frame == 4 and v.active == false then
						v.deathTimr = v.deathTimr + 1
						if v.deathTimr > 25 then
							table.remove(world_collisions.entities,i)
						end
					end
				end
			elseif v.typ == 3 then
			
				if v.hp < 0 then
					if v.typ == 3 then
						for k, b in ipairs(world_collisions.colls) do
							if k == v.deleteID then
								b.shape:moveTo(0,0)
							end
						end
					end
					table.remove(world_collisions.entities,i)
				end
			
				if v.color[2] < 255 then
					v.color[2] = v.color[2] + 40
				end
				
				if v.color[3] < 255 then
					v.color[3] = v.color[2] + 40
				end
				
			end
		end
	end
end

function enemies_bossUPDATE(dt)
	for i, v in ipairs(world_collisions.entities) do
		if v.class == "boss" then
			if v.id == 1 then
				if v.stage == "wait" then
					if v.timer1 < 50 then
						v.timer1 = v.timer1 + 1
						camera.x = camera.x + v.cameraShk
						if v.cameraShk > 0 then
							v.cameraShk = -10
						else
							v.cameraShk = 10
						end
					else
						v.stage = "start"
						v.timer1 = 0
					end
				end
			
				if v.stage == "start" then
					v.y = v.y - 15
					v.shape:move(0,-15)
					camera.x = camera.x + v.cameraShk
					camera.y = camera.y + (v.cameraShk / 3)
					if v.cameraShk > 0 then
						v.cameraShk = -10
					else
						v.cameraShk = 10
					end
					
					v.particleTimr = v.particleTimr + 1
					
					if v.particleTimr > v.particleTimrMax then
						newParticle(v.x,v.y+40,1)
						v.particleTimr = 0
					end
					
					if v.y < 100 then
						v.timer1 = 0
						v.stage = "intro"
					end
				end
				
				if v.stage == "intro" then
					v.x = v.x + v.xSpd
					v.y = v.y + v.ySpd
					v.shape:move(v.xSpd,v.ySpd)
					
					if v.dirX == 1 then
						v.xSpd = v.xSpd - 0.1
						if v.xSpd < (v.maxXspd * -1) + 0.1 then
							v.dirX = -1
						end
					elseif v.dirX == -1 then
						v.xSpd = v.xSpd + 0.1
						if v.xSpd > v.maxXspd - 0.1 then
							v.dirX = 1
						end
					end
					
					if v.dirY == 1 then
						v.ySpd = v.ySpd - 0.1
						if v.ySpd < v.maxYspd * -1 then
							v.dirY = -1
						end
					elseif v.dirY == -1 then
						v.ySpd = v.ySpd + 0.1
						if v.ySpd > v.maxYspd - 0.05 then
							v.dirY = 1
						end
					end
					
					v.particleTimr = v.particleTimr + 1
					
					if v.particleTimr > v.particleTimrMax then
						newParticle(v.x,v.y+40,1)
						v.particleTimr = 0
					end
					
					if v.timer1 < 100 and v.talk == false then
						v.timer1 = v.timer1 + 1
					else
						if v.talk == false then
							v.talk = true
							v.timer1 = 0
						end
					end
					
					if v.talk then
						message.update(dt,string.upper(v.script[v.scriptNum]))
						
						if text.done then
							if v.talkF ~= 2 then
								v.talkF = 2
							end
						
							v.timer1 = v.timer1 + 1
							
							if v.timer1 > 100 then
							
								if v.script[v.scriptNum+1] == nil then
									message.close()
									v.talk = false
									v.stage = "fight"
								end
							
								v.scriptNum = v.scriptNum + 1
								message.resetVar()
								v.timer1 = 0
							end
						end
					end
				end
				
				if v.stage == "fight" then
				
					if players[1].cameraMove then
						players[1].cameraMove = false
					end
					
					if players[1].x > 1540 and players[1].dead == false and v.x + v.w > 1600 and #world_collisions.entities < 2 then
						if v.fightStage == 1 then
							world_collisions.newEnemy(players[1].x+5,v.y,5)
						end
					end
					
					if playerTWO then
						if players[2].supaDead then
							if v.shape:collidesWith(players[2].shape) then
								v.hp = v.hp - 10
								v.color[2] = 0
								v.color[3] = 0
							end
						end
						if players[1].supaDead then
							if v.shape:collidesWith(players[1].shape) then
								v.hp = v.hp - 10
								v.color[2] = 0
								v.color[3] = 0
							end
						end
					end

					v.x = v.x + v.xSpd
					v.shape:move(v.xSpd,0)
					
					if v.dirX == 1 then
						v.xSpd = v.xSpd - 0.1
						if v.xSpd < (v.maxXspd * -1) + 0.1 then
							v.dirX = -1
						end
					elseif v.dirX == -1 then
						v.xSpd = v.xSpd + 0.1
						if v.xSpd > v.maxXspd - 0.1 then
							v.dirX = 1
						end
					end
					
					v.particleTimr = v.particleTimr + 1
					
					if v.fightStage == 1 then
					
						if v.particleTimr > v.particleTimrMax then
							newParticle(v.x,v.y+40,1)
							v.particleTimr = 0
						end
					
						if v.color[2] < 255 then
							v.color[2] = v.color[2] + 40
						end
						
						if v.color[3] < 255 then
							v.color[3] = v.color[2] + 40
						end
					
						if playerTWO == false then
							if players[1].dead == false then
								v.timer1 = v.timer1 + 1
							end
						else
							v.timer1 = v.timer1 + 1
						end
						
						if v.timer1 > v.fightTimer1Max then
							-- local num = love.math.random(0,30)
							
							if v.aptternNUM == 1 or v.aptternNUM == 2 or v.aptternNUM == 5 then
								world_collisions.newEnemy(v.x,v.y,5)
								
								v.timer1 = 0
								v.aptternNUM = v.aptternNUM + 1
								if v.aptternNUM > 5 then
									v.aptternNUM = 1
								end
								v.fightTimer1Max = love.math.random(60,120)
							elseif v.aptternNUM == 3 or v.aptternNUM == 4 then
								if playerTWO and players[2].supaDead == false then
									if v.aptternNUM == 3 then
										world_collisions.newEnemy(players[1].x,v.y,5)
										
										v.timer1 = 0
										v.aptternNUM = v.aptternNUM + 1
										v.fightTimer1Max = love.math.random(60,120)
									end
									if v.aptternNUM == 4 then
										world_collisions.newEnemy(players[2].x,v.y,5)
										
										v.timer1 = 0
										v.aptternNUM = v.aptternNUM + 1
										v.fightTimer1Max = love.math.random(60,120)
									end
								else
									world_collisions.newEnemy(players[1].x,v.y,5)
									
									v.timer1 = 0
									v.aptternNUM = v.aptternNUM + 1
									v.fightTimer1Max = love.math.random(60,120)
								end
							end
						end
						if v.hp < v.maxHP / 2 then
							v.fightStage = 2
							v.timer1 = 0
							v.ySpd = 8
							v.maxYspd = v.ySpd
							v.dir = 1
							v.color[2] = 150
							v.color[3] = 150
						end
					end
					
					if v.fightStage == 2 then
					
						if v.particleTimr > v.particleTimrMax then
							local color = {255,200,0,255}
							newParticle(v.x,v.y+40,1,color)
							newParticle(v.x,v.y+40,1,color)
							newParticle(v.x,v.y+40,1,color)
							v.particleTimr = 0
						end
					
						if v.color[2] < 150 then
							v.color[2] = v.color[2] + 40
						end
						
						if v.color[3] < 150 then
							v.color[3] = v.color[2] + 40
						end
						
						v.timer1 = v.timer1 + 1
						
						if v.timer1 > v.fightTimer1Max then
							
							v.y = v.y + v.ySpd
							v.shape:move(0,v.ySpd)
							
							if v.ySpd < v.maxYspd * -1 then
								v.ySpd = v.maxYspd
								v.dir = 1
								v.timer1 = 0
								v.fightTimer1Max = love.math.random(20,100)
							end
						
							if v.dirY == 1 then
								v.ySpd = v.ySpd - 0.1
								if v.ySpd < v.maxYspd * -1 then
									v.dirY = -1
								end
							elseif v.dirY == -1 then
								v.ySpd = v.ySpd + 0.1
								if v.ySpd > v.maxYspd - 0.05 then
									v.dirY = 1
								end
							end
						end
					end
					
					if v.hp < 0 and v.stage ~= "death" then
						v.talk = true
						v.scriptNum = 1
						v.stage = "death"
						v.timer1 = 0
					end
				end
				
				if v.stage == "death" then
					if v.talk then
						message.update(dt,string.upper(v.deathScript[v.scriptNum]))
						
						if text.done then
							if v.talkF ~= 2 then
								v.talkF = 2
							end
						
							v.timer1 = v.timer1 + 1
							
							if v.timer1 > 100 then
							
								if v.deathScript[v.scriptNum+1] == nil then
									message.close()
									v.talk = false
								end
							
								v.scriptNum = v.scriptNum + 1
								message.resetVar()
								v.timer1 = 0
							end
						end
					else
						v.color[4] = v.color[4] - 30
						if v.color[4] < 0 then
							table.remove(world_collisions.entities,i)
						players[1].cameraMove = true
						end
					end
				end
			end
		end
	end
end