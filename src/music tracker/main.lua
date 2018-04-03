require "UI"

function love.load()

	UI.load()

	soundNUM = love.filesystem.getDirectoryItems("/sound/")

	sounds = {}

	for i=1, #soundNUM do
		sounds[i] = love.audio.newSource("/sound/snd_"..i..".mp3")
	end
	
	instruments = {
		"boop",
		"snare",
		"bass snare",
		"cymbal",
		"trumpet",
	}
	
	timer = 0
	
	maxW = love.graphics.getWidth()
	
	maxH = love.graphics.getHeight()
	
	mode1 = 1
	
	notetype = 1
	
	currntpitch = 1
	
	limit = 54
	
	lastnotepitch = 1
	
	bgcolor = 0
	
	bgalph = 150
	
	mute = false
	
	test = nil
	
	songN = {}
	
	songT = {}
	
	songP = {}
	
	a = 1
	
	dir = love.filesystem.getSaveDirectory()
	
	save = false
	
	sngs = love.filesystem.getDirectoryItems(dir)
	
	print(#sngs)
	
	print(dir)
	
	touchscreenAL = 255
	
	tchscreenT = 0
	
	tchscreenD = true
	
	
end

function love.draw()
	if bgcolor ~= 0 then
		love.graphics.draw(spr_1,guy[guynum],maxW/2-20,30,0,0.2)
	end

	if playIN then
		if bgcolor == 1 then
			love.graphics.setColor(200,200,200,bgalph)
		elseif bgcolor == 2 then
			love.graphics.setColor(50,100,50,bgalph)
		elseif bgcolor == 3 then
			love.graphics.setColor(50,50,100,bgalph)
		elseif bgcolor == 4 then
			love.graphics.setColor(50,50,50,bgalph)
		elseif bgcolor == 5 then
			love.graphics.setColor(200,200,60,bgalph)
		end
		if bgcolor == 0 then
			love.graphics.setColor(0,0,0,255)
		end
	else
		love.graphics.setColor(0,0,0,255)
	end
	
	love.graphics.rectangle("fill",0,0,maxW,320)

	love.graphics.setColor(255,255,255)
	
	for i=1, numofslots do
		if timer*10 > (10*i*3)-7 and timer*10 < (10*i*3)-7 + 5 then
			for k, b in ipairs(notes) do
				if b.slot == i then
					b.hit = true
					lastnotepitch = b.ptch
					bgcolor = b.typ
				end
			end
			if slotNotes[i] ~= 0 and playIN then
				for k, b in ipairs(notes) do
					if b.slot == i then
					sounds[slotNotes[i]]:setPitch(b.ptch)
					end
				end
				sounds[slotNotes[i]]:play()
				guyD = true
			else
				guyD = false
			end
		end
	end
	
	UI.draw()

	love.graphics.setColor(255,255,255,255)
	
end

function love.update(dt)
	
	if tchscreenD then
		tchscreenT = tchscreenT + 1
		if tchscreenT > 80 then
			touchscreenAL = touchscreenAL - 2
			if touchscreenAL < 0 then
				tchscreenD = false
				touchscreenAL = nil
				tchscreenD = nil
				tchscreenT = nil
			end
		end
	end
	
	if save then
		newONE = love.filesystem.newFile("eting.txt")
	
		newONE:open("w")
	
		for i, v in ipairs(notes) do
			if v.slot < 10 then
				newONE:write("=0"..v.slot..":0"..v.typ.."")
				if v.ptch == 1 or v.ptch == 2 or v.ptch == 3 or v.ptch == 4 or v.ptch == 5 or v.ptch == 6 or v.ptch == 7 or v.ptch == 8 then
					newONE:write("-"..v.ptch..".0\r\n")
				end
				if v.ptch ~= 1 or v.ptch ~= 2 or v.ptch ~= 3 or v.ptch ~= 4 or v.ptch ~= 5 or v.ptch ~= 6 or v.ptch ~= 7 or v.ptch ~= 8 then
					newONE:write("-"..v.ptch.."\r\n")
				end
			else
				newONE:write("="..v.slot..":0"..v.typ.."")
				if v.ptch == 1 or v.ptch == 2 or v.ptch == 3 or v.ptch == 4 or v.ptch == 5 or v.ptch == 6 or v.ptch == 7 or v.ptch == 8 then
					newONE:write("-"..v.ptch..".0\r\n")
				end
				if v.ptch ~= 1 or v.ptch ~= 2 or v.ptch ~= 3 or v.ptch ~= 4 or v.ptch ~= 5 or v.ptch ~= 6 or v.ptch ~= 7 or v.ptch ~= 8 then
					newONE:write("-"..v.ptch.."\r\n")
				end
			end
		end
	
		newONE:flush()
	
		newONE:close()
		
		save = false
	end
	
	if bgcolor ~= 0 then
		bgalph = bgalph - 6.2
		if bgalph < 0 then
			bgcolor = 0
			bgalph = 150
		end
	end

	UI.update(dt)

	if playIN then
		timer = timer + 0.12
	end
	
	if timer > limit then
		if mode1 == 1 then
			timer = 0
		elseif mode1 == 0 then
			timer = 0
			playIN = false
		end
	end
	if love.keyboard.isDown("escape") then
		love.event.quit()
	end
	if clearALL then
		while #notes ~= 0 do
			table.remove(notes)
			for i=1, 17 do
				slots[i] = false
				slotNotes[i] = 0
			end
		end
		clearALL = false
	end
	if love.keyboard.isDown("right") and timer < 53.5 then
		timer = timer + 0.5
	end
	if love.keyboard.isDown("left") and timer > 0.5 then
		timer = timer - 0.5
	end
end

function love.filedropped( file )
	song = file
	test = song:read()
	local f = string.find(test, "=",1,true)
	while f ~= nil do
		local t = tonumber(string.sub(test,f+1,f+2)) 
		songT[a] = t
		a = a + 1
		f = string.find(test, "=",f+5,true)
	end
	local d = string.find(test, ":",1,true)
	a = 1
	while d ~= nil do
		local n = tonumber(string.sub(test,d+1,d+2))
		songN[a] = n
		a = a + 1
		d = string.find(test, ":",d+5,true)
	end
	local p = string.find(test, "-",1,true)
	a = 1
	while p ~= nil do
		local c = tonumber(string.sub(test,p+1,p+3))
		songP[a] = c
		a = a + 1
		p = string.find(test, "-",p+5,true)
	end
	
	for i = 1, 17 do
		if songN[i] ~= 0 then
		table.insert(notes,addNote((10*i*3)-7,i,songN[i],songP[i]))
		slotNotes[i] = songN[i]
		slots[i] = true
		end
	end
	
	a = 1
end

function love.keypressed(key)
	for i=1, #soundNUM do
		if key == ""..i.."" then
			notetype = i
			sounds[i]:play()
		end
	end
	if key == "delete" then
		clearALL = true
	end
	
	if key == "s" then
		save = true
	end
	
	if key == "up" then
		currntpitch = currntpitch + 0.1
	end
	if key == "down" and currntpitch > 0.2 then
		currntpitch = currntpitch - 0.1
	end
	
	if key == "space" then
		if mode1 == 1 then
			if playIN then
				playIN = false
				timer = 0
				guynum = 3
			else
				playIN = true
				guynum = 1
			end
		else
			if playIN then
				playIN = false
				guynum = 1
			else
				playIN = true
				guynum = 3
			end
		end
	end
	if key == "z" then
		if mode1 == 1 then
			mode1 = 0
		else
			mode1 = 1
		end
	end
	if key == "m" then
		if mute then
			love.audio.setVolume(1)
			mute = false
		else
			love.audio.setVolume(0)
			mute = true
		end
	end
end