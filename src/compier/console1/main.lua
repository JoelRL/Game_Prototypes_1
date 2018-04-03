function love.load()
	maxW, maxH = love.graphics.getDimensions()
	
	rowsHeight = 20
	
	screenRows = maxH / rowsHeight
	
	consoleFont = love.graphics.newFont("font1.ttf",rowsHeight)
	
	love.graphics.setFont(consoleFont)
	
	consoleText = {}
	
	newInputText = ""
end

function love.draw()
	
end

function windowConsole()
	for i, v in ipairs(consoleText) do
		love.graphics.printf(v.text,0,v.y*rowsHeight,maxW)
	end
	
	love.graphics.printf(newInputText,0,#consoleText*rowsHeight,maxW)
end

function love.update(dt)
	
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
	
	if key == "return" then
	
		local t = {text=newInputText,y=#consoleText}
		
		if string.len(t.text) > 100 then
			
		end
	
		table.insert(consoleText,t)
		
		newInputText = ""
	end
end

function love.textinput(t)
    newInputText = newInputText .. t
end