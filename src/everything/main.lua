shapes = require "libs.HC.shapes"
require 'player'
require 'world_controller'

function love.load()
	-- Player load function --
	loadPlayerStats()
	
	-- World collisions --
	colls = {}
	objects = {}
	
	-- Miscellaneous --
	love.graphics.setLineWidth(2)
	showColls = false
	love.graphics.setBackgroundColor(50,100,50)
	
	-- Level loading --
	newObject(1,120,50)
	newObject(1,200,60)
	newObject(2,100,180)
	newObject(3,200,220)
	newObject(4,150,300)
end

function love.draw()
	
	-- Objects drawing at depth -1 --
	for i, v in ipairs(objects) do
		if v.depth == -1 then
			
			if v.center == 1 then
				love.graphics.draw(v.img,v.x,v.y,v.rotate,1,1)
			elseif v.center == 0 then
				love.graphics.draw(v.img,v.x,v.y,v.rotate,1,1,v.w/2,v.h/2)
			end
			
		end
	end
	
	-- Player draw function --
	drawPlayer()
	
	-- Objects drawing at depth 1 --
	for i, v in ipairs(objects) do
		if v.depth == 1 then
			
			if v.center == 1 then
				love.graphics.draw(v.img,v.x,v.y,v.rotate,1,1)
			elseif v.center == 0 then
				love.graphics.draw(v.img,v.x,v.y,v.rotate,1,1,v.w/2,v.h/2)
			end
			
		end
	end
	
	if showColls then
		-- Collisions drawing --
		for i, v in ipairs(colls) do
		
			if player.collWithSolid_ID == i then
				love.graphics.setColor(252,0,0,50)
				v.shape:draw("fill")
			end
		
			love.graphics.setColor(252,0,0,200)
			v.shape:draw("line")
		end
	end
	
	love.graphics.setColor(252,252,252)
end

function love.update(dt)
	-- Player update function --
	playerUpdate()

	-- Exit function --
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
end

function love.keypressed(key)

	player_keypress(key)

	if key == "tab" then
		if showColls then
			showColls = false
		else
			showColls = true
		end
	end
end