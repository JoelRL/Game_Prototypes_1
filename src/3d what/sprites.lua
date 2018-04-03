sprites = {}

function sprites.load()
	sprite_sheet1 = love.graphics.newImage("/sprite_sheet1.png")
	
	dustParticle = love.graphics.newImage("/dust.png")
	
	sprite = {}
	
	local spriteNum = 7
	
	for i=1, spriteNum do
		sprite[i] = love.graphics.newQuad(-32 + (32 * i),0,32,32,sprite_sheet1:getWidth(),sprite_sheet1:getHeight())
	end
	
	sprite_sheet2 = love.graphics.newImage("/sprite_sheet2.png")
	
	local spriteNum = 2
	
	local obsticlesSprs = 1
	
	obsticleSprite = {
		{
			love.graphics.newQuad(0,0,19,21,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(19,0,19,21,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(0,0,19,21,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(19,0,19,21,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
		},
		{
			love.graphics.newQuad(59,0,21,21,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(38,0,21,21,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(59,0,21,21,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
		},
		{
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(20,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(20,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(20,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(20,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(20,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(20,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(20,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
		},
		{
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(20,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(20,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(20,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
			love.graphics.newQuad(0,21,20,20,sprite_sheet2:getWidth(),sprite_sheet2:getHeight()),
		},
	}
end