UI = {}

function UI.load()
	notes = {}
	
	nonote = nil
	
	slotNotes = {}
	
	slots = {}
	
	notePitch = {}
	
	for i=1, 17 do
		slots[i] = false
		slotNotes[i] = 0
		notePitch[i] = 1
	end
	
	numofslots = 17
	
	tim2 = 0
	
	spr_1 = love.graphics.newImage("/spr/spr_1.png")
	
	guy = {
		love.graphics.newQuad(0,0,160,200,520,200),
		love.graphics.newQuad(160,0,160,200,520,200),
		love.graphics.newQuad(160*2,0,200,200,520,200),
	}
	
	guytim = 3
	
	guynum = 3
	
	guyD = false
end

function UI.draw()
	for i=1, numofslots do
		love.graphics.rectangle("fill",(10*i*3)-7,150,10,10)
	end
	
	for i, v in ipairs(notes) do
		if v.hit then
			love.graphics.setColor(200,50,50)
		else
			if v.typ == 1 then
				love.graphics.setColor(255,255,255)
			elseif v.typ == 2 then
				love.graphics.setColor(100,200,100)
			elseif v.typ == 3 then
				love.graphics.setColor(100,100,200)
			elseif v.typ == 4 then
				love.graphics.setColor(100,100,100)
			elseif v.typ == 5 then
				love.graphics.setColor(200,200,50)
			end
		end
		love.graphics.rectangle("line",v.x,v.y,15,15)
	end
	
	if timer > limit - 0.8 then
		love.graphics.setColor(255,100,100)
	else
		love.graphics.setColor(255,255,255)
	end
	
	love.graphics.print("END.",538,148.7)
	
	love.graphics.setColor(255,255,255)
	
	love.graphics.line(0,320,maxW,320)
	
	if mode1 == 1 then
		love.graphics.print("Mode: Loop",10,maxH-25)
	else
		love.graphics.print("Mode: No loop",10,maxH-25)
	end
	
	love.graphics.print("Notes "..#notes.."/17",10,maxH-47)
	
	love.graphics.print("Current note: #"..notetype,10,maxH-70)
	
	if bgcolor == 0 or playIN == false then
		love.graphics.draw(spr_1,guy[guynum],maxW/2-20,30,0,0.2)
	end
	
	love.graphics.line(timer*10,50,timer*10,250)
	love.graphics.print(timer,timer*10-7,30)
	
	love.graphics.line(122,maxH-70,122,maxH-10)
	
	love.graphics.print("Current pitch: "..currntpitch,130,maxH-70)
	
	love.graphics.print("Last note pitch: "..lastnotepitch,130,maxH-47)
	
	love.graphics.line(250,maxH-70,250,maxH-10)
	
	if mute then
		love.graphics.print("Mute: true",260,maxH-70)
	else
		love.graphics.print("Mute: false",260,maxH-70)
	end
	
	love.graphics.print("Current instrument: "..instruments[notetype],260,maxH-50)
	
	if tchscreenD then
		UI.touchscreenD()
	end
end

function UI.touchscreenD()
	love.graphics.setColor(255,150,150,touchscreenAL-105)
	love.graphics.rectangle("fill",124,323,124,37)
	love.graphics.rectangle("fill",124,362,124,36)
	love.graphics.rectangle("fill",252,323,347,75)
	love.graphics.rectangle("fill",1,323,119,75)
	love.graphics.setColor(255,0,0,touchscreenAL)
	love.graphics.print("Play/pause",400,350)
	love.graphics.print("Pitch +",166,338)
	love.graphics.print("Pitch -",168,370)
	love.graphics.print("Save",48,350)
end

function UI.update(dt)

	if playIN then
		guytim = guytim + 1
		if guytim > 23 then
			if guynum == 1 then
				guynum = 2
			elseif guynum == 2 then
				guynum = 1
			end
			guytim = 0
		end
	end

	mx = love.mouse.getX()
	my = love.mouse.getY()
	
	for i, v in ipairs(notes) do
		if v.rmv then
			table.remove(notes,i)
		end
		if v.hit then
			tim2 = tim2 + 1
			if tim2 > 10 then
				v.hit = false
				tim2 = 0
			end
		end
	end
end

function love.mousepressed(x,y,button)
	for i=1, numofslots do
		if x > (10*i*3)-7 and x < (10*i*3)-7 + 10 and y < 175 then
			if slots[i] == false then
				table.insert(notes,addNote((10*i*3)-7,i,notetype,currntpitch,147.5))
				slotNotes[i] = notetype
				slots[i] = true
			elseif slots[i] == true then
				for k, b in ipairs(notes) do
					if b.slot == i then
						b.rmv = true
					end
				end
				slotNotes[i] = 0
				slots[i] = false
			end
		end
	end
	if y > 320 and y < maxH and x > 250 then
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
	
	if y > 320 and y < maxH - 40 and x > 122 and x < 250 then
		currntpitch = currntpitch + 0.1
	end
	if y > maxH-40 and y < maxH and x > 122 and x < 250 then
		currntpitch = currntpitch - 0.1
	end
	
	if x > 0 and x < 120 and y > 320 and y < maxH then
		save = true
	end
end

function addNote(x,num,typ,ptch,y)
	local v = {}
	v.x = x - 2.5
	if y ~= nil then
		v.y = y
	else
		v.y = 147.5
	end
	v.slot = num
	v.typ = typ
	v.ptch = ptch
	v.rmv = false
	v.hit = false
	return v
end