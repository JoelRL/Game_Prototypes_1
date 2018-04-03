texty = {}

function texty.load()
text = {}
text[1] = "OH GEEZ! IM SO TIRED! I REALLY DONT WANNA GO TO SCHOOL MAAAAAAAAN..."
text[2] = "THERE IS ONLY ONE REASON THAT I GET UP EVERYDAY AND CONTINUE WITH MY MISERABLE LIFE..."
text[3] = "TO SEE MY SENPAI, JOEL"
text[4] = "!?!"
text[5] = "OH GOD HE MUST HAVE HEARD ME HES COMING THIS WAY OH NO!"
text[6] = "HEY."
text[7] = "(OH MY GODS!! HES TALKING TO ME!!)"
text[8] = "(WAIT IS HE TALKING TO SOMEONE BEHIND ME?)"
text[9] = "(NO! OH MY GODS OKAY PLAY IT COOL!)"
text[10] = "OH HEY HI JOEL HOW UH... HOW ARE YOU DOING IN THIS FINE DAY."
text[11] = "GOOD. I COULD REALLY GO FOR A QUESADILLA RIGHT ABOUT NOW..."
text[12] = "OH UM I BET YOU WOULD..."
text[13] = "WELL IT WAS NICE CATCHING UP WITH YOU! IM GONNA DRAW ON THE GROUND NOW."
text[14] = "..."
text[15] = "(OK, SO HES A BIT DENSE IN THE HEAD, BUT HES STILL PRETTY ATTRACTIVE!)"
text[16] = "RRRRRRRIIIIIIIINNNNGGGGGG!!!"
text[17] = "OKAY CLASS TAKE YOUR SEATS, OR I SWEAR TO GOD THIS TIME I WILL STRIKE NO MATTER WHAT THE JUDGE SAYS!!"
text[18] = "OH DAM BETTER GET SEATED!"
text[19] = "OKAY CLASS TODAY WE WILL BE LEARNING ABOUT THE KNEES AND THE BEES."
text[20] = "EEEEW GRODY!"
text[21] = "HEY KID SHUT THE FUCK UP!!"
text[22] = "YOU DECIDED TO TAKE A LITTLE NAP... YOU KNOW... SOMETHING TO TAKE THE EDGE OFF A LITTLE..."
text[23] = "ZZZZZZZZZZZZZZZZZZ"
text[24] = "ZZZZZZZZZZZZ...."
text[25] = ".............."
text[26] = "HELLOW."
text[27] = "J-JOEL!?"
text[28] = "ITS ME, DREAM JOEL...."
text[29] = "I JUST WANTED TO TELL YOU THAT YOUR REALLY COOL AND YOU HAVE NICE HIPS"
text[30] = "OH UMH THANK... YOU?"
text[31] = "COME GIVE ME A KISS BABY!"
text[32] = "AAAAAH RAPE!!!"
text[33] = "AAAAAAAHHHHHH RAAAAPE!!!"
text[34] = ".............................."
text[35] = ".............................."
text[36] = "YOU IMMEDIATELY BUST OUTTA OF THE ROOM!!"
text[37] = "NYA."
text[38] = "CALL IN THE AIRSTRIKES!!!"
text[39] = "KSH! AIRSTRIKES INBOUND!"
text[40] = "BOOMBA!!"
text[41] = "!!!"
text[42] = "WHAT YEAR IS IT?!?"
text[43] = "UM EXCUSE ME? DO YOU HAVE SOMETHING TO SAY TO CLASS?"
text[44] = "UH ACTUALLY WH-"
text[45] = "YEAH FUCKING THOUGHT SO..."
text[46] = "BITCH."
text[47] = "RIIIIIINNNNGGGG!!!"
text[48] = "OKAY CLASS DISMISSED! AND WHO THE HELL TOOK MY VODKA!"
text[49] = "**YOU START CRYING UNDER THE PRESSURE AND LEAVE THE CLASS**"
text[50] = "**YOU TRY TO CATCH YOUR BREATH AND FORCIBLY STUFF YOUR TEARS BACK INTO YOUR EYE SOCKETS BEFORE ANYONE SEES YOU**"
text[51] = "HEY, ARE YOU OKAY?"
text[52] = "(OH NO, ITS SENPAI! BUT....WAIT....DID HE COME TO CHECK ON ME? BLUSHU)"
text[53] = "U-UH YEAH! YOU... YOU DIDNT NEED TO COME OUT AND CHECK ON ME, BUT.....ARIGATO, JOEL-KUN-SENPAI-MUN-TUN"
text[54] = "OH, I DIDN'T COME OUT TO CHECK ON YOU, IT'S TIME FOR MY 9:30."
text[55] = "YOUR WHAT?"
text[56] = "SORRY, I CAN'T TALK MUCH LONGER. I'M LATE,"
text[57] = "**HIS FACE SCRUNCHES UP AS HE RUNS TOWARDS THE BATHROOM**"
text[58] = "**YOU TAKE ONE LAST GLANCE AS HIS HURRIED ASS BEFORE GOING TO LUNCH**"
text[59] = "HEY, BITCH"
text[60] = "!?!"
text[61] = "ITS ME, DARK JOEL."
text[62] = "OH... IT'S YOU."
text[63] = "WHAT THE HELL DO YOU WANT..."
text[64] = "OH... UH... I JUST... I WAS JUST WONDERING HOW YOUR DOING..."
text[65] = "UGH WHATEVER LEAVE ME ALONE YOU CREEP"
text[66] = "OH SORRY I JUST THOUGHT... YOU KNOW... I SHOULD GO FOR A STRONG OPENING"
text[67] = "KINDA PUT THE WHOLE... BLACK PALETTE INTO MOTION BUT... NEVERMIND"
text[68] = "YEAH YEAH, DO YOU KNOW WHERE WHEN YOUR BROTHER WILL BE BACK?"

