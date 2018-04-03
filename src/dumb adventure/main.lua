bump = require 'libraries.bump'

require "intro"
require "game"
require "text"
require "rooms"
require "entity"

function love.load()
	maxW, maxH = love.graphics.getDimensions()
	love.graphics.setDefaultFilter('nearest','nearest')
	textFont1 = love.graphics.newFont("/assets/misc/unlearne.ttf",30)
	love.graphics.setFont(textFont1)
	gamestate = "chrslct"
	assetLoad()
	rooms.load()
	game.load()
	texty.load()
	-- Character select variables --
	pX1 = 110
	pX2 = 280
	pX3 = 430
	pY1 = 150
	pY2 = 160
	pY3 = 140
	movX1 = 0
	movX2 = 0
	movX3 = 0
	movY1 = 0
	movY2 = 0
	movY3 = 0
	rot1 = 0
	rot2 = 0
	rot3 = 0
	dirX1 = love.math.random(1,100)
	dirY1 = love.math.random(1,100)
	dirX2 = love.math.random(1,100)
	dirY2 = love.math.random(1,100)
	dirX3 = love.math.random(1,100)
	dirY3 = love.math.random(1,100)
	spd1 = 0.5
	slctd = 1
	chrSLCTD = 0
	timr = 0
	introExplosion = false
	-- END OF THAT --
	
	debugUIS = false
end

function love.draw()
	love.graphics.setColor(255,255,255)
	if gamestate == "chrslct" then
		chrslctDraw()
	end
	if gamestate == "gameIntro" then
		game.draw()
	end
end

function love.update(dt)
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
	if gamestate == "chrslct" then
		chrslctUpdate()
	end
	if gamestate == "trans1" then
		timr = timr + 1
		if timr > 100 then
			gamestate = "gameIntro"
			timr = 0
		end
	end
	if gamestate == "gameIntro" then
		game.update(dt)
	end
end

function assetLoad()
	titleBG = love.graphics.newImage("/assets/title/titleBG.png")
	titleFG = love.graphics.newImage("/assets/title/titleFG.png")
	titleFG2 = love.graphics.newImage("/assets/title/titleFG1.png")
	char1Icon = love.graphics.newImage("/assets/spr/char1Icon.png")
	char2Icon = love.graphics.newImage("/assets/spr/char2Icon.png")
	char3Icon = love.graphics.newImage("/assets/spr/char3Icon.png")
	arrow1 = love.graphics.newImage("/assets/misc/misc1.png")
	
	local num = love.filesystem.getDirectoryItems("/assets/bg")
	
	bg = {}
	
	for i, v in ipairs(num) do
		bg[i] = love.graphics.newImage("/assets/bg/"..v)
	end
	
	sleepinBags = love.graphics.newImage("/assets/misc/sleepinBags.png")
	
	portsSPR = love.graphics.newImage("/assets/spr/portSPR.png")
	
	charPorts = {}
	
	charPorts = {
		love.graphics.newQuad(0,0,112,108,portsSPR:getWidth(),portsSPR:getHeight()),
		love.graphics.newQuad(112,0,112,108,portsSPR:getWidth(),portsSPR:getHeight()),
		love.graphics.newQuad(112*2,0,112,108,portsSPR:getWidth(),portsSPR:getHeight()),
		love.graphics.newQuad(112*3,0,112,108,portsSPR:getWidth(),portsSPR:getHeight()),
	}
	
	textBox = love.graphics.newImage("/assets/misc/textBox.png")
	
	supriseIcon = love.graphics.newImage("assets/misc/suprise.png")
	
	arrw2 = love.graphics.newImage("/assets/misc/misc2.png")
	
	tableBG4 = love.graphics.newImage("/assets/misc/tableBG4.png")
	
	screenSPR = love.graphics.newImage("/assets/misc/screenSPR.png")
	
	screensFG = {
		love.graphics.newQuad(0,0,93,44,screenSPR:getWidth(),screenSPR:getHeight()),
		love.graphics.newQuad(93,0,93,44,screenSPR:getWidth(),screenSPR:getHeight()),
		love.graphics.newQuad(0,44,93,44,screenSPR:getWidth(),screenSPR:getHeight()),
		love.graphics.newQuad(93,44,93,44,screenSPR:getWidth(),screenSPR:getHeight()),
	}
end

function love.keypressed(key)
	if gamestate == "chrslct" then
		if key == "up" or key == "left" then
			slctd = slctd - 1
			if slctd < 1 then
				slctd = 3
			end
		end
		if key == "down" or key == "right" then
			slctd = slctd + 1
			if slctd > 3 then
				slctd = 1
			end
		end
		if key == "return" then
			chrSLCTD = slctd
			mainChar = slctd
		end
	end
	if gamestate == "gameIntro" then
		if key == "right" then
			if mainChar == 1 and char[1].canMove then
				char[1].frmD = 2
				char[1].wTimr = 0
			elseif mainChar == 2 and char[2].canMove then
				char[2].frmD = 2
				char[2].wTimr = 0
			elseif mainChar == 3 and char[3].canMove then
				char[3].frmD = 1
				char[3].wTimr = 0
			end
		end
		if key == "left" then
			if mainChar == 1 and char[1].canMove then
				char[1].frmD = 4
				char[1].wTimr = 0
			elseif mainChar == 2 and char[2].canMove then
				char[2].frmD = 4
				char[2].wTimr = 0
			elseif mainChar == 3 and char[3].canMove then
				char[3].frmD = 4
				char[3].wTimr = 0
			end
		end
		
		if key == "1" then
			mainChar = 1
		end
		if key == "2" then
			mainChar = 2
		end
		if key == "3" then
			mainChar = 3
		end
		
		if textAct then
			if key == "space" or key == "return" then
				if text[text.num+1] ~= nil then
					if done then
						text.num = text.num + 1
						textActions()
						texty.resetLoad()
					end
				else
					return
				end
			end
		end
		
		if touchNPC then
			if key == "return" then
				if NPCacting == false then
					char[mainChar].canMove = false
					print("ACTING")
					done = false
					NPCacting = true
					touchNPC = false
					entityAction(NPCactingID)
				end
			end
		end
		
		if touchAction then
			if key == "return" then
				entityAction(actionID)
			end
		end
	end
	
	if key == "u" then
		if debugUIS then
			debugUIS = false
		else
			debugUIS = true
		end
	end
end

function addBlock(x,y,w,h)
	local block = {x=x,y=y,w=w,h=h}
	blocks[#blocks+1] = block
	world:add(block,x,y,w,h)
	world:update(block,x,y,w,h,'slide')
end

function addEntity(id)
	local x, y = getEntityPosition(id)
	local w, h = getEntityWidthHeight(id)
	local class = getEntityClass(id)
	local entity = {class=class,id=id,x=x,y=y,w=w,h=h}
	entity[#entity+1] = entity
	world:add(entity,x,y,w,h)
	world:update(entity,x,y,w,h,'slide')
end