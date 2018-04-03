function level_load(num)
	if num == 1 then
		world_collisions.newFloor(0,500,500,100)
	
		world_collisions.newFloor(600,400,100,100)
		
		world_collisions.newFloor(800,500,1000,100)
		
		world_collisions.newEnemy(450,400,1)
		
		world_collisions.newEnemy(630,340,1)
		
		world_collisions.newEnemy(1330,400,1)
		
		world_collisions.newColl(900,400,100,100)
		
		world_collisions.newColl(1400,400,100,100)
		
		world_collisions.newColl(1500,300,200,200)
		
		world_collisions.newColl(1700,200,100,300)
		
		world_collisions.newColl(1800,200,30,20)
		
		world_collisions.newFloor(1900,500,2000,100)
		
		world_collisions.newEnemy(1980,440,1)
		
		world_collisions.newEnemy(2600,0,2)
		
		world_collisions.newEnemy(2700,0,2)
		
		world_collisions.newEnemy(2800,0,2)
		
		world_collisions.newEnemy(3000,0,2)
		
		world_collisions.newEnemy(3600,440,1)
		
		world_collisions.newEnemy(3700,440,1)
		
		world_collisions.endZone(3800,380,100,120,2)
	end
	if num == 2 then
		world_collisions.newFloor(0,500,800,200)
		
		world_collisions.newColl(780,400,30,100)
		
		world_collisions.newFloor(800,400,1800,200)
		
		world_collisions.newEnemy(1500,150,3)
		
		world_collisions.newEnemy(1500,0,4,"l",true)
		
		world_collisions.newEnemy(1600,300,1)
		
		world_collisions.newEnemy(1700,300,1)
		
		world_collisions.newEnemy(1800,300,1)
		
		world_collisions.endZone(2499,280,100,120,3)
	end
	if num == 3 then
		world_collisions.newColl(0,300,150,100)
		
		world_collisions.newColl(150,320,150,100)
		
		world_collisions.newColl(300,340,150,100)
		
		world_collisions.newColl(450,360,150,100)
		
		world_collisions.newColl(600,380,150,100)
		
		world_collisions.newColl(750,400,150,100)
		
		world_collisions.newFloor(900,500,700,100)
		
		world_collisions.newBossTrigger(1250,200,30,300,1)
		
		world_collisions.newColl(900+700,400,500,100)
		
		world_collisions.endZone(1999,280,100,120,4)
	end
	if num == 4 then
		love.graphics.setBackgroundColor(100,100,100)
		
		lvlCameraEnd = false
		
		lvlCameraEndV = 3200
	
		world_collisions.newFloor(0,500,maxW*4,100)
		
		world_collisions.newBoss(2,2200,435)
		
		world_collisions.newBossTrigger(1970,200,30,300,2)
	end
end