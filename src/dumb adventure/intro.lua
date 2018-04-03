function chrslctDraw()
	if chrSLCTD == 0 then
		love.graphics.draw(titleBG)

	if slctd == 1 then
		love.graphics.draw(arrow1,pX1+13,pY1-30,0,1,1,char1Icon:getWidth()/2,char1Icon:getHeight()/2)
	end
	end
	if chrSLCTD == 0 then
		love.graphics.draw(char1Icon,pX1,pY1,rot1,1,1,char1Icon:getWidth()/2,char1Icon:getHeight()/2)

	if slctd == 2 then
		love.graphics.draw(arrow1,pX2+15,pY2-28,0,1,1,char2Icon:getWidth()/2,char2Icon:getHeight()/2)
	end
	
	end
	if chrSLCTD == 0 then
		love.graphics.draw(char2Icon,pX2,pY2,rot2,1,1,char2Icon:getWidth()/2,char2Icon:getHeight()/2)

	if slctd == 3 then
		love.graphics.draw(arrow1,pX3+13,pY3-27,0,1,1,char3Icon:getWidth()/2,char3Icon:getHeight()/2)
	end
	
	end
	if chrSLCTD == 0 then
		love.graphics.draw(char3Icon,pX3,pY3,rot3,1,1,char3Icon:getWidth()/2,char3Icon:getHeight()/2)
	end
	
	if chrSLCTD == 1 then
		love.graphics.draw(char1Icon,pX1,pY1,rot1,1,1,char1Icon:getWidth()/2,char1Icon:getHeight()/2)
	end
	if chrSLCTD == 2 then
		love.graphics.draw(char2Icon,pX2,pY2,rot2,1,1,char2Icon:getWidth()/2,char2Icon:getHeight()/2)
	end
	if chrSLCTD == 3 then
		love.graphics.draw(char3Icon,pX3,pY3,rot3,1,1,char3Icon:getWidth()/2,char3Icon:getHeight()/2)
	end
	
	if chrSLCTD == 0 then
		love.graphics.draw(titleFG)
	else
		love.graphics.draw(titleFG2)
	end
end

function chrslctUpdate()
	if dirX1 < 50 then
		pX1 = pX1 + spd1
	elseif dirX1 < 100 and dirX1 > 50 then
		pX1 = pX1 - spd1
	end
	if dirY1 < 50 then
		pY1 = pY1 + spd1
	elseif dirY1 < 100 and dirY1 > 50 then
		pY1 = pY1 - spd1
	end
	if dirX2 < 50 then
		pX2 = pX2 + spd1 / 3
	elseif dirX2 < 100 and dirX2 > 50 then
		pX2 = pX2 - spd1
	end
	if dirY2 < 50 then
		pY2 = pY2 + spd1
	elseif dirY2 < 100 and dirY2 > 50 then
		pY2 = pY2 - spd1 / 5
	end
	if dirX3 < 50 then
		pX3 = pX3 + spd1
	elseif dirX3 < 100 and dirX3 > 50 then
		pX3 = pX3 - spd1
	end
	if dirY3 < 50 then
		pY3 = pY3 + spd1 / 2
	elseif dirY3 < 100 and dirY3 > 50 then
		pY3 = pY3 - spd1
	end
	
	if pX1 < (char1Icon:getWidth()*-1)-10 then
		pX1 = love.graphics.getWidth()+char1Icon:getWidth()
	end
	if pX2 < (char2Icon:getWidth()*-1)-10 then
		pX2 = love.graphics.getWidth()+char2Icon:getWidth()
	end
	if pX3 < (char3Icon:getWidth()*-1)-10 then
		pX3 = love.graphics.getWidth()+char3Icon:getWidth()
	end
	
	if pX1 > love.graphics.getWidth()+char1Icon:getWidth()+10 then
		pX1 = char1Icon:getWidth()*-1
	end
	if pX2 > love.graphics.getWidth()+char2Icon:getWidth()+10 then
		pX2 = char2Icon:getWidth()*-1
	end
	if pX3 > love.graphics.getWidth()+char3Icon:getWidth()+10 then
		pX3 = char3Icon:getWidth()*-1
	end
	
	if pY1 < (char1Icon:getHeight()*-1)-10 then
		pY1 = love.graphics.getHeight()+char1Icon:getHeight()
	end
	if pY2 < (char2Icon:getHeight()*-1)-10 then
		pY2 = love.graphics.getHeight()+char2Icon:getHeight()
	end
	if pY3 < (char3Icon:getHeight()*-1)-10 then
		pY3 = love.graphics.getHeight()+char3Icon:getHeight()
	end
	
	if pY1 > love.graphics.getHeight()+char1Icon:getHeight()+10 then
		pY1 = char1Icon:getHeight()*-1
	end
	if pY2 > love.graphics.getHeight()+char2Icon:getHeight()+10 then
		pY2 = char2Icon:getHeight()*-1
	end
	if pY3 > love.graphics.getHeight()+char3Icon:getHeight()+10 then
		pY3 = char3Icon:getHeight()*-1
	end
	
	rot1 = rot1 + spd1 / 100
	rot2 = rot2 + spd1 / 180
	rot3 = rot3 - spd1 / 130
	
	if chrSLCTD ~= 0 then
		timr = timr + 1
		if timr > 200 then
			gamestate = "gameIntro"
			pX1 = nil
			pX2 = nil
			pX3 = nil
			pY1 = nil
			pY2 = nil
			pY3 = nil
			movX1 = nil
			movX2 = nil
			movX3 = nil
			movY1 = nil
			movY2 = nil
			movY3 = nil
			rot1 = nil
			rot2 = nil
			rot3 = nil
			dirX1 = nil
			dirY1 = nil
			dirX2 = nil
			dirY2 = nil
			dirX3 = nil
			dirY3 = nil
			spd1 = nil
			slctd = nil
			timr = 0
		end
	end
end