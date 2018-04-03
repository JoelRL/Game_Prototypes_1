game = {}

function game.load()
	BG = {}
	BG.num = 1
	BG.scale = 2.6
	BG.y = 0
	CHAR = {}
	CHAR.num = 1
	CHAR.draw = flase
	CHAR.s = 1.5
	CHAR.x = 370
	CHAR.y = 0
	stimer = false
	timerE = 0
	textboxD = false
	textS = false
	titleAudio = 1.0
	bg1Audio = 0.8
	bg2Audio = 0.8
	fadeout = false
	demoAL = 255
	
	texty.load()
end

function game.AssetLoading()
	
	if loadingTimr == 1 then
		-- BG MUSIC LOADING --
		bgM = {}
		
		local songs1 = love.filesystem.getDirectoryItems("/assets/sound/bg/")
		
		for i=1, #songs1 do
			bgM[i] = love.audio.newSource("/assets/sound/bg/bg"..i..".mp3")
		end
		
		loadingTimr = 2
	end
	
	if loadingTimr == 2 then
		-- SFX LOADING --
		sfxS = {}
		
		local sfxN1 = love.filesystem.getDirectoryItems("/assets/sound/sfx/")
		
		for i=1, #sfxN1 do
			sfxS[i] = love.audio.newSource("/assets/sound/sfx/sfx"..i..".mp3")
		end
	
		loadingTimr = 3
		
	end

	if loadingTimr == 3 then
		-- BG IMAGES LOADING --
		local images = love.filesystem.getDirectoryItems("/assets/bg/")
		
		local num = 1
		local suf = "jpg"
		local data = {}
		
		for i, v in ipairs(images) do
			local t = {}
			local num = string.match(v,"%d+")
			
			t.num = tonumber(num)
			
			if string.find(v,"png") then
				t.suf = "png"
			elseif string.find(v,"jpg") then
				t.suf = "jpg"
			end
			
			table.insert(data,t)
		end
		
		local suf = ""
		
		for i=1, #images do
		
			for k, v in ipairs(data) do
				if v.num == i then
					suf = v.suf
				end
			end
			
			print("bg #"..i.." is a "..suf)
			
			BG[i] = love.graphics.newImage("/assets/bg/bg"..i.."."..suf)
		end
		
		loadingTimr = 4
	end
	
	if loadingTimr == 4 then
		-- CHAR IMAGE LOADING --
		CHAR[1] = love.graphics.newImage("/assets/chars/joel.png")
		CHAR[2] = love.graphics.newImage("/assets/chars/joel2.png")
		CHAR[3] = love.graphics.newImage("/assets/chars/evil.png")
		
		-- MISC IMAGE LOADING --
		title = love.graphics.newImage("/assets/misc/title.png")
		desu = love.graphics.newImage("/assets/misc/desu.png")
		start = love.graphics.newImage("/assets/misc/start.png")
		textbox = love.graphics.newImage("/assets/misc/textbox.png")
		
		-- MISC LOADING --
		titleM = love.audio.newSource("/assets/sound/titleM.mp3")
		titleM:setVolume(titleAudio)
		bgM[1]:setVolume(bg1Audio)
		bgM[2]:setVolume(bg2Audio)
			
		loadingTimr = 5
	end
	
	if loadingTimr == 5 then
		gamestate = "title"
		
		loadingTimr = nil
		
		waitTimr = 0
	end
end

function game.draw()
	game.BGDraw()
	if textS == true then
		if fadeout then
			love.graphics.setColor(255,255,255,demoAL)
		else
			love.graphics.setColor(255,255,255,255)
		end
		texty.draw(dt)
	end
end

function game.update(dt)

	if textS == true then
		texty.update(dt)
	end
	game.timer1()
	game.events()
	if gamestate == "title" then
		love.audio.play(titleM)
	else
		titleAudio = titleAudio - 0.01
		if titleAudio < 0 then
			titleM:stop()
		end
	end
	if text.num > 22 and text.num < 25 then
		if bg2Audio > 0 then
	  bg2Audio = bg2Audio - 0.01
	 else
	  bgM[2]:stop()
	 end
	end
	titleM:setVolume(titleAudio)
end

