require "karate" --Requires the karate.lua where all the ingame stuff is made
require "music" --Requires the music.lua where all the music level stuff is made
require "menu" --Requires the menu.lua where all the menu stuff is handeled

function love.load()
	files = love.filesystem.getDirectoryItems("/Music/") --Reads all files in the 'Music' folder where song levels are stored
	songnum = nil --Makes songmap a nil variable
	nosongmap = false --Initilizes variable for when no song map is detected
	pause = false --Variable for pausing game
	menu.load() --Loads the load function in menu.lua
	local width, height = love.graphics.getDimensions() --Initilizes variables for screen size (For Android)
	sx = width/400 --Screen width
	sy = height/240 --Screen height
	gamestate = "start" --Variable that controls gamestate
end

function love.draw()
	if love.system.getOS() == "Android" then --If device is Android
		love.graphics.scale(sx,sy) --Scale the graphics to screen
	end
	if gamestate == "start" or gamestate == "menu" then --If gamestate is start or menu then draw the draw function in menu.lua
		menu.draw() --Main drawing function in menu.lua
	end
	if gamestate == "game" then --If gamestate is game
		karate.draw() --Draw main drawing function from karate.lua
	end
end

function love.update(dt)
	if gamestate == "game" then --If gamestate is game
		if pause == false then --And pause is false
			karate.update(dt) --Update main update function in karate.lua
		end
	end
	if gamestate == "start" or gamestate == "menu" then --If gamestate is start or menu
		menu.update(dt) --Update main update function in menu.lua
	end
end

function love.keypressed(key)
	--Escape button actions--
	if key == "escape" then --If key escape pressed
		if gamestate == "start" then --And gamestate is start
			love.event.quit() --Quit game
		end
		if gamestate == "menu" then --And gamestate is menu
			gamestate = "start" --Make gamestate start
		end
		if gamestate == "game" then --And gamestate is game
			if pause then --And pause is true
				pause = false --Change pause to false
				bgmusic:play() --Play the background music
			else --If pause is false
				pause = true --Change pause to true
				bgmusic:pause() --Pause the background music
			end
		end
	end
	--Fast game quit--
	if key == "q" then --If key pressed is Q
		love.event.quit() --Exit program
	end
	--In game punching when space is pressed--
	if gamestate == "game" and pause == false then --If gamestate is game and pause is false
	if key == "space" and punch == false or key == "z" and punch == false then --And if key pressed is space and punch is false or key pressed is Z and punch is false
		arm1num = 2 --Make arm1num 2 (Change arm frame to frame 2)
		punch = true --Make punch variable true
		
		for i, v in ipairs(levelitems) do --For every levelitems
		if notesnum ~= 1 then --If notesnum isnt 1
		if bgmusic:tell() < notes[notesnum-1] + 0.5 and bgmusic:tell() > notes[notesnum-1] + 0.38 then --If bgmusic is smaller than current note number plus 0.5 and bgmusic is bigger than current note number + 0.38
			state = "pressed" --Make state pressed
			fxD = true --Draw FX true
			if v.y < 110 then --If item Y is smaller than 110
				v.pressed = 1 --Item pressed is 1
				v.layer = 2 --Item layer is 2
			end
			hitSFX[notesT[notesnum-1]]:play() --Play hit FX
		else --If it didnt press at that time
			state = "missed" --Make state missed
		end
		end
		end
		
		headoffsetY = 8 --Move head 8 pixels down
		armoffset = -11 --Move arm 11 pixels left
		bodyoffsetX = 3 --Move body 3 pixels right
		bodyoffsetY = 5 --Move body 5 pixels down
	end
	end
	--Debug item tester--
	if key == "a" then --If key is A
		table.insert(levelitems,karate.itemMaker(1)) --Insert item
	end
	--Keyboard shortcut for menu--
	if gamestate == "start" and key == "space" then --If gamestate is start and key pressed is space
		gamestate = "menu" --Make gamestate menu
	end
	--Mute audio--
	if key == "m" and gamestate == "game" then --If key pressed is M and gamestate is game
		bgmusic:setVolume(0) --Set gackground menu to 0
	end
end

function love.mousepressed(x,y,button)
	--In game punching when screen pressed (touch)--
	if button == 1 and punch == false and gamestate == "game" and pause == false then --If mouse button is 1 and punch is false and gamestate is game and pause is false
		arm1num = 2 --Make arm1num 2 (Change arm frame to frame 2)
		punch = true --Make punch variable true
		
		for i, v in ipairs(levelitems) do --For every levelitems
		if notesnum ~= 1 then --If notesnum isnt 1
		if bgmusic:tell() < notes[notesnum-1] + 0.5 and bgmusic:tell() > notes[notesnum-1] + 0.38 then --If bgmusic is smaller than current note number plus 0.5 and bgmusic is bigger than current note number + 0.38
			state = "pressed" --Make state pressed
			fxD = true --Draw FX true
			if v.y < 110 then --If item Y is smaller than 110
				v.pressed = 1 --Item pressed is 1
				v.layer = 2 --Item layer is 2
			end
			hitSFX[notesT[notesnum-1]]:play() --Play hit FX
		else --If it didnt press at that time
			state = "missed" --Make state missed
		end
		end
		end
		
		headoffsetY = 8 --Move head 8 pixels down
		armoffset = -11 --Move arm 11 pixels left
		bodyoffsetX = 3 --Move body 3 pixels right
		bodyoffsetY = 5 --Move body 5 pixels down
	end
	--Select song in menu when press song--
	if button == 1 and x > 0 and y > (sh/2)-32 and y < ((sh/2)-32)+50 and songnum == nil then --If mouse button is 1 and mouse X is bigger than 0 and mouse Y is bigger than screen height divided by 2 minus 32 and mouse Y is smaller than screen height divided by 2 minus 32 plus 50
		songnum = sngslctd --Soung num equals sngslctd
			if checkFolder() then --If the checkFolder function in music.lua is true
				nosongmap = false --Nosongmap is false
				music.load() --Load main load function from music.lua
				karate.load() --Load main load function from karate.lua
				gamestate = "game" --Change gamestate game
			else
				nosongmap = true --Nosongmap is true
				songnum = nil --Songnum is nil
			end
			print(songnum) --Print songnum to console
	end
end


























