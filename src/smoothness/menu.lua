menu = {}

function menu.load()
	sw, sh = love.graphics.getDimensions()
	BGM = love.graphics.newImage("/spr/menuBG.png")
	titleBG = love.graphics.newImage("/spr/titleBG.png")
	arrow1 = love.graphics.newImage("/spr/arrow1.png")
	
	cooldown = false
	cooldownT = 0
	sngslctd = 1
	lkey = 0
	menuoffset = 0
end

function menu.draw()
	if gamestate == "start" then
		love.graphics.setNewFont(20)
		love.graphics.setColor(255,255,255)
		love.graphics.draw(titleBG,0,0,0,0.5)
		love.graphics.setColor(255,100,100,220)
		love.graphics.rectangle("fill",sw/2-110/2,sh/2+10,110,40,10,10)
		love.graphics.rectangle("fill",sw/2-90/2,sh/2+60,90,40,10,10)
		love.graphics.rectangle("line",sw-50,sh-50,40,40)
		love.graphics.setColor(0,0,0)
		love.graphics.print("start",sw/2-25,sh/2+18)
		love.graphics.print("quit",sw/2-20,sh/2+68)
		love.graphics.setNewFont(12)
		love.graphics.print("By Joel Rodiel-Lucero 2017",(sw/2)-70,sh-15)
	end
	if gamestate == "menu" then
		love.graphics.setColor(255,255,255)
		love.graphics.draw(BGM,0,0,0,0.5)
		for i, v in ipairs(files) do
			if i == sngslctd then
				love.graphics.setColor(255,255,255,230)
			else
				love.graphics.setColor(150,150,150,180)
			end
			if i ~= 1 then
				love.graphics.rectangle("fill",130,((90*i)-2*i)+menuoffset,150,50,3,3)
			else
				love.graphics.rectangle("fill",130,(90*i)+menuoffset,150,50,3,3)
			end
			love.graphics.setNewFont(12)
			love.graphics.setColor(0,0,0)
			if i ~= 1 then
				love.graphics.print("Title: "..v,133,((100*i)-10*i)+menuoffset)
			else
				love.graphics.print("Title: "..v,133,(90*i)+menuoffset)
			end
		end
		if nosongmap then
			love.graphics.print("Cant load song, missing files...",0,sh-20)
		end
		if love.system.getOS() == "Android" then
			love.graphics.draw(arrow1,(sw/2)-10,(sh/2)-87,0,0.05)
			love.graphics.draw(arrow1,(sw/2)+30,(sh/2)+80,0,-0.05,-0.05)
		end
	end
end

function menu.update(dt)
	if love.mouse.isDown(1) then
		if gamestate == "start" then
		if love.mouse.getX() > sw/2-110/2 and love.mouse.getX() < (sw/2-110/2)+110 and love.mouse.getY() > sh/2+10 and love.mouse.getY() < (sh/2+10)+40 then
			gamestate = "menu"
		end
		if love.mouse.getX() > sw/2-90/2 and love.mouse.getX() < (sw/2-90/2)+90 and love.mouse.getY() > sh/2+60 and love.mouse.getY() < (sh/2+60)+40 then
			love.event.quit()
		end
		if love.mouse.getX() > sw-50 and love.mouse.getX() < sw-10 and love.mouse.getY() > sh-50 and love.mouse.getY() < sh-10 then
			print("settings")
		end
		end
	end
	if gamestate == "menu" then
		if love.keyboard.isDown("down") and sngslctd < #files and cooldown == false or love.mouse.isDown(1) and love.mouse.getY() > (sh/2)+22 and sngslctd < #files and cooldown == false then
			lkey = 1
			cooldown = true
		end
		if love.keyboard.isDown("up") and sngslctd > 1 and cooldown == false or love.mouse.isDown(1) and love.mouse.getY() < (sh/2)-32 and sngslctd > 1 and cooldown == false then
			lkey = 2
			cooldown = true
		end
		if cooldown then
			cooldownT = cooldownT + 1
			if lkey == 1 then
				menuoffset = menuoffset - 4.2
			end
			if lkey == 2 then
				menuoffset = menuoffset + 4.2
			end
			if cooldownT > 20 then
				if lkey == 1 then
					sngslctd = sngslctd + 1
				elseif lkey == 2 then
					sngslctd = sngslctd - 1
				end
				cooldown = false
				cooldownT = 0
			end
		end
		if love.keyboard.isDown("return") and songnum == nil and cooldown == false then
			songnum = sngslctd
			if checkFolder() then
				nosongmap = false
				music.load()
				karate.load()
				gamestate = "game"
			else
				nosongmap = true
				songnum = nil
			end
			print(songnum)
		end
	end
end

--Checks if all file data is there and not missing--
function checkFolder()
	if love.filesystem.isFile("/Music/"..files[songnum].."/notes.txt") --If note file exists
	and love.filesystem.isFile("/Music/"..files[songnum].."/info.txt") --And info file exists
	and love.filesystem.isFile("/Music/"..files[songnum].."/bgmusic.mp3") --And bgmusic file exists
	and love.filesystem.isFile("/Music/"..files[songnum].."/spr/karate_man.png") --And sprite sheet #1 file exists
	and love.filesystem.isFile("/Music/"..files[songnum].."/spr/karate_BG.png") then  --And sprite sheet #2 file exists
		return true --Return function true
	else
		return false --Return function false
	end
end