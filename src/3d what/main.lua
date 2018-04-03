shapes = require "libs.HC.shapes"
require "roadMaps"
require "sprites"
require "world_rooms"

function love.load()

	maxW, maxH = love.graphics.getDimensions()
	
	car_sfx = {
		start = love.audio.newSource("/assets/sfx/start.mp3","static"),
		run = love.audio.newSource("/assets/sfx/run.mp3","static"),
		end1 = love.audio.newSource("/assets/sfx/end.mp3","static"),
	}
	
	car_sfx.start:setLooping(false)
	car_sfx.run:setLooping(true)
	car_sfx.end1:setLooping(false)
	
	carFXEND = true

    speed = 0
    maxSpeed = 300
    acceleration = 150
    deceleration = acceleration * 1.2
	
	love.graphics.setDefaultFilter('nearest','nearest')
    
	sprites.load()
	
	player_x = 300
	player_y = 300
	player_r = 0
	player_mode = 0
	
	player_xO = 0
	player_yO = 0
	player_sO = 2
	player_nearCar = false
	player_sprO = love.graphics.newImage("/player.png")
	player_sprOffO = 0
	player_scO = 1
	player_scO2 = 1
	
	dustParticles = {}
	
	particleTimr = 0
	
	love.graphics.setBackgroundColor(100,100,100)
	
	love.graphics.setPointSize(3)
	
	touch = false
	
	colls = true
	
	player_points = {player_x,player_y,player_x-15,player_y-15,player_x+15,player_y-15,player_x+15,player_y+7,player_x-15,player_y+5}
	
	poly1 = shapes.newPolygonShape(player_points[3],player_points[4],player_points[5],player_points[6],player_points[7],player_points[8],player_points[9],player_points[10])
	
	poly2 = shapes.newPolygonShape(-15,-15,0,-15,0,0,-15,0)
	
	roomNUM = 1
	
	world_rooms.load()
	
	for k, v in ipairs(rooms) do
		for i=1, #v.obsticles do
			
			v.obsticles[i].points = {v.obsticles[i].bx,v.obsticles[i].by,v.obsticles[i].bx+v.obsticles[i].w,v.obsticles[i].by,v.obsticles[i].bx+v.obsticles[i].w,v.obsticles[i].by+v.obsticles[i].h,v.obsticles[i].bx,v.obsticles[i].by+v.obsticles[i].h}
		
			local shape = shapes.newPolygonShape(unpack(v.obsticles[i].points))
			table.insert(v.obsticlesColls,shape)
		end
	end
	
	love.audio.setVolume(0)
end

