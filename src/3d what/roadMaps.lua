roadMaps = {
	{
		{8,7,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,10,9},
		{1,19,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,20,2},
		{1,17,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,11,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,17,2},
		{1,17,3,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,12,17,2},
		{1,21,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,22,2},
		{14,13,6,6,6,6,6,6,6,6,11,4,6,6,6,6,6,6,6,6,6,6,15},
		{0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0},
	},
	{
		{8,7,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,9},
		{1,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,11,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,3,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,12,2},
		{1,4,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,11,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2},
		{1,3,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,12,2},
		{14,6,6,6,6,6,6,6,6,6,11,4,6,6,6,6,6,6,6,6,6,6,15},
		{0,0,0,0,0,0,0,0,0,0,1,2,0,0,0,0,0,0,0,0,0,0,0},
	},
}

sprite_sheet3 = love.graphics.newImage("/sprite_sheet3.png")

road_spr = {
		love.graphics.newQuad(0,0,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(32,0,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(64,0,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(96,0,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(96+32,0,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(96+(32*2),0,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(0,32,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(32,32,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(32*2,32,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(32*3,32,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(32*4,32,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(32*5,32,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(0,64,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(32,64,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(32*2,64,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(32*3,64,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(128,64,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(160,64,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(0,96,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(32,96,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(64,96,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
		love.graphics.newQuad(96,96,32,32,sprite_sheet3:getWidth(),sprite_sheet3:getHeight()),
	}