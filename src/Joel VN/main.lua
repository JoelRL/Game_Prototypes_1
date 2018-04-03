require "game"
require "text"
require "names"

function love.load()
	game.load()
	gamestate = "loading"
	debugin = false
	maxW, maxH = love.graphics.getDimensions()
	sx = maxW/1170
	sy = maxH/720
	
	waitTimr = 0
	loadingTimr = 1
	
	font = love.graphics.newFont("/assets/misc/font1.ttf",45)
	love.graphics.setFont(font)
end

function love.draw()
	
	if love.system.getOS() == "Windows" then
		love.graphics.scale(sx,sy) --Scale the graphics to screen
	end
	
	if gamestate == "loading" then
		love.graphics.print("LOADING...",0,0)
	end
	
	if fadeout then
		love.graphics.setColor(255,255,255,demoAL)
	else
		love.graphics.setColor(255,255,255,255)
	end
	
	if gamestate ~= "loading" then
		game.draw()
	end
	
	--DEBUG--
	if debugin == true then
		love.graphics.setColor(0,0,0)
		love.graphics.print(love.mouse.getX().." | "..love.mouse.getY(),0,0)
		if stimer == true then
			love.graphics.print("Timer1 ACTIVE",0,15)
		else
			love.graphics.print("Timer1 IDLE",0,15)
		end
	end
	love.graphics.setColor(255,255,255)
end

function love.update(dt)

	if gamestate == "loading" then
		waitTimr = waitTimr + 1
		if waitTimr > 10 then
			game.AssetLoading()
		end
	end
	
	if gamestate ~= "loading" then
		game.update(dt)
	end
	
	--DEBUG--
	if love.keyboard.isDown("d") then
		if debugin == true then
			debugin = false
		else
			debugin = true
		end
	end
	---------
end