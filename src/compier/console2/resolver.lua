function resolveCommand(cmmd,line,lineNUM,vars)
	if cmmd == 1 then
	
		for i=1, #environmentVariables do
			environmentVariables[i] = nil
		end
	
		print("\n\n--:Program ended succesfully:--")
		currentOperation = "end_program"
	end
	if cmmd == 2 then
		local k, j = string.find(vars,"%(")
		
		local f, e = string.find(vars,"%)")
		
		if f == nil then
			print("Error: Missing closing bracket in line \""..line.."\"")
			currentOperation = "wait_input"
			return
		end
		
		local output1 = string.sub(vars,k+1,f-1)
		local finalOutput = ""
		
		if string.sub(output1,1,1) == "\"" then
			-- Print text in quotes --
			if string.sub(output1,string.len(output1),string.len(output1)) then
				finalOutput = string.sub(output1,2,string.len(output1)-1)
			end
		else
			-- Reserved for variable printing --
			for i=1, #environmentVariables do
				if output1 == environmentVariables[i].pointer then
					finalOutput = environmentVariables[i].variable
				end
			end
		end
		
		print(finalOutput)
	end
	if cmmd == 3 then
	
		local k, j = string.find(line,"int")
	
		local m, d = string.find(line,"=")
		
		if m == nil then
			
			local f, g = string.find(line,";")
		
			local t = {pointer=string.sub(line,j+2,f-1),variable=0}
			
			table.insert(environmentVariables,t)
			
			return
		end
		
		local f, g = string.find(line,";")
		
		local rawVars = string.sub(line,d+1,g-1)
		
		local startV = 1
		
		for w=1, string.len(rawVars) do
			if string.sub(rawVars,w,w) == " " then
				startV = w + 1
			end
		end
		
		rawVars = string.sub(rawVars,startV,g-1)
		
		local t = {pointer=string.sub(line,j+2,m-2),variable=rawVars}
		
		table.insert(environmentVariables,t)
		
	end
end