karate = {} --Main karate function for file

function karate.load() --Main karate load function
	
	armoffset = 0 --Variable for armoffset in X plane
	
	headoffsetX = 0 --Variable for headoffset in X plane
	
	headoffsetY = 0 --Variable for headoffset in Y plane
	
	bodyoffsetX = 0 --Variable for bodyoffset in X plane
	
	bodyoffsetY = 0 --Variable for bodyoffset in Y plane
	
	headbop = 1 --Variable to control headbop
	
	bodybop = 1 --Variable to control bodybop
	
	punch = false --Variable to control if punching
	
	beat = 0 --Variable to control the beat
	
	xoffset = 90 --Variable offset for the whole Karate Man in X plane
	
	yoffset = 50 --Variable offset for the whole Karate Man in Y plane
	
	karate.spriteload()
	
	bgnum = 3
	
	bgtim = 0
	
	arm1num = 1
	
	arm1tim = 0
	
	arm1add = 1
	
	levelitems = {}
	
	bannerSPR = love.graphics.newImage("/spr/label1.png")
	
	banner = true
	
	bannertim = 0
	
	banst = 1
	
	punchSFX = {
		love.audio.newSource("/sound/sfx/karateman_punch1.wav"),
		love.audio.newSource("/sound/sfx/karateman_punch2.wav"),
		love.audio.newSource("/sound/sfx/karateman_punch2.wav"),
		love.audio.newSource("/sound/sfx/karateman_punch2.wav"),
	}
	
	hitSFX = {
		love.audio.newSource("/sound/sfx/karateman_punch1hit.wav"),
		love.audio.newSource("/sound/sfx/karateman_soccer_hit.wav"),
		love.audio.newSource("/sound/sfx/karateman_soccer_hit2.wav"),
		love.audio.newSource("/sound/sfx/karateman_punch1hit.wav"),
	}
	
	notesnum = 1
	
	bgtype = 0
	
	bgchange = 21.1
	
	state = ""
	
	fxD = false
	
	bgmusic:play()
	
	bgmusic:setVolume(0.5)
	
	headnum = 1
end

function karate.spriteload()
	karate_man = {
		head = {
			love.graphics.newQuad(2,2,68,68,1024,1024),
			love.graphics.newQuad(74,2,68,68,1024,1024),
			love.graphics.newQuad(73*2-1,1,70,70,1024,1024),
			love.graphics.newQuad(73*3-2,1,70,70,1024,1024),
			love.graphics.newQuad(73*4-3,1,70,70,1024,1024),
			love.graphics.newQuad(73*5-4,1,70,70,1024,1024),
		},
		arm1 = {
			love.graphics.newQuad(113+104+88+81,74,74,68,1024,1024), --#1
			love.graphics.newQuad(3,74,100,60,1024,1024), --#6
			love.graphics.newQuad(3,74,100,60,1024,1024), --#6
			love.graphics.newQuad(3,74,100,60,1024,1024), --#5
			love.graphics.newQuad(113,76,100,64,1024,1024), --#4
			love.graphics.newQuad(113+105,74,84,68,1024,1024), --#3
			love.graphics.newQuad(113+104+89,74,76,68,1024,1024), --#2
		},
		body = {
			love.graphics.newQuad(338,145,93,118,1024,1024),
			love.graphics.newQuad(338+96,146,91,116,1024,1024),
		},
		legs = {
			love.graphics.newQuad(2,73+73,68,108,1024,1024),
			love.graphics.newQuad(74,73+73,68,108,1024,1024),
			love.graphics.newQuad(531,148,81,114,1024,1024)
		},
	}
	
	bg = {
		love.graphics.newQuad(0,257,440,255,1024,512),
		love.graphics.newQuad(440,257,440,255,1024,512),
		love.graphics.newQuad(0,0,440,255,1024,512),
	}
	
	items = {
		love.graphics.newQuad(6,688,52,41,1024,1024),
		love.graphics.newQuad(85,758,43,43,1024,1024),
		love.graphics.newQuad(85,685,52,41,1024,1024),
		love.graphics.newQuad(6,688+70,52,41,1024,1024),
	}
	
	fx = {
		love.graphics.newQuad(375,790,60,40,1024,1024),
	}
end

function karate.draw()
	
	love.graphics.setColor(255,255,255)

	love.graphics.draw(sprs2,bg[bgnum])
	
	for i, v in ipairs(levelitems) do
		if v.layer == 1 then
			love.graphics.draw(sprs1,karate_man.legs[3],v.shdx,v.shdy,0,v.shdscl,v.shdscl)
			love.graphics.draw(sprs1,v.spr,v.x,v.y,v.rt,v.scl,v.scl,30,30)
		end
	end
	
	--360 200--
	love.graphics.draw(sprs1,karate_man.arm1[arm1num],37+xoffset,35+yoffset+armoffset)
	love.graphics.draw(sprs1,karate_man.legs[3],-15+xoffset,95+yoffset)
	love.graphics.draw(sprs1,karate_man.legs[3],22+xoffset,87+yoffset)
	love.graphics.draw(sprs1,karate_man.legs[1],-2+xoffset,85+yoffset)
	love.graphics.draw(sprs1,karate_man.legs[2],23+xoffset,75+yoffset)
	love.graphics.draw(sprs1,karate_man.body[2],0+xoffset+bodyoffsetX,30+yoffset+bodyoffsetY)
	love.graphics.draw(sprs1,karate_man.head[headnum],13+xoffset+headoffsetX,0+yoffset+headoffsetY)
	
	for i, v in ipairs(levelitems) do
		if v.layer == 0 or v.layer == 2 then
			love.graphics.draw(sprs1,karate_man.legs[3],v.shdx,v.shdy,0,v.shdscl,v.shdscl)
			love.graphics.draw(sprs1,v.spr,v.x,v.y,v.rt,v.scl,v.scl,30,30)
		end
	end
	
	if fxD then
		love.graphics.draw(sprs1,fx[1],180,60)
		love.graphics.draw(sprs1,fx[1],180+63,60+83,0,-1)
	end
	
	if headnum == 3 then
		love.graphics.draw(sprs1,fx[1],108,38)
	end
	
	if banner then

		love.graphics.setColor(255,255,255,bannertim)
		
		love.graphics.draw(bannerSPR,-10,20,0,0.4)
		
		love.graphics.printf(info,10,28,800,"left")
	
	end
	
	if pause then
		love.graphics.setColor(170,170,170,150)
		love.graphics.rectangle("fill",0,0,sw,sh)
	end
	
	love.graphics.setColor(255,255,255,255)
	
