texty = {}

function texty.load()
	text = {}
	text[1] = "hey... is anyone actually tired?"
	text[2] = "nah dude"
	text[3] = "yeah i cant even sleep"
	text[4] = ""
	text[5] = "WOW WHAT THE HELL!"
	text[6] = "LET'S GO CHECK IT OUT!"
	text[7] = ""
	text[8] = "Ill be dammed if I go outside! Im busy you go!"
	text[9] = ""

	text.num = 1
	text.portN = 3

	texty.resetLoad()

	text.speed = 0.02
	
	print((maxW-15*2)..","..maxH-300)
	
	textY = 17
end

-----------RESETABLE VALUES---------
function texty.resetLoad()

	done = false

	chose = false

	printedText  = "" -- Section of the text printed so far

	-- Timer to know when to print a new letter
	typeTimerMax = 0.02
	typeTimer 	 = 0.02

	-- Current position in the text
	typePosition = 0

end

function texty.update(dt)
	texty.actions()
	--Typewrite effect
	 if typePosition <= string.len(text[text.num]) then
		-- Decrease timer
		typeTimer = typeTimer - dt
		
		if NPCacting == false then
			char[text.portN].wTimr = char[text.portN].wTimr + 1
			if char[text.portN].wTimr > 5 then
				if char[text.portN].frmD < 4 then
					char[text.portN].frmD = char[text.portN].frmD + 1
					if char[text.portN].frmD > 3 then
						char[text.portN].frmD = 2
					end
				end
				if char[text.portN].frmD > 3 then
					char[text.portN].frmD = char[text.portN].frmD + 1
					if char[text.portN].frmD > 5 then
						char[text.portN].frmD = 4
					end
				end
				char[text.portN].wTimr = 0
			end
		end
		-- Timer done, we need to print a new letter:
		-- Adjust position, use string.sub to get sub-string
		if typeTimer <= 0 then
			typeTimer = text.speed
			typePosition = typePosition + 1
			printedText = string.sub(text[text.num],0,typePosition)
		end
	 end
	 if typePosition >= string.len(text[text.num]) then
		done = true
		if NPCacting == false then
			char[text.portN].frmD = 1
		end
	 end
end

function texty.draw(dt)
	love.graphics.setColor(255,255,255)
	
	love.graphics.draw(textBox,15,textY)
	
	love.graphics.draw(portsSPR,charPorts[text.portN],35,textY+2)
	
	love.graphics.setColor(0,0,0)
	
	love.graphics.printf(printedText,157,textY+15,370,"left")
end

function texty.actions()
	if NPCacting == true then
		if char[mainChar].y < maxH/2 then
			textY = maxH/2 + 15
		elseif char[mainChar].y > maxH/2 then
			textY = 15
		end
	end
	
	if text.num == 2 then
		text.portN = 1
	end
	if text.num == 3 then
		text.portN = 2
	end
	if text.num == 6 then
		if mainChar == 1 then
			text.portN = 3
		elseif mainChar == 2 then
			text.portN = 1
		elseif mainChar == 3 then
			text.portN = 1
		end
	end
end