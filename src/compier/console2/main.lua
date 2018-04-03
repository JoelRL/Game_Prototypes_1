require "syntax"
require "resolver"

function love.load()
	maxW, maxH = love.graphics.getDimensions()
	
	syntax.load()
	
	currentOperation = "wait_input"
	
	print("--Compiler v0.1 by Joel Rodiel-Lucero--\n")
	
	print("Waiting for file input...\n")
	
	environmentVariables = {}
	
	latestSourceCode = ""
	
end

function love.update()
	if currentOperation == "decoding_input" then
		for i, v in ipairs(fileLines) do
		
			local ignore = false
			
			local endOfWord = string.len(v)
			
			local rawCommand = ""
			
			for k=1, string.len(v) do
				if string.sub(v,k,k) == "(" then
					endOfWord = k - 1
					rawCommand = string.sub(v,1,endOfWord)
					break
				elseif string.sub(v,k,k) == ";" then
					endOfWord = k - 1
					rawCommand = string.sub(v,1,endOfWord)
					break
				elseif string.sub(v,k,k) == "#" then
					if string.sub(v,k+1,k+1) == "#" then
						ignore = true
						break
					end
				end
			end
			
			if not ignore then
			
				local cmdID = 0
				
				for k=1, #syntax.list do
					if syntax.list[k].t ~= "int" then
						if rawCommand == syntax.list[k].t then
							cmdID = k
							break
						end
					else
						if string.find(rawCommand,syntax.list[k].t) then
							cmdID = k
							break
						end
					end
					if k == #syntax.list then
						currentOperation = "end_program"
						print("\n!--Error wrong syntax in line \""..v.."\" !!--!\n")
						break
					end
				end
				
				if currentOperation == "end_program" then
					break
				end
				
				local vars = ""
				
				if syntax.list[cmdID].t == "printC" then
					local k = string.find(v,";")
					
					vars = string.sub(v,endOfWord+1,k)
				end
				
				resolveCommand(syntax.list[cmdID].id,v,i,vars)
				
			end
			
			if currentOperation == "end_program" then
				break
			end
		end
		if currentOperation ~= "end_program" then
			print("\n!-:Ended program unsucessfully:-!\n")
		end
	end
end

function love.draw()
	if currentOperation == "wait_input" or currentOperation == "end_program" then
		love.graphics.line(20,maxH-23,maxW-20,maxH-23)
		love.graphics.printf("Drop file...",0,maxH-18,maxW,"center")
	end
	if currentOperation == "end_program" then
		love.graphics.printf("Source code:\n\n"..latestSourceCode,22,10,maxW-44)
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end
end

function love.filedropped(file)
	currentOperation = "processing_input"
	
	local name = file:getFilename()
	
	if string.find(name,".txt") then
		
		fileLines = {}
		
		file:open("r")
		
		local contents = file:read()
		
		local lineData = {
			startL = 0,
			endL = 0,
		}
		
		local startD = false
		
		for i=1, string.len(contents) do
			if string.byte(string.sub(contents,i,i)) ~= 13 and string.byte(string.sub(contents,i,i)) ~= 10 then
				if not startD then
					lineData.startL = i
					startD = true
				else
					if string.sub(contents,i,i) == ";" then
						lineData.endL = i
						table.insert(fileLines,string.sub(contents,lineData.startL,lineData.endL))
						latestSourceCode = latestSourceCode .. "\t" .. string.sub(contents,lineData.startL,lineData.endL) .. "\n\n"
						startD = false
					end
				end
			end
		end
		
		file:close()
		
		currentOperation = "decoding_input"
	else
		currentOperation = "wait_input"
		print("Unsupported input")
		print("Waiting for file input...")
		return
	end
end