world_rooms = {}

function world_rooms.load()
    rooms = {
        {
            road = true,
            car = true,
            human = true,
            bg = nil,
            roadMapNum = 1,
            doors = {},
            obsticles = {},
            obsticlesColls = {},
        },
		{
			road = true,
			car = true,
			human = true,
			bgdraw = false,
            bg = nil,
            roadMapNum = 1,
			doors = {
				{shape=shapes.newPolygonShape(340,210,360,210,360,214,340,214),pointer=2,pointer2=342,pointer3=222}
			},
			scale = 1,
			obsticles = {
				{x=100,y=100,spr=1,Sh=8,sprDepth={-1,1,1,1},r=0,bx=100,by=102,w=18,h=10,hit=false},
				{x=200,y=100,spr=1,Sh=8,sprDepth={-1,1,1,1},r=0,bx=200,by=102,w=18,h=10,hit=false},
				{x=200,y=220,spr=2,Sh=8,sprDepth={-1,1,1},r=0,bx=200,by=220,w=20,h=15,hit=false},
				{x=300,y=220,spr=3,Sh=3,sprDepth={-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1},r=0,bx=300,by=200,w=20,h=30,hit=false},
				{x=320,y=220,spr=3,Sh=3,sprDepth={-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1},r=0,bx=320,by=200,w=20,h=30,hit=false},
				{x=360,y=220,spr=3,Sh=3,sprDepth={-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1},r=0,bx=360,by=200,w=20,h=30,hit=false},
				{x=380,y=220,spr=3,Sh=3,sprDepth={-1,-1,-1,-1,1,1,1,1,1,1,1,1,1,1},r=0,bx=380,by=200,w=20,h=30,hit=false},
				{x=340,y=199,spr=4,Sh=3,sprDepth={1,1,1,1,1,1,1},r=0,bx=340,by=200,w=20,h=10,hit=false},
			},
			obsticlesColls = {},
		},
		{
			road = false,
			car = false,
			human = true,
			bgdraw = true,
            bg = love.graphics.newImage("/bg/bg1.png"),
            roadMapNum = 0,
			doors = {
				{shape=shapes.newPolygonShape(350,496,452,496,452,520,350,520),pointer=1,pointer2=377,pointer3=448},
			},
			obsticles = {
				{x=125,y=125,spr=0,Sh=8,sprDepth={1,1,1,1},r=0,bx=125,by=125,w=552,h=10,hit=false},
				{x=677,y=135,spr=0,Sh=8,sprDepth={1,1,1,1},r=0,bx=677,by=135,w=10,h=360,hit=false},
				{x=115,y=135,spr=0,Sh=8,sprDepth={1,1,1,1},r=0,bx=115,by=135,w=10,h=360,hit=false},
				{x=125,y=495,spr=0,Sh=8,sprDepth={1,1,1,1},r=0,bx=125,by=495,w=225,h=10,hit=false},
				{x=455,y=495,spr=0,Sh=8,sprDepth={1,1,1,1},r=0,bx=455,by=495,w=225,h=10,hit=false},
			},
			obsticlesColls = {},
			scale = 3,
		},
	}
end