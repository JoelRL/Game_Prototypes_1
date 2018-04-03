function loadPlayerStats()
	player = {
		x = 10,
		y = 60,
		w = 25,
		h = 40,
		draw = true,
		spr = love.graphics.newImage("/assets/player.png"),
		color = {252,252,252,252},
		collWithSolid = false,
		collWithSolid_ID = 0,
		collTyp = "",
		collX = 0,
		collY = 0,
		xSpd = 0.5,
		xSpdMax = 3,
		xSpdDec = 0.25,
		xLastDir = "",
		ySpd = 0.5,
		ySpdMax = 3,
		ySpdDec = 0.25,
		yLastDir = "",
		
		-- Grab mechanic --
		grabSpr = love.graphics.newImage("assets/hand.png"),
		grabSprF = {
			love.graphics.newQuad(0,0,30,15,60,15),
			love.graphics.newQuad(30,0,30,15,60,15),
		},
		grabFrame = 1,
		grabX = 0,
		grabY = 0,
		grabW = 30,
		grabH = 15,
		grabScale = 1,
		grabAngle = 0,
		grabAngleSwitch = 1,
		grabActive = false,
		grabObjTyp = 0,
		grabObjID = 0,
		grabCollID = 0,
		grabUsable = false,
		grabROff = 0,
		grabUsing = false,
	}
	
	-- Player shape
	player.shape = shapes.newPolygonShape(
		player.x,player.y,player.x+player.w,player.y,
		player.x+player.w,player.y+player.h,player.x,
		player.y+player.h
	)
	
	player.xSpdDef = player.xSpd
	player.ySpdDef = player.ySpd
	
	player.grabX = player.x + player.w - 5
	player.grabY = player.y + player.grabH + 5
	player.grabShape = shapes.newPolygonShape(
		player.grabX,player.grabY,player.grabX+player.grabW,player.grabY,
		player.grabX+player.grabW,player.grabY+player.grabH,player.grabX,
		player.grabY+player.grabH
	)
	player.grabShape:rotate(player.grabAngle)
end

function drawPlayer()
	if player.draw then
		love.graphics.setColor(player.color)
		
		-- Player hand draw --
		love.graphics.draw(player.grabSpr,player.grabSprF[player.grabFrame],player.grabX,player.grabY,
							player.grabAngle,player.grabScale,1,1)
		
		-- Player drawing --
		-- love.graphics.rectangle("fill",player.x,player.y,player.w,player.h)
		love.graphics.draw(player.spr,player.x,player.y)
		
		if showColls then
			-- Debug collision --
			love.graphics.setColor(252,0,0,200)
			
			player.shape:draw("line")
			
			player.grabShape:draw("line")
			
			love.graphics.setColor(252,252,252)
		end
		-- Debug print --
	end
end

