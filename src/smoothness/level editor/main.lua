function love.load()
	testM = love.audio.newSource("/bgmusic.mp3")
	testMS = testM:getDuration("seconds")
	play = false
	lineoffset = 20
	local width, height = love.graphics.getDimensions()
	scale = 13.5
	yaxis = 300
	
	dir = love.filesystem.getSaveDirectory()
	
	f = love.filesystem.newFile("notes.txt")
	
	f:open("w")
	
	noteoff = 0.4
	
end

function love.draw()
	love.graphics.line(testM:tell()*scale+lineoffset,yaxis,testM:tell()*scale+lineoffset,yaxis+50)
	love.graphics.print(testM:tell(),testM:tell()*scale+lineoffset,yaxis-20)
	
	love.graphics.line(lineoffset,yaxis+25,testMS*scale+lineoffset,yaxis+25)
	
	love.graphics.print(testMS*scale+lineoffset)
	
	love.graphics.print(dir,0,30)
end

function love.update(dt)
	if love.keyboard.isDown("down") and testM:tell() > 0.1 then
		testM:seek(testM:tell()-0.1,"seconds")
	end
	if love.keyboard.isDown("up") and testM:tell() < testMS-0.1 then
		testM:seek(testM:tell()+0.1,"seconds")
	end
end

function love.keypressed(key)
	if key == "escape" then
		f:close()
		love.event.quit()
	end
	if key == "space" then
		if play then
			testM:pause()
			play = false
		else
			testM:play()
			play = true
		end
	end
	if key == "z" then
		f:write("|T-"..testM:tell()-noteoff.."|1|\r\n")
	end
	if key == "left" and testM:tell() > 0.25 then
		testM:seek(testM:tell()-0.25,"seconds")
	end
	if key == "right" and testM:tell() < testMS-0.25 then
		testM:seek(testM:tell()+0.25,"seconds")
	end
end