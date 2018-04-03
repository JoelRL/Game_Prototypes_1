game = {}
local playerFilter = require('playerfunctions').playerFilter

function game.load()
	mainChar = 0
	
	cameraFilterColor = {0,0,0,100}
	BGoffset = 0
	BGoffsetDir = 1
	BGoffsetLim = 2
	BGoffsetSPD = 3
	
	world = bump.newWorld(32)
	
	textFont1BIG = love.graphics.newFont("/assets/misc/unlearne.ttf",50)
	
	touchNPC = false
	NPCacting = false
	NPCactingID = 0

	char = {}
	
	char[1] = {
		x = 313,
		y = 300,
		w = 29,
		h = 68,
		r = -1,
		spd = 3,
		sprSh = love.graphics.newImage("/assets/spr/char1SPR.png"),
		sprShW = 264,
		sprShH = 68,
		frmD = 1,
		wTimr = 0,
		canMove = false,
		main = false,
	}
	char[1].frms = {
		love.graphics.newQuad(0,0,54,68,char[1].sprShW,char[1].sprShH),
		love.graphics.newQuad(56,0,54,68,char[1].sprShW,char[1].sprShH),
		love.graphics.newQuad(112,0,46,68,char[1].sprShW,char[1].sprShH),
		love.graphics.newQuad(160,0,54,68,char[1].sprShW,char[1].sprShH),
		love.graphics.newQuad(218,0,46,68,char[1].sprShW,char[1].sprShH),
	}
	
	world:add(char[1],char[1].x+10,char[1].y,char[1].w,char[1].h)
	
	char[2] = {
		x = 310,
		y = 196,
		w = 38,
		h = 60,
		r = 1.2,
		spd = 3,
		sprSh = love.graphics.newImage("/assets/spr/char2SPR.png"),
		sprShW = 280,
		sprShH = 60,
		frmD = 1,
		wTimr = 0,
		canMove = false,
		main = false,
	}
	
	char[2].frms = {
		love.graphics.newQuad(2,0,50,60,char[2].sprShW,char[2].sprShH),
		love.graphics.newQuad(54,0,56,60,char[2].sprShW,char[2].sprShH),
		love.graphics.newQuad(112,0,54,60,char[2].sprShW,char[2].sprShH),
		love.graphics.newQuad(168,0,54,60,char[2].sprShW,char[2].sprShH),
		love.graphics.newQuad(224,0,56,60,char[2].sprShW,char[2].sprShH),
	}
	
	world:add(char[2],char[2].x+5,char[2].y,char[2].w,char[2].h,playerFilter)
	
	char[3] = {
		x = 255,
		y = 300,
		w = 48,
		h = 60,
		spd = 3,
		r = 1.2,
		sprSh = love.graphics.newImage("/assets/spr/char3SPR.png"),
		sprShW = 280,
		sprShH = 60,
		frmD = 1,
		wTimr = 0,
		canMove = false,
		main = false,
	}
	
	char[3].frms = {
		love.graphics.newQuad(0,0,48,60,char[3].sprShW,char[3].sprShH),
		love.graphics.newQuad(50,0,48,60,char[3].sprShW,char[3].sprShH),
		love.graphics.newQuad(100,0,42,60,char[3].sprShW,char[3].sprShH),
		love.graphics.newQuad(144,0,48,60,char[3].sprShW,char[3].sprShH),
		love.graphics.newQuad(194,0,48,60,char[3].sprShW,char[3].sprShH),
		love.graphics.newQuad(244,0,42,60,char[3].sprShW,char[3].sprShH),
	}
	
	world:add(char[3],char[3].x,char[3].y,char[3].w,char[3].h,playerFilter)
	
	textD = true
	textAct = true
	
	bgNum = 1
	
	overworldMap = {
		{0,1,0},
		{0,2,0},
		{4,3,5},
	}
	
	overworldMapX = 2
	overworldMapY = 1
	
	currentroom = overworldMap[overworldMapY][overworldMapX]
	
	print(overworldMap[overworldMapY][2])
	
	rooms.update(currentroom)
	
	curScrn = 1
end