function playerUpdate()

	for i, v in ipairs(colls) do
		
		local colls, sx, sy = player.shape:collidesWith(v.shape)
		
		if colls and v.typ == "solid" then
			-- Set up player colliding variables to keep track if its still colliding with the object
			player.collWithSolid = true
			player.collWithSolid_ID = i
			player.collTyp = v.typ
			
			if sx ~= 0 then
				-- Set up player colliding variables
				player.collX = sx
				if player.xSpd ~= player.xSpdDef then
					player.xSpd = player.xSpdDef
				end
				
				-- Resolve collision
				player.x = player.x + player.collX
				player.shape:move(player.collX,0)
				player.grabX = player.grabX + player.collX
				player.grabShape:move(player.collX,0)
			end
			
			if sy ~= 0 then
				-- Set up player colliding variables
				player.collY = sy
				if player.ySpd ~= player.ySpdDef then
					player.ySpd = player.ySpdDef
				end
				
				-- Resolve collision
				player.y = player.y + player.collY
				player.shape:move(0,player.collY)
				player.grabY = player.grabY + player.collY
				player.grabShape:move(0,player.collY)
			end
		else
			-- Check if player is still colliding with the same object and resolve it
			if player.collWithSolid and player.collWithSolid_ID == i then
				player.collWithSolid = false
				player.collWithSolid_ID = 0
				player.collTyp = ""
				player.collX = 0
				player.collY = 0
			end
		end
	end

	-- Player movement --
	if love.keyboard.isDown("right") then
		player.xLastDir = "r"
	
		player.x = player.x + player.xSpd
		player.shape:move(player.xSpd,0)
		player.grabX = player.grabX + player.xSpd
		player.grabShape:move(player.xSpd,0)
		
		-- Move grab X
		player.grabX = player.x + player.w - 5
		player.grabY = player.y + player.grabH + 5
		player.grabScale = 1
		player.grabShape:moveTo(player.x + player.w - 5 + (player.grabW/2),player.y + player.grabH + 5 + (player.grabH/2))
		
		if player.xSpd < player.xSpdMax then
			player.xSpd = player.xSpd + 0.1
		end
	else
		-- When X keys arent pressed anymore, decrease player X speed
		if not love.keyboard.isDown("left") and player.xSpd ~= player.xSpdDef then
			
			-- If player colliding on X sides, get the hell out of here (a.k.a Stop decrease)
			if player.collWithSolid and player.collX ~= 0 and player.collTyp == "solid" then
				return
			end
			
			if player.xSpd > player.xSpdDef then
				player.xSpd = player.xSpd - player.xSpdDec
				if player.xLastDir == "r" then
					player.x = player.x + player.xSpd
					player.shape:move(player.xSpd,0)
					player.grabX = player.grabX + player.xSpd
					player.grabShape:move(player.xSpd,0)
				else
					player.x = player.x - player.xSpd
					player.shape:move(player.xSpd * -1,0)
					player.grabX = player.grabX - player.xSpd
					player.grabShape:move(player.xSpd * -1,0)
				end
			else
				if player.xSpd ~= player.xSpdDef then
					player.xSpd = player.xSpdDef
				end
			end
		end
	end
	
	if love.keyboard.isDown("left") and not love.keyboard.isDown("right") then
		player.xLastDir = "l"
		
		player.x = player.x - player.xSpd
		player.shape:move(player.xSpd * -1,0)
		player.grabX = player.grabX - player.xSpd
		player.grabShape:move(player.xSpd * -1,0)
		
		-- Move grab X
		player.grabX = player.x + 5
		player.grabY = player.y + player.grabH + 5
		player.grabScale = -1
		player.grabShape:moveTo(player.x - player.grabW + 5 + (player.grabW/2),player.y + player.grabH + 5 + (player.grabH/2))
		
		if player.xSpd < player.xSpdMax then
			player.xSpd = player.xSpd + 0.1
		end
	end
	
	if love.keyboard.isDown("up") then
		player.yLastDir = "u"
	
		player.y = player.y - player.ySpd
		player.shape:move(0,player.ySpd * -1)
		player.grabY = player.grabY - player.ySpd
		player.grabShape:move(0,player.ySpd * -1)
		
		if player.ySpd < player.ySpdMax then
			player.ySpd = player.ySpd + 0.1
		end
	else
		-- When Y keys arent pressed anymore, decrease player Y speed
		if not love.keyboard.isDown("down") and player.ySpd ~= player.ySpdDef then
		
			-- If player colliding on Y sides, get the hell out of here (a.k.a Stop decrease)
			if player.collWithSolid and player.collY ~= 0 and player.collTyp == "solid" then
				return
			end
		
			if player.ySpd > player.ySpdDef then
				player.ySpd = player.ySpd - player.ySpdDec
				if player.yLastDir == "u" then
					player.y = player.y - player.ySpd
					player.shape:move(0,player.ySpd * -1)
					player.grabY = player.grabY - player.ySpd
					player.grabShape:move(0,player.ySpd * -1)
				else
					player.y = player.y + player.ySpd
					player.shape:move(0,player.ySpd)
					player.grabY = player.grabY + player.ySpd
					player.grabShape:move(0,player.ySpd)
				end
			else
				if player.ySpd ~= player.ySpdDef then
					player.ySpd = player.ySpdDef
				end
			end
		end
	end
	
	if love.keyboard.isDown("down") and not love.keyboard.isDown("up") then
		player.yLastDir = "d"
		
		player.y = player.y + player.ySpd
		player.shape:move(0,player.ySpd)
		player.grabY = player.grabY + player.ySpd
		player.grabShape:move(0,player.ySpd)
		
		if player.ySpd < player.ySpdMax then
			player.ySpd = player.ySpd + 0.1
		end
	end
	
	-- Grabbing shit --
	if love.keyboard.isDown("z") then
		if not player.grabActive then
			player.grabFrame = 2
		else
			
		end
	else
		if not player.grabActive then
			if player.grabFrame == 2 then
				player.grabFrame = 1
			end
		end
	end
	
	if not player.grabActive then
		if player.grabAngleSwitch == -1 then
			player.grabAngle = player.grabAngle - 0.005
			
			if player.grabAngle < -0.1 then
				player.grabAngleSwitch = 1
			end
		elseif player.grabAngleSwitch == 1 then
			player.grabAngle = player.grabAngle + 0.005
			
			if player.grabAngle > 0.1 then
				player.grabAngleSwitch = -1
			end
		end
	else
		player.grabAngle = 0
	end
	
	if player.grabActive then
	
		local var1 = player.grabObjTyp
	
		if var1 == 2 or var1 == 3 then
		
			for i, v in ipairs(objects) do
				if player.grabObjID == v.id then
				
					if player.grabUsing then
						if var1 == 3 or var1 == 2 then
						
							if player.xLastDir == "r" then
							
								v.angle1 = v.angle1 + 0.15
								
								v.gX1 = v.gX1 + 2
								v.gY1 = v.gY1 + 3
								
							else
								
								v.angle2 = v.angle2 - 0.15
								
								v.gX2 = v.gX2 + 2
								v.gY2 = v.gY2 + 3
								
							end
						
							if player.xLastDir == "r" and v.angle1 > 3.3 or player.xLastDir == "l" and v.angle2 < -0.3 then
								player.grabUsing = false
								v.angle1 = v.angle1D
								v.angle2 = v.angle2D
								v.gX1 = v.gX1D
								v.gY1 = v.gY1D
								v.gX2 = v.gX2D
								v.gY2 = v.gY2D
							end
						end
					end
				
					if player.xLastDir == "r" then
						v.x = player.x + v.gX1
						v.y = player.y + v.gY1
						v.rotate = v.angle1 + player.grabROff
						
						for k, b in ipairs(colls) do
							if b.id == player.grabCollID then
								b.shape:moveTo(player.x + v.gX1, player.y + v.gY1)
								b.shape:setRotation(v.angle1)
							end
						end
					end
					if player.xLastDir == "l" then
						v.x = player.x - v.gX2
						v.y = player.y + v.gY2
						v.rotate = v.angle2 + player.grabROff
						
						for k, b in ipairs(colls) do
							if b.id == player.grabCollID then
								b.shape:moveTo(player.x - v.gX2, player.y + v.gY2)
								b.shape:setRotation(v.angle2)
							end
						end
					end
				end
			end
		end
	end
	
	for i, v in ipairs(objects) do
	
		local var1 = player.grabObjTyp
	
		if var1 == 2 or var1 == 3 then
			if v.grabReaction then
			
				local angleS = v.grabReactionRnum
				local decSpeed = 0.1
				
				v.x = v.x + v.grabReactionX
				v.y = v.y + v.grabReactionY
				v.rotate = v.rotate + angleS
				
				if v.grabReactionX > 0 and v.grabReactionD == "r" or v.grabReactionX < 0 and v.grabReactionD == "l" then
				
					if v.grabReactionYSwitch == 1 then
						v.grabReactionY = v.grabReactionY + 1
						if v.y > v.grabReactionYL - v.grabReactionY then
							v.grabReactionYM = v.grabReactionYM / 1.5
							v.grabReactionY = v.grabReactionYM
							v.grabReactionYSwitch = 0
						end
					else
						v.grabReactionY = v.grabReactionY - 1
						
						if v.grabReactionY < v.grabReactionYM then
							v.grabReactionYSwitch = 1
						end
					end
				end
				
				for k, b in ipairs(colls) do
					if b.objID == v.id then
						b.shape:move(v.grabReactionX,v.grabReactionY)
						b.shape:rotate(angleS)
						
						for j, d in ipairs(colls) do
							local colls, sx, sy = b.shape:collidesWith(d.shape)
							
							if colls and d.typ == "solid" then
								v.grabReactionX = v.grabReactionX * -1
								if v.grabReactionD == "r" then
									v.grabReactionD = "l"
								elseif v.grabReactionD == "l" then
									v.grabReactionD = "r"
								end
							end
						end
						
					end
				end
				
				if v.grabReactionD == "r" then
					
					if player.grabAngle < -0.1 then
						player.grabAngle = player.grabAngle + 0.1
					end
					
					if v.grabReactionX < 0 then
					
						v.grabReactionY = v.grabReactionY + 3
						
						if v.y > v.grabReactionYL - v.grabReactionY then
							for k, b in ipairs(colls) do
								if b.objID == v.id then
									b.shape:moveTo(v.x, v.y)
								end
							end
							v.grabReaction = false
						end
					else
						v.grabReactionX = v.grabReactionX - decSpeed
					end
					
				elseif v.grabReactionD == "l" then
					
					if player.grabAngle > 0.1 then
						player.grabAngle = player.grabAngle - 0.1
					end
					
					if v.grabReactionX > 0 then
					
						v.grabReactionY = v.grabReactionY + 3
						
						if v.y > v.grabReactionYL - v.grabReactionY then
							for k, b in ipairs(colls) do
								if b.objID == v.id then
									b.shape:moveTo(v.x, v.y)
								end
							end
							v.grabReaction = false
						end
					else
						v.grabReactionX = v.grabReactionX + decSpeed
					end
					
				end
				
			end
		end
	end