function love.draw()
	love.graphics.setColor(255,255,255)
	
	if rooms[roomNUM].bgdraw then
		love.graphics.draw(rooms[roomNUM].bg,0,0)
	end
	
	if rooms[roomNUM].road then
		for y=1, #roadMaps[rooms[roomNUM].roadMapNum] do
			for x=1, #roadMaps[rooms[roomNUM].roadMapNum][y] do
				if roadMaps[rooms[roomNUM].roadMapNum][y][x] ~= 0 then
					love.graphics.draw(sprite_sheet3,road_spr[roadMaps[rooms[roomNUM].roadMapNum][y][x]],x*32,y*32)
				end
			end
		end
	end
	
	if rooms[roomNUM].car then
		for i, v in ipairs(dustParticles) do
			love.graphics.draw(dustParticle,v.x,v.y,0,v.scale)
		end
	end
	
	for i, v in ipairs(rooms[roomNUM].obsticles) do
		if v.spr ~= 0 then
			for k=1, #obsticleSprite[v.spr] do
				if v.sprDepth[k] == -1 then
					love.graphics.draw(sprite_sheet2,obsticleSprite[v.spr][k],v.x,v.y - v.Sh * (k - 1),v.r)
				end
			end
		end
	end
	
	if rooms[roomNUM].car then
		for i, v in ipairs(sprite) do
			love.graphics.draw(sprite_sheet1,sprite[i],player_x,player_y - 2 * (i - 1),player_r,1,1,16,16)
		end
	end
	
	if player_mode == 1 and rooms[roomNUM].human then
		-- love.graphics.rectangle("fill",player_xO,player_yO,15,15)
		love.graphics.draw(player_sprO,player_xO - player_sprOffO,player_yO,0,player_scO,player_scO2)
	end
	
	love.graphics.setColor(255,255,255)
	
	for i, v in ipairs(rooms[roomNUM].obsticles) do
		if v.spr ~= 0 then
			for k=1, #obsticleSprite[v.spr] do
				if v.sprDepth[k] == 1 then
					love.graphics.draw(sprite_sheet2,obsticleSprite[v.spr][k],v.x,v.y - v.Sh * (k - 1),v.r)
				end
			end
		end
	end
	
	love.graphics.setColor(255,0,0)

	love.graphics.print(player_xO.." | "..player_yO)
	
	love.graphics.print(player_scO,0,20)
	
	love.graphics.print(player_sprOffO,0,40)
	
	if colls then
		for i=1, #rooms[roomNUM].obsticles do
			rooms[roomNUM].obsticlesColls[i]:draw("line")
		end
		
		poly1:draw("line")
		poly2:draw("line")
		
		love.graphics.setColor(0,252,0)
		
		for i=1, #rooms[roomNUM].doors do
			rooms[roomNUM].doors[i].shape:draw("line")
		end
		
		love.graphics.setColor(255,0,0)
		
		poly2:draw("line")
	end
end