end

function karate.update(dt)

	if banst == 1 then
		bannertim = bannertim + 5
	end
	if bannertim > 600 then
		banst = 0
	end
	
	if bannertim > 0 and banst == 0 then
		bannertim = bannertim - 7
	end

	if bgmusic:tell() > notes[notesnum] and notesnum < #notes then
		love.audio.play(punchSFX[notesT[notesnum]])
		table.insert(levelitems,karate.itemMaker(notesT[notesnum]))
		notesnum = notesnum + 1
	end
	
	if notesnum == 20 then
		bgtype = 0
		bgnum = 3
	end
	
	if bgmusic:tell() > bgchange and bgmusic:tell() < bgchange + 1 and bgtype == 0 then
		bgtype = 1
	end
	
	beat = beat + 1
	
	if bgtype == 1 then
		bgtim = bgtim + 1
	end
	
	if beat > 20 then
	
		if headoffsetX < 5 and headbop == 1 then
			headoffsetX = headoffsetX + 1
			headoffsetY = headoffsetY + 1
			bodyoffsetY = bodyoffsetY + 1
			armoffset = armoffset + 1
		else
			headbop = 2
		end
	
		if headoffsetX > 1 and headbop == 2 then
			headoffsetX = headoffsetX - 1
			headoffsetY = headoffsetY - 1
			bodyoffsetY = bodyoffsetY - 1
			armoffset = armoffset - 1
		else
			headbop = 1
		end
		
		if headoffsetX < 2 and headbop == 1 then
			beat = 0
		end
	
	end
	
	if bgtype == 1 then
		if bgtim > 26.5 then
			bgnum = bgnum + 1
			if bgnum > 2 then
				bgnum = 1
			end
			bgtim = 0
		end
	end
	
	for i, v in ipairs(levelitems) do
		if v.layer == 0 then
			if v.x > 220 then
				v.x = v.x - v.spd1 + 0.5
			end
			if v.y > 100 then
				v.y = v.y - v.spd1 * v.spd1 / 3
			end
			if v.scl > 1 then
				v.scl = v.scl - 0.17
			else
				v.layer = 1
			end
			v.rt = v.rt - v.rtspd
		end
		if v.layer == 1 then
			if v.y < 178 then
				v.y = v.y + 1.07
				v.x = v.x- 0.005
				v.scl = v.scl - 0.01
				v.shdx = v.shdx + 0.32
				v.shdy = v.shdy - 0.02
				v.shdscl = v.shdscl - 0.01
				v.rt = v.rt - v.rtspd / 2
				if v.y < 140 and v.y > 120 then
					headnum = 3
				else
					headnum = 1
				end
			else
				v.deathTIM = v.deathTIM + 1
				if v.deathTIM > 20 then
					table.remove(levelitems,i)
				end
			end
		end
		if v.layer == 2 and v.pressed == 1 then
			if v.x < 500 then
				v.x = v.x + 12
				v.y = v.y + 0.05
				v.rt = v.rt + v.rtspd * 3
			else
				table.remove(levelitems,i)
			end
			if v.x > 302 then
				fxD = false
			end
		end
	end
	
	karate.punchANIM()
	
	if bgmusic:tell() > bgmusic:getDuration() - 0.5 then
		songnum = nil
		gamestate = "menu"
	end
end

function karate.punchANIM()
	if punch then
		arm1tim = arm1tim + 1
		
		if armoffset < 0 and arm1num > 2 then
			armoffset = armoffset + 1
		end
		
		if headoffsetY > 0 then
			headoffsetY = headoffsetY - 1
		end
		
		if bodyoffsetY > 0 then
			bodyoffsetY = bodyoffsetY - 1
		end
		
		if bodyoffsetX > 0 then
			bodyoffsetX = bodyoffsetX - 1
		end
		
		if arm1tim > 1 then
			if arm1num > 6 then
				arm1num = 0
				punch = false
			end

			arm1num = arm1num + arm1add
			arm1tim = 0
		end
	end
end

function karate.itemMaker(num)
	local v = {}
	v.num = num
	v.spr = items[num]
	v.x = 300
	v.y = 230
	v.scl = 5
	v.rt = love.math.random(-2,2)
	v.rtspd = love.math.random(0.05,0.08)
	v.spd1 = 5
	v.shdscl = 0.6
	v.shdx = v.x-100
	v.shdy = v.x - 101.5
	v.coffset = 0
	v.layer = 0
	v.pressed = 0
	v.deathTIM = 0
	return v
end