end

function player_keypress(key)
	if key == "z" then
		if player.grabActive then
			for i, v in ipairs(objects) do
				if player.grabObjID == v.id then
					v.grabReaction = true
					v.grabReactionD = player.xLastDir
					
					local speed = 6
					
					player.grabActive = false
					
					if v.grabReactionD == "r" then
						v.grabReactionX = speed
						player.grabAngle = -1.2
					elseif v.grabReactionD == "l" then
						v.grabReactionX = speed * -1
						player.grabAngle = 1.2
					end
					
					v.grabReactionY = love.math.random(-8,-6)
					v.grabReactionYM = v.grabReactionY
					v.grabReactionYL = player.y + player.h
					v.grabReactionRnum = love.math.random(1,10)
					
					v.grabReactionRnum = v.grabReactionRnum / 100
					
					player.grabFrame = 1
				end
			end
		else
			for i, v in ipairs(colls) do
			
				local colls, sx, sy = player.grabShape:collidesWith(v.shape)
				
				if colls and v.typ == "grab" then
					player.grabActive = true
					player.grabCollID = v.id
					
					for k, b in ipairs(objects) do
						if b.id == v.objID then
							player.grabObjTyp = b.typ
							player.grabObjID = b.id
							player.grabUsable = b.usable
						end
					end
					
					local var1 = player.grabObjTyp
					
					player.grabFrame = 2
				end
			end
		end
	end
	if key == "x" then
		if player.grabActive and player.grabUsable then
			for i, v in ipairs(objects) do
				if i == player.grabObjID then
					player.grabUsing = true
				end
			end
		end
	end
end