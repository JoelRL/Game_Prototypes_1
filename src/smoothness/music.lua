music = {} --Main music table for file

function music.load() 

	local dataS = love.filesystem.getSize("/Music/"..files[songnum].."/notes.txt") --Variable to get note data size
	local dataI = love.filesystem.getSize("/Music/"..files[songnum].."/info.txt") --Variable to get song info data size
	
	data = love.filesystem.read("/Music/"..files[songnum].."/notes.txt",dataS) --Variable to read note data
	
	info = love.filesystem.read("/Music/"..files[songnum].."/info.txt",dataS) --Variable to read song info data
	
	bgmusic = love.audio.newSource("/Music/"..files[songnum].."/bgmusic.mp3") --Variable to store bgmusic
	
	sprs1 = love.graphics.newImage("/Music/"..files[songnum].."/spr/karate_man.png") --Variable to store sprite sheet #1 (Karate Man)
	
	sprs2 = love.graphics.newImage("/Music/"..files[songnum].."/spr/karate_BG.png") --Variable to store sprite sheet #2 (Backgorunds)
	
	a = string.find(data, "|T-",1,true) --Variable to find |T- in note file
	
	notes = {} --Main notes table
	
	notesT = {} --Main notes type table
	
	i = 1 --I variable for file reading
	
	checkData() --Load check data
end

--Function that stores notes and note types into tables from data file--
function checkData()
	while a ~= nil do --While a isnt nil
		local t = tonumber(string.sub(data,a+3,a+7)) --Make T into whatever time is in the note file
        local e = tonumber(string.sub(data,a+9,a+9)) --Make E into whatever note type is in note file
		notes[i] = t --Add T to the notes table
		notesT[i] = e --Add E to the notes type table
		i = i + 1 --Increase I by 1
		a = string.find(data, "|T-",a+5,true) --Keep looking through file until it finds |T- to read again
	end
end