function game.draw()
	love.graphics.draw(bg[bgNum],BGoffset)
	
	if char[1].r == 0 and currentroom == 1 then
		love.graphics.draw(sleepinBags,BGoffset)
		
		love.graphics.setColor(255,255,255,150)
		
		love.graphics.draw(arrw2)
		
		love.graphics.setColor(255,255,255,255)
	end
	
	if currentroom == 2 then
		love.graphics.draw(screenSPR,screensFG[curScrn],107,36)
	end
	
	love.graphics.draw(char[1].sprSh,char[1].frms[char[1].frmD],char[1].x,char[1].y,char[1].r)
	
	love.graphics.draw(char[2].sprSh,char[2].frms[char[2].frmD],char[2].x,char[2].y,char[2].r)
	
	love.graphics.draw(char[3].sprSh,char[3].frms[char[3].frmD],char[3].x,char[3].y,char[3].r)
	
	if char[1].r ~= 0 then
		love.graphics.draw(sleepinBags,BGoffset)
	end
	
	if currentroom == 2 then
		love.graphics.draw(tableBG4)
	end
	
	love.graphics.setColor(cameraFilterColor)
	
	love.graphics.rectangle("fill",0,0,love.graphics.getWidth(),love.graphics.getHeight())
	
	love.graphics.setColor(255,255,255)
	
	if introExplosion then
		love.graphics.draw(supriseIcon,312+BGoffset,245,-0.2,0.5)
		love.graphics.draw(supriseIcon,290+BGoffset,175,0,0.6)
		love.graphics.draw(supriseIcon,228+BGoffset,280,0,0.6)
	end
	
	if textD then
		texty.draw()
	end
	
	if debugUIS then
		love.graphics.rectangle("line",char[1].x+10,char[1].y,char[1].w,char[1].h)
		love.graphics.rectangle("line",char[2].x+5,char[2].y,char[2].w,char[2].h)
		love.graphics.rectangle("line",char[3].x,char[3].y,char[3].w,char[3].h)
		drawBlocks()
	
		--love.graphics.print(love.mouse.getX()..","..love.mouse.getY())
		
		if NPCacting then
			love.graphics.print("NPCacting ON",0,20)
		else
			love.graphics.print("NPCacting ON",0,20)
		end
		
		love.graphics.print(currentroom)
		
		--love.graphics.print()
		
		--love.graphics.setLineWidth(10)
		
		love.graphics.line(0,rooms.getEndY2(currentroom),maxW,rooms.getEndY2(currentroom))
	end
end

function game.update(dt)
	-- if mainChar == 1 then
		-- char[1].canMove = true
		-- char[2].canMove = false
		-- char[3].canMove = false
	-- elseif mainChar == 2 then
		-- char[2].canMove = true
		-- char[1].canMove = false
		-- char[3].canMove = false
	-- elseif mainChar == 3 then
		-- char[3].canMove = true
		-- char[2].canMove = false
		-- char[1].canMove = false
	-- end
	
	char[mainChar].main = true
	
	if textAct then
		texty.update(dt)
	end
	
	characterMovement()
	
	introActions()
	
	if NPCacting then
		entityActionUpdate(NPCactingID)
	end
end

function introActions()
	if text.num == 4 and introExplosion == false then
		textAct = false
		textD = false
		timr = timr - 1
		if timr < 1 then
			bgNum = 2
			cameraFilterColor = {255,50,50,60}
			introExplosion = true
			timr = 0
		end
	end
	
	if introExplosion then
		timr = timr + 1
		
		if BGoffsetDir == 1 and BGoffset > BGoffsetLim then
			BGoffsetDir = -1
		elseif BGoffsetDir == -1 and BGoffset < BGoffsetLim * -1 then
			BGoffsetDir = 1
		end
		
		if BGoffsetDir == 1 then
			BGoffset = BGoffset + BGoffsetSPD
		elseif BGoffsetDir == -1 then
			BGoffset = BGoffset - BGoffsetSPD
		end
		if timr > 150 then
			introExplosion = false
			text.num = 5
			bgNum = 3
			cameraFilterColor = {100,0,0,100}
			love.graphics.setFont(textFont1BIG)
			textAct = true
			textD = true
			BGoffset = 0
		end
	end
	
	if text.num == 7 and textD == false then
		for i, v in ipairs(char) do
			local dy = 0
			if i ~= mainChar then
				if char[i].y < maxH + 100 then
					--char[i].y = char[i].y + char[i].spd
					dy = dy + char[i].spd
					
					cols = {}
					char[i].x, char[i].y, cols, cols_len = world:move(char[i], char[i].x, char[i].y + dy, playerFilter)
					
					char[i].wTimr = char[i].wTimr + 1
					if char[i].wTimr > 15 then
					
						char[i].frmD = char[i].frmD + 1
						if char[i].frmD > 3 then
							char[i].frmD = 2
						end
						
						love.graphics.setFont(textFont1)
						
						char[i].wTimr = 0
					
					end
				end
			end
		end
	end
	
	if gamestate == "gameIntro" then
		if char[mainChar].y + char[mainChar].h > rooms.getEndY1(currentroom) then
			changeRoom()
		end
		if char[mainChar].y + char[mainChar].h < rooms.getEndY2(currentroom) then
			changeRoom()
		end
	end
end

