entity = {}

function getEntityPosition(id)
	if id == 1 then
		return 420, 82
	end
	if id == 2 then
		return 107, 36
	end
end

function getEntityWidthHeight(id)
	if id == 1 then
		return 45, 45
	end
	if id == 2 then
		return 94, 65
	end
end

function getEntityClass(id)
	if id == 1 then
		return "npc"
	end
	if id == 2 then
		return "action"
	end
end

function entityAction(id)
	if id == 1 then
		text.portN = 4
		textD = true
		textAct = true
		text.num = 8
	end
	if id == 2 then
		curScrn = curScrn + 1
		if curScrn > 4 then
			curScrn = 1
		end
	end
end

function entityActionUpdate(id)
	if id == 1 then
		if text.num == 9 then
			NPCacting = false
			touchNPC = false
			NPCactingID = 0
			textAct = false
			textD = false
			char[mainChar].canMove = true
		end
	end
end