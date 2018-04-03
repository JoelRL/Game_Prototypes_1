message = {}

function message.load()
	text = {
		num = 1,
		defSpd = 0.05,
	}
	
	drawMessage = true
	
	message.resetVar()
end

function message.resetVar()

	text.done = false

	text.printedText  = ""

	text.typeTimerMax = text.defSpd
	text.typeTimer 	 = text.defSpd

	text.typePosition = 0
end

function message.close()
	text.num = 1
	message.resetVar()
end

function message.update(dt,message)
	if text.typePosition <= string.len(message) then
		text.typeTimer = text.typeTimer - dt

		if text.typeTimer <= 0 then
			for i, v in ipairs(world_collisions.entities) do
				if v.class == "boss" then
					if v.id == 1 then
						if v.talkF == 2 then
							v.talkF = 3
						else
							v.talkF = 2
						end
					end
				end
			end
			text.typeTimer = text.defSpd
			text.typePosition = text.typePosition + 1
			text.printedText = string.sub(message,0,text.typePosition)
		end
	end
	if text.typePosition >= string.len(message) then
		text.done = true
	end
end

function message.draw(x,y,w)
	love.graphics.printf(text.printedText,x,y,w,"left")
end