function changeRoom()
	if gamestate == "gameIntro" then
		if char[mainChar].y + char[mainChar].h > rooms.getEndY1(currentroom) then
			if overworldMap[overworldMapY+1] ~= nil then
				for _,block in ipairs(blocks) do
					world:remove(block)
					blocks[_] = nil
				end
				
				overworldMapY = overworldMapY + 1
				currentroom = overworldMap[overworldMapY][overworldMapX]
				
				char[mainChar].y = rooms.getStartY1(currentroom)
				
				world:update(char[mainChar],char[mainChar].x,char[mainChar].y)
				
				bgNum = rooms.getBG(currentroom)
				
				rooms.update(currentroom)
			end
		end
		if char[mainChar].y + char[mainChar].h < rooms.getEndY2(currentroom) then
			for _,block in ipairs(blocks) do
				world:remove(block)
				blocks[_] = nil
			end
			
			print(rooms.getEndY2(currentroom))
				
			overworldMapY = overworldMapY - 1
			currentroom = overworldMap[overworldMapY][overworldMapX]
			
			char[mainChar].y = rooms.getStartY2(currentroom)
			
			world:update(char[mainChar],char[mainChar].x,char[mainChar].y)
				
			bgNum = rooms.getBG(currentroom)
		
			rooms.update(currentroom)
		end
	end
end

function textActions()
	if text.num == 4 then
		textD = false
		textAct = false
		timr = 100
	end
	if text.num == 7 then
		textAct = false
		textD = false
		for i, v in ipairs(char) do
			char[i].r = 0
			if i == mainChar then
				char[i].canMove = true
			end
		end
	end
end

function characterMovement()
	for i,v in ipairs(char) do
		local dx, dy = 0, 0
		if char[i].canMove then
			if love.keyboard.isDown("right") then
				char[i].x = char[i].x + char[i].spd
				dx = dx + char[i].spd
				char[i].wTimr = char[i].wTimr + 1
				if char[i].wTimr > 15 then
					char[i].frmD = char[i].frmD + 1
					if char[i].frmD > 3 then
						char[i].frmD = 2
					end
					char[i].wTimr = 0
				end
			elseif love.keyboard.isDown("left") then
				char[i].x = char[i].x - char[i].spd
				dx = dx - char[i].spd
				char[i].wTimr = char[i].wTimr + 1
				if char[i].wTimr > 15 then
					char[i].frmD = char[i].frmD + 1
					if char[i].frmD > 5 then
						char[i].frmD = 4
					end
					char[i].wTimr = 0
				end
			end
			if love.keyboard.isDown("up") then
				char[i].y = char[i].y - char[i].spd
				dy = dy - char[i].spd
				if not love.keyboard.isDown("right") and not love.keyboard.isDown("left") then
					char[i].wTimr = char[i].wTimr + 1
					if char[i].wTimr > 15 then
						if char[i].frmD < 4 then
							char[i].frmD = char[i].frmD + 1
							if char[i].frmD > 3 then
								char[i].frmD = 2
							end
						end
						if char[i].frmD > 3 then
							char[i].frmD = char[i].frmD + 1
							if char[i].frmD > 5 then
								char[i].frmD = 4
							end
						end
							char[i].wTimr = 0
					end
				end
			elseif love.keyboard.isDown("down") then
				char[i].y = char[i].y + char[i].spd
				dy = dy + char[i].spd
				if not love.keyboard.isDown("right") and not love.keyboard.isDown("left") then
					char[i].wTimr = char[i].wTimr + 1
					if char[i].wTimr > 15 then
						if char[i].frmD < 4 then
							char[i].frmD = char[i].frmD + 1
							if char[i].frmD > 3 then
								char[i].frmD = 2
							end
						end
						if char[i].frmD > 3 then
							char[i].frmD = char[i].frmD + 1
							if char[i].frmD > 5 then
								char[i].frmD = 4
							end
						end
						char[i].wTimr = 0
					end
				end
			end
		end
		
		if dx ~= 0 or dy ~= 0 then
			cols = {}
			char[i].x, char[i].y, cols, cols_len = world:move(char[i], char[i].x + dx, char[i].y + dy, playerFilter)

			for i, v in ipairs(cols) do
				if v.other.class == "npc" then
					touchNPC = true
					NPCactingID = v.other.id
				end
				if v.other.class == "action" then
					touchAction = true
					actionID = v.other.id
				end
			end
			
			if #cols == 0 then
				touchNPC = false
				touchAction = false
				NPCactingID = 0
				actionID = 0
			end
		end
	end
end

function drawBlocks()
	for _,block in ipairs(blocks) do
		drawBox(block, 255,0,0)
	end
end

function drawBox(box, r,g,b)
	love.graphics.setColor(r,g,b,30)
	love.graphics.rectangle("fill", box.x, box.y, box.w, box.h)
	love.graphics.setColor(r,g,b)
	love.graphics.rectangle("line", box.x, box.y, box.w, box.h)
end