function love.update(dt)

	player_points = {player_x,player_y,player_x+15,player_y-15,player_x+15,player_y+7,player_x-15,player_y-15,player_x-15,player_y+5}
	
	player_move = true
	
	for i, v in ipairs(rooms[roomNUM].obsticles) do
		
		local coll, sx, sy = poly1:collidesWith(rooms[roomNUM].obsticlesColls[i])
		
		if coll then
			player_x = player_x + sx
			player_y = player_y + sy
			poly1:move(sx,sy)
			car_sfx.start:stop()
			car_sfx.run:stop()
			player_move = false
		else
			if v.r > 6.1 then
				v.hit = false
				v.r = 0
			end
		end
	end
	
	for i, v in ipairs(rooms[roomNUM].obsticles) do
		if v.hit then
			if v.r < 6.1 then
				v.r = v.r + 0.5
			else
				v.r = 6.2
			end
		end
	end
	
	if player_move then
		touch = false
	else
		touch = true
		speed = speed * -1
	end
	
	for i, v in ipairs(dustParticles) do
		v.tim = v.tim + 1
		v.scale = v.scale + 0.02
		if v.tim > 40 then
			table.remove(dustParticles,i)
		end
	end
	
	if player_mode == 0 then

		local rotAmount = 5 * dt
		if love.keyboard.isDown("right") then
			player_r = player_r + rotAmount
			poly1:rotate(rotAmount)
		end
		if love.keyboard.isDown("left") then
			player_r = player_r - rotAmount
			poly1:rotate(rotAmount*-1)
		end
		
		if love.keyboard.isDown("up") then
			speed = speed + acceleration*dt
			car_sfx.run:play()
			
			addParticle()
			
		elseif love.keyboard.isDown("down") then
			speed = speed - acceleration*dt
			if carFXEND then
				car_sfx.run:stop()
				car_sfx.end1:play()
				carFXEND = false
			end
			
			if speed < 1 then
				car_sfx.end1:stop()
				carFXEND = true
			end
		else
			speed = speed - deceleration*dt
			
			if carFXEND then
				car_sfx.run:stop()
				car_sfx.end1:play()
				carFXEND = false
			end
			
			if speed < 1 then
				car_sfx.end1:stop()
				carFXEND = true
			end
		end
		if speed > maxSpeed then
			speed = maxSpeed
		elseif speed < 0 then
			speed = 0
		end
		

		player_x = player_x + math.cos(player_r) * speed * dt
		player_y = player_y + math.sin(player_r) * speed * dt
		
		poly1:move(math.cos(player_r) * speed * dt,math.sin(player_r) * speed * dt)
		
	elseif player_mode == 1 then
	
		for i=1, #rooms[roomNUM].doors do
			local coll, sx, sy = poly2:collidesWith(rooms[roomNUM].doors[i].shape)
			
			if coll then
			
				-- if rooms[roomNUM].scale < player_scO then
					-- poly2:scale(rooms[roomNUM].scale)
				-- else
					-- poly2:scale(rooms[roomNUM].scale * -1)
					
				-- end
				
				roomNUM = rooms[roomNUM].doors[i].pointer
				
				local x, y = rooms[roomNUM].doors[i].pointer2, rooms[roomNUM].doors[i].pointer3
				
				print(rooms[roomNUM].scale)
				
				poly2 = shapes.newPolygonShape(x,y,x+(15*rooms[roomNUM].scale),y,x+(15*rooms[roomNUM].scale),y+(15*rooms[roomNUM].scale),x,y+(15*rooms[roomNUM].scale))
				
				player_scO = rooms[roomNUM].scale
				player_scO2 = rooms[roomNUM].scale
				player_xO = x
				player_yO = y
				player_sprOffO = 0
			end
		end
	
		if speed > 0 then
			speed = speed - acceleration*dt
			
			player_x = player_x + math.cos(player_r) * speed * dt
			player_y = player_y + math.sin(player_r) * speed * dt
			
			poly1:move(math.cos(player_r) * speed * dt,math.sin(player_r) * speed * dt)
		end
	
		local x, y = 0, 0
	
		if love.keyboard.isDown("right") then
			player_xO = player_xO + player_sO
			if player_scO ~= 1 then
				player_sprOffO = 0
				player_scO = player_scO2
			end
			x = x + player_sO
		elseif love.keyboard.isDown("left") then
			player_xO = player_xO - player_sO
			if player_scO ~= -1 then
				player_sprOffO = -15 * player_scO2
				player_scO = player_scO2 * -1
			end
			x = x - player_sO
		end
		if love.keyboard.isDown("up") then
			player_yO = player_yO - player_sO
			y = y - player_sO
		elseif love.keyboard.isDown("down") then
			player_yO = player_yO + player_sO
			y = y + player_sO
		end
		
		if x ~= 0 or y ~= 0 then
			poly2:move(x,y)
		end
		
		if poly2:collidesWith(poly1) then
			player_nearCar = true
		else
			player_nearCar = false
		end
		
		for i, v in ipairs(rooms[roomNUM].obsticles) do
			collision, sx, sy = poly2:collidesWith(rooms[roomNUM].obsticlesColls[i])
			if collision then
				player_xO = player_xO + sx
				player_yO = player_yO + sy
				poly2:move(sx,sy)
			end
		end
	end
end

function addParticle()
	local particle = {x=player_x,y=player_y,tim=0,scale=0.6}
	table.insert(dustParticles,particle)
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
	
	if key == "up" then
		car_sfx.start:play()
	end
	
	if key == "x" then
		player_scO2 = player_scO2 + 1
		player_scO = player_scO + 1
	end
	
	if key == "z" and rooms[roomNUM].car then
		if player_mode == 0 then
			player_mode = 1
			player_xO = player_x + 5
			player_yO = player_y + 10
			poly2:moveTo(player_xO+(15/2),player_yO+(15/2))
		elseif player_mode == 1 then
			if player_nearCar then
				player_xO = -15
				player_yO = -15
				poly2:moveTo(player_xO+(15/2),player_yO+(15/2))
				player_mode = 0
			end
		end
	end
	
	if key == "u" then
		if colls then
			colls = false
		else
			colls = true
		end
	end
end