rooms = {}

function rooms.load()
	blocks = {}
	entities = {}
end

function rooms.update(num)
	if num == 1 then
		addBlock(510,200,100,170)
	
		addBlock(0,100,110,270)
	
		addBlock(100,155,400,9)
	
		addBlock(100,maxH,150,10)
	
		addBlock(360,maxH,130,10)
	end
	if num == 2 then
		addBlock(420,120,50,57)
		addEntity(1)
		addBlock(48,0,202,40)
		addBlock(0,68,48,300)
		addBlock(48,368,200,40)
		addBlock(372,368,200,40)
		addBlock(560,68,48,300)
		addBlock(373,0,202,40)
		addEntity(2)
	end
	if num == 3 then
		addBlock(108,0,144,140)
		addBlock(342,0,131,140)
		addBlock(0,150,150,25)
		addBlock(440,150,157,25)
	end
end

function rooms.getBG(roomNUM)
	if roomNUM == 1 then
		return 3
	end
	if roomNUM == 2 then
		return 4
	end
	if roomNUM == 3 then
		return 5
	end
end

function rooms.getEndY1(roomNUM)
	if roomNUM == 1 or roomNUM == 2 or roomNUM == 3 then
		return maxH
	end
end

function rooms.getEndY2(roomNUM)
	if roomNUM == 1 or roomNUM == 2 then
		return 0
	end
	if roomNUM == 3 then
		return 200
	end
end

function rooms.getStartY1(roomNUM)
	if roomNUM == 2 then
		return 0
	end
	if roomNUM == 3 then
		return 180
	end
end

function rooms.getStartY2(roomNUM)
	if roomNUM == 1 then
		return maxH - char[mainChar].h
	end
	if roomNUM == 2 then
		return maxH - char[mainChar].h
	end
end