text.labels = {"YOU","JOEL","BELL","TEACHER","STUDENT","STUDENTS","AIRSTRIKE","SCHOOL","JOEL'S FACE","???","DARK JOEL"}

text.num = 1
text.char = 1
choice = {}
choice.num1 = 1

texty.resetLoad()

debug = false

text.speed = 0.02

loadingDone = true
end

-----------RESETABLE VALUES---------
function texty.resetLoad()

done = false

chose = false

printedText  = "" -- Section of the text printed so far

-- Timer to know when to print a new letter
typeTimerMax = 0.02
typeTimer 	 = 0.02

-- Current position in the text
typePosition = 0

end

function texty.update(dt)
--Mouse debug
mx = love.mouse.getX()
my = love.mouse.getY()
--Typewrite effect
 if typePosition <= string.len(text[text.num]) then
	-- Decrease timer
	typeTimer = typeTimer - dt
	
	-- Timer done, we need to print a new letter:
	-- Adjust position, use string.sub to get sub-string
	if typeTimer <= 0 then
		typeTimer = text.speed
		typePosition = typePosition + 1
		printedText = string.sub(text[text.num],0,typePosition)
	end
 end
 if typePosition >= string.len(text[text.num]) then
     done = true
 end
 texty.names()
end

function love.keypressed(key)
	if key == "space" and done == true then
		text.num = text.num + 1
		texty.resetLoad()
		if text.num == 16 or text.num == 47 then
		    sfxS[3]:play()
		end
		if text.num == 31 then
			sfxS[2]:play()
		end
		if text.num == 36 then
			sfxS[1]:play()
		end
	end
end

function texty.draw(dt)
	love.graphics.setFont(font)
	love.graphics.printf(text.labels[text.char],70,420,290,"center")
	love.graphics.printf(printedText,60,490,1060,"left")
	if debug == true then
		love.graphics.print(" "..mx.." | "..my.." ",0,0)
	end
end

function texty.names()
	namesUpdate()
end