function game.BGDraw()
	if fadeout then
		love.graphics.setColor(255,255,255,demoAL)
	else
		love.graphics.setColor(255,255,255,255)
	end
	love.graphics.draw(BG[BG.num],0,BG.y,0,BG.scale)
	if gamestate == "title" then
		love.graphics.draw(title,80,60,0,1.6)
		love.graphics.draw(desu,890,300,0,1.3)
		love.graphics.draw(start,430,500,0,0.6)
	end
	game.charDraw()
	if textboxD == true then
		if fadeout then
			love.graphics.setColor(255,255,255,demoAL)
		else
			love.graphics.setColor(255,255,255,255/1.5)
		end
		love.graphics.draw(textbox,30,465,0,1.4)
		love.graphics.draw(textbox,48,407,0,0.4)
	end
end

function game.charDraw()
	if CHAR.draw == true then
		love.graphics.draw(CHAR[CHAR.num],CHAR.x,CHAR.y,0,CHAR.s)
	end
end

function love.keyreleased(key)
    if key == "a" then
        text.num = 58
        texty.resetLoad()
    end
	if key == "escape" then
		love.event.quit()
	end
	if key == "space" and gamestate == "title" then
		gamestate = "start"
		BG.num = BG.num + 1
		stimer = true
		timerE = 150
	end
end

function love.mousepressed(x,y,button)
	if gamestate == "title" then
		gamestate = "start"
		BG.num = BG.num + 1
		stimer = true
		timerE = 150
	end
	if done == true and string.len(text[text.num+1]) ~= nil then
      	text.num = text.num + 1
	    texty.resetLoad()
		if text.num == 16 or text.num == 47 then
		    sfxS[3]:play()
		end
		if text.num == 31 then
			sfxS[2]:play()
		end
		if text.num == 36 then
			sfxS[1]:play()
		end
	end
end

function game.timer1()
	if stimer == false then
		timer = 0
		sdone = false
	end
	if stimer == true and loadingDone ~= nil then
		timer = timer + 1
		if timer > timerE then
			game.timerAction()
			stimer = false
			sdone = true
		end
	end
end

function game.timerAction()
	if BG.num == 2 then
		BG.scale = 1
		BG.num = 3
	end
	if BG.num == 3 and text.num < 10 then
		textboxD = true
		textS = true
	end
end

function game.events()
	if BG.num == 3 and stimer == false and sdone == true then
		stimer = true
		timerE = 100
		bgM[1]:play()
	end
	if text.num == 6 then
		CHAR.draw = true
		bgM[1]:stop()
		love.audio.play(bgM[2])
	end
	if text.num == 14 then
		CHAR.draw = false
	end
	if text.num == 19 then
	 BG.num = 4
	 BG.scale = 0.6
	 BG.y = -180
	end
	if text.num == 23 then
	 BG.num = 2
	 bgM[1]:stop()
	end
	if text.num == 24 then
	 BG.num = 5
	 BG.y = 0
	 BG.scale = 2.5
	end
	if text.num == 25 then
	 BG.num = 6
	 BG.scale = 4.3
	 bgM[3]:setVolume(1.0)
	 bgM[3]:play()
	end
	if text.num == 31 then
	 CHAR.s = 6
	 CHAR.x = -300
	 CHAR.y = -450
	 titleM:stop()
	 bgM[3]:stop()
	end
	if text.num == 33 then
	 BG.num = 4
	 BG.scale = 0.6
	 BG.y = -180
	 CHAR.draw = false
	end
	if text.num == 36 then
	 BG.num = 7
	 BG.scale = 0.6
	 BG.y = -180
	end
	if text.num == 37 then
	 bgM[4]:play()
	end
	if text.num == 38 then
	 BG.num = 8
	 BG.scale = 1.1
	 BG.y = 0
	end
	if text.num == 39 then
	 BG.num = 9
	 BG.scale = 1.3
	end
	if text.num == 40 then
	 BG.num = 10
	 BG.scale = 1.1
	end
	if text.num == 41 then
	 BG.num = 2
	end
	if text.num == 42 then
	 BG.num = 4
	 BG.scale = 0.6
	 BG.y = -180
	 bgM[4]:stop()
	 bgM[5]:play()
	end
	if text.num == 50 then
	 BG.num = 8
	 BG.scale = 1.1
	 BG.y = 0
	 bgM[5]:stop()
	end
	if text.num == 51 then
	 CHAR.draw = true
	 CHAR.s = 1.5
	 CHAR.x = 370
	 CHAR.y = 0
	 bgM[2]:play()
	end
	if text.num == 57 then
	 CHAR.num = 2
	end
	if text.num == 58 then
	 CHAR.draw = false
	end
	if text.num == 61 then
	 CHAR.num = 3
	 CHAR.s = 1
	 CHAR.draw = true
	end
	if text.num == 64 then
	 
	end
end