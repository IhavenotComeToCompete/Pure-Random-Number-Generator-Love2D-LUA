-- Author Mir Zarafath Ali

-- Function that selects a seed
function RandomSeedMaker(x)
	local Sin = 0
	if (2 % x) > 1 and (2 % x) < 2 then
		for D = 1000 , 1 , -0.01 do
			Sin = (math.sin(D) * math.sin(D)) * x
		end
	elseif (2 % x) > 0 and (2 % x) < 1 then
		for D = 1 , 1000 , 0.01 do
			Sin = (math.cos(D) * math.cos(D)) * x
		end
	elseif 2 % x == 0 then
		for D = 1000 , 1 , -0.01 do
			Sin = -(math.sin(D) * math.sin(D)) * x
		end
	elseif 2 % x == 1 then
		for D = 1 , 1000 , 0.01 do
			Sin = -(math.cos(D) * math.sin(D)) * x
		end
	elseif 2 % x == 2  then
		for D = 1000 , 1 , -0.01 do
			Sin = -(math.cos(D) * math.cos(D)) * x
		end
	else
		for D = 100 , 1 , -0.02 do
			Sin = -(math.cos(D) * math.cos(D)) * x
		end
	end
	return math.ceil(love.math.random(love.math.random(Sin/1 , Sin/50), love.math.random(Sin/50, Sin/100)))
end

---@diagnostic disable-next-line: undefined-global
function love.load()
	fullscreen = true
	love.window.setFullscreen(fullscreen, "desktop")
	-- Sets a randomeseed
	love.math.randomseed(RandomSeedMaker((os.time()/love.math.random(love.math.random(1, 10), love.math.random(10, 100))) * love.math.random(love.math.random(1, 10), love.math.random(10, 100))))
	--Variables used to increment theb value feed in Sin or Cos
	counter1 = 0
	counter2 = 0
	counter3 = 0
	counter4 = 0
	-- Timers
	GlobalTimer = 0
	ExcatCalculationTime = 0
	ExcatCalculationTime1 = 0
	ExcatCalculationTimeDisplay = 0
	timer = 0
	timer1 = 0
	FractionOfTimeinSeconds = 0
	FractionOfTimeinMilliSeconds = 0
	--Bools to allow execution of some blocks of code
	ThrowDice = false
	AllowFull10Th = false
	AllowS = true
	-- selects GUI to display
	GUIDispay = 0
	-- Variable to count how many consecutive "6" randomely poped up in a row
	SixCounter = 0
	-- Tables to hold objects (in our case rectangles)
	MotherOfObjects = {}
	SpressCopyMotherOfObjects = {}
	-- Get the weight and hight of the screes
	ScrWe = love.graphics.getWidth()
	ScriH = love.graphics.getHeight()
	ScrWe12Per = (ScrWe / 100) * 12
	ScrIH12Per = (ScriH / 100) * 12
	ScrIH15Per = (ScrWe / 100) * 15
	ScrIH16Per = (ScriH / 100) * 16
	ScrWe76Per = (ScrWe / 100) * 76
	ScrIH76Per = (ScriH / 100) * 76
	ScrIH70Per = (ScrWe / 100) * 70
	ScrIH68Per = (ScriH / 100) * 68
	RandomeNumberDisplayPosition = (ScriH/100) * 24
	-- Table to hold rectangles that will select randome rectangles from MotherOfObjects
	RandomeSelector = {}
	SpressCopyRandomeSelector = {}
	--How many objects in multible of 10000 * DiceObRem to creat
	DiceObRem = 0

	-- Remeber custom creation of Rectangles and selectors
	DiceObRem1R = 0
	DiceObRem1S = 0
	--Table to hold values of selected rectangles
	RandomeNumber = {}
	RandomeNumberIndex = 1

	ShowRandomReneratedNumber = 0 -- tatal of selected values
	ShowRandomReneratedNumber1 = 0 -- randomly select a value from the RandomeNumber table
	-- Sets Fonts
	font1 = love.graphics.setNewFont(48)
	font2 = love.graphics.setNewFont(20)
	font3 = love.graphics.setNewFont(31)
	font4 = love.graphics.setNewFont(44)
	
	-- function to create 10000 rectangles or squares
	function DiceMaker(M, DiceObRem)
		for D = 1, M * DiceObRem, 1 do
			local object = {}
			object.divX = love.math.random(1, 12)
			object.divY = love.math.random(1, 12)
			object.x = (math.sin(counter1) * (((ScrWe/1.4))/object.divX * ((math.cos(counter2)) + 1)/2)) + (ScrWe / 2)
			object.y = (math.cos(counter2) * (((ScriH/1.4))/object.divY * ((math.cos(counter2)) + 1)/2)) + (ScriH / 4.2)
			object.r = love.math.random(0 , 100) / 100
			object.g = love.math.random(0 , 100) / 100
			object.b = love.math.random(0 , 100) / 100
			object.width = 1
			object.height = 1
			object.name = love.math.random(1, 6)
			table.insert(MotherOfObjects, object)
			counter1 = counter1 + 0.1
			counter2 = counter2 + 0.1
		end
		ExcatCalculationTimeDisplay = 0
		counter1 = 0
		counter2 = 0
	end
	-- function to create 480 selecting rectangles or squares
	function DiceNumberSelector(M, DiceObRem)
		for D = 1, M * DiceObRem, 1 do
			local object = {}
			object.divX = love.math.random(1, 12)
			object.divY = love.math.random(1, 12)
			object.x = (math.sin(counter1) * (((ScrWe/1.4))/object.divX * ((math.cos(counter2)) + 1)/2)) + (ScrWe / 2)
			object.y = (math.cos(counter2) * (((ScriH/1.4))/object.divY * ((math.cos(counter2)) + 1)/2)) + (ScriH / 4.2)
			object.r =  1 -- math.random(0 , 100) / 100
			object.g =  0 --math.random(0 , 100) / 100
			object.b =  0 --math.random(0 , 100) / 100
			object.width = 1
			object.height = 1
			table.insert(RandomeSelector, object)
			counter3 = counter3 + 1
			counter4 = counter4 + 1
		end
			counter3 = 0
			counter4 = 0
	end
	-- RandomRem1 Remembers random generated timer value
	RandomRem1Timer = 0
end

function love.update(dt)
	if GUIDispay == 2 then
		--Timers working
		GlobalTimer = GlobalTimer + dt
		timer = timer + dt
		-- check before starting the timer
		if ThrowDice then
			timer1 = timer1 + dt
		end
		-- Variable reset
		ShowRandomReneratedNumber = 0
		-- Moves the Rectangles in a pattern
		if (#MotherOfObjects > 0 and #RandomeSelector > 0) then
			for In, val in ipairs(MotherOfObjects) do
				val.x = (math.sin(counter1) * ((((ScrWe/1.4)-((ScrWe/100)*1))/val.divX) * ((math.cos(counter2)) + 1)/2)) + (ScrWe / 2)
				val.y = (math.cos(counter2) * ((((ScriH/1.4)-((ScriH/100)*1))/val.divY) * ((math.cos(counter2)) + 1)/2)) + (ScriH / 4.2)
				counter1 = counter1 + 0.01
				counter2 = counter2 + 0.01
				counter3 = counter3 - 0.01
				counter4 = counter4 - 0.01
			end
			-- Moves the selectors
			if timer > (love.math.random(12, 20)/100) then
				timer = 0
				for In, val in pairs(RandomeSelector) do
					val.x = (math.sin(counter3) * ((((ScrWe/1.4)-((ScrWe/100)*1))/val.divX) * ((math.cos(counter3)) + 1)/2)) + (ScrWe / 2)
					val.y = (math.cos(counter4) * ((((ScriH/1.4)-((ScriH/100)*1))/val.divY) * ((math.cos(counter4)) + 1)/2)) + (ScriH / 4.2)
				end
			end
			-- Runs once timer is greater
			if timer1 >= 1 then
				ExcatCalculationTime = os.clock()
				timer1 = 0
				ThrowDice = false
				for In, val1 in pairs(RandomeSelector) do
					for In, val2 in pairs(MotherOfObjects) do
						-- Based on distance selects the rectangles with values from MotherOfObjects
						if DOTP(val2.x, val2.y, val1.x, val1.y) < (love.math.random(1, 20) / love.math.random(10, 100)) then
							RandomeNumber[RandomeNumberIndex] = tonumber(val2.name)
							ShowRandomReneratedNumber = ShowRandomReneratedNumber + RandomeNumber[RandomeNumberIndex]
							RandomeNumberIndex = RandomeNumberIndex + 1
						end
					end
				end
				-- Selects a randome value from the selected rectangles
				ShowRandomReneratedNumber1 = OutPutBasedOnTypeOfData(RandomeNumber)
				-- If no Values selected
				if ShowRandomReneratedNumber1 == nil then
					ShowRandomReneratedNumber1 = "Less Selectors, try adding more"
				end
				-- Counts consecutive "6"s
				if ShowRandomReneratedNumber1 == 6 then
					SixCounter = SixCounter + 1
				else
					-- resets to 0 if fails to find consecutive "6"s
					SixCounter = 0
				end
				-- If greater than 4 then displays the below message
				if SixCounter > 4 then
					SixCounter = 1 -- Counter reset
					ShowRandomReneratedNumber1 = "You Got Four \"6\" in row WOW!"
				end

				-- Makes Freash Tables
				RandomeNumberIndex = 0
				RandomeNumber = {}
				MotherOfObjects = {}
				RandomeSelector = {}
				-- Collects no longer required tales or object or variables etc from the ram and deletes them
				collectgarbage()
				-- Again setting RandomSeed
				math.randomseed(RandomSeedMaker((os.time()/love.math.random(love.math.random(1, 10), love.math.random(10, 100))) * love.math.random(math.random(1, 10), math.random(10, 100))))
				-- fills Freshly created tables with rectangles and values
				if AllowFull10Th then
					AllowFull10Th = false
					DiceMaker(10000, DiceObRem)
					DiceNumberSelector(480, DiceObRem)
					AllowS = true
					ExcatCalculationTime1 = os.clock()
					ExcatCalculationTimeDisplay =  ExcatCalculationTime1 - ExcatCalculationTime
					FractionOfTimeinSeconds, FractionOfTimeinMilliSeconds = math.modf(ExcatCalculationTimeDisplay)
				end
				--ExcatCalculationTime1 = os.clock()
			end
		end
		-- resets the timer
		if timer1 >= 1 then
			ThrowDice = false
			timer1 = 0
		end
	end
	if ExcatCalculationTimeDisplay > 1 and AllowMinus then
		AllowMinus = false
		ExcatCalculationTimeDisplay = ExcatCalculationTimeDisplay - 1
	end
end

function love.draw()
	if GUIDispay == 0 then
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("line", ScrWe12Per, ScrIH12Per, ScrWe76Per, ScrIH76Per)
		love.graphics.rectangle("line", ScrIH15Per, ScrIH16Per, ScrIH70Per, ScrIH68Per)
		love.graphics.printf(" 1) Press Enter To Start\n 2) Press \"f\" to exit or enter fullscreen\n 3) Press \"escape\" key to exit", font1, ScrIH15Per, ScrIH16Per * 2.5, ScrIH70Per, "center")
	elseif GUIDispay == 1 then
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("line", ScrWe12Per, ScrIH12Per, ScrWe76Per, ScrIH76Per)
		love.graphics.rectangle("line", ScrIH15Per, ScrIH16Per, ScrIH70Per, ScrIH68Per)
		love.graphics.printf(" 1) Press Enter To Start\n 2) Press \"c\" to Generate Rectangles with Randome Values(Press\n\tmore than once to increase the randomness)\n 3) Press \"1\" or \"Numpad 1\" to Generate Selectors(Press more than\n\tonce to increase the randomness)\n 4) Press \"s\" to generate Random Values\n 5) Press \"i\" key to delete the created objects and selectors\n\nFor Quick Start :\n\n 1) Press \"o\" to Generate 10000 Rectangles with Randome Values\n\tand 480 Selectors(Press more than once to increase the\n\trandomness)\n 2) Press \"s\" to generate Random Values\n 3) Press \"r\" to reload the software", font3, ScrIH15Per, ScrIH16Per, ScrIH70Per, "left")
	elseif GUIDispay == 2 then
		--Draws main rectangles 
		for In, Val in pairs(MotherOfObjects) do
			love.graphics.setColor(Val.r, Val.g, Val.b)
			love.graphics.rectangle("fill", Val.x, Val.y, Val.width, Val.height)
		end
		-- Draws selector Rectangles
		for In, Val in pairs(RandomeSelector) do
			love.graphics.setColor(Val.r, Val.g, Val.b)
			love.graphics.rectangle("fill", Val.x, Val.y, Val.width, Val.height)
		end
		-- Prints the Randomly generated number
		love.graphics.setColor(1, 1, 1)
		if ShowRandomReneratedNumber1 then
			love.graphics.printf(ShowRandomReneratedNumber1, font4, 0, RandomeNumberDisplayPosition, ScrWe, "center")
		end
		-- Prints how many rectangles are flooting around
		love.graphics.setColor(1, 0, 1)
		love.graphics.printf( #MotherOfObjects.." Objects  and Selectors : "..#RandomeSelector.." Press \"S\" to throw dice", font2, 0, 3, ScrWe, "center")--, r, sx, sy, ox, oy, kx, ky )
		-- Displays the Timer
		love.graphics.printf( "Timer : "..string.format("%.2d:%.2d:%.2d", GlobalTimer/(60*60), GlobalTimer/60%60, GlobalTimer%60).."\nStarting in Seconds : "..timer1.."\nExacte Calculation Time (Seconds:MilliSeconds) : "..string.format("%.2d:%.3d", (ExcatCalculationTimeDisplay)%60, (FractionOfTimeinMilliSeconds*1000)), font2, 0, 25, ScrWe, "center")--, r, sx, sy, ox, oy, kx, ky )
	elseif GUIDispay == 4 then
		--something
	end
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end

	if key == "return" then
		if GUIDispay < 2 then
			GUIDispay = GUIDispay + 1
		end
	end

	if key == "f" then
		fullscreen = not fullscreen
		love.window.setFullscreen(fullscreen, "desktop")
		ScrWe = love.graphics.getWidth()
		ScriH = love.graphics.getHeight()
		ScrWe12Per = (ScrWe / 100) * 12
		ScrIH12Per = (ScriH / 100) * 12
		ScrIH15Per = (ScrWe / 100) * 15
		ScrIH16Per = (ScriH / 100) * 16
		ScrWe76Per = (ScrWe / 100) * 76
		ScrIH76Per = (ScriH / 100) * 76
		ScrIH70Per = (ScrWe / 100) * 70
		ScrIH68Per = (ScriH / 100) * 68
		font1 = love.graphics.setNewFont(48 * (ScrWe/1550))
		font2 = love.graphics.setNewFont(20 * (ScrWe/1550))
		font3 = love.graphics.setNewFont(31 * (ScrWe/1550))
		font4 = love.graphics.setNewFont(44 * (ScrWe/1550))
		RandomeNumberDisplayPosition = (ScriH/100) * 24
	end

	if GUIDispay == 2 then
		if key == "s" then
			if AllowS then
				AllowMinus = true
				AllowS = false
				AllowFull10Th = true
				ThrowDice = true
			end
		end
	
		if key == "c" then
			ShowRandomReneratedNumber1 = 0
			DiceObRem1R = DiceObRem1R + 1
			DiceMaker(100, DiceObRem1R)
		end
	
		if key == "1" or key == "kp1" then
			ShowRandomReneratedNumber1 = 0
			DiceObRem1S = DiceObRem1S + 1
			DiceNumberSelector(12, DiceObRem1S)
		end
	
		if key == "o" then
			MotherOfObjects = {}
			RandomeSelector = {}
			ShowRandomReneratedNumber1 = 0
			AllowFull10Th = false
			DiceObRem = DiceObRem + 1
			DiceMaker(10000, DiceObRem)
			DiceNumberSelector(480, DiceObRem)
			AllowS = true
		end
		if key == "i" then
			-- Makes Freash Tables
			RandomeNumberIndex = 0
			RandomeNumber = {}
			MotherOfObjects = {}
			RandomeSelector = {}
			ShowRandomReneratedNumber1 = "Objects and Selectors Deleted"
			-- Collects no longer required tales or object or variables etc from the ram and deletes them
			collectgarbage()
			-- Again setting RandomSeed
			love.math.setRandomSeed(RandomSeedMaker((os.time()/love.math.random(math.random(1, 10), love.math.random(10, 100))) * love.math.random(math.random(1, 10), love.math.random(10, 100))))
		end
		if key == "r" then
			love.load()
		end
	end
end
-- Function to calculate distance between two points
function DOTP(x1, y1, x2, y2)
	return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

-- Checks if randomly generated data is a number or something else
function OutPutBasedOnTypeOfData(x)
	love.math.setRandomSeed(RandomSeedMaker((os.time()/love.math.random(love.math.random(1, 10), math.random(10, 100))) * math.random(love.math.random(1, 10), math.random(10, 100))))
	if type(tonumber(x[love.math.random(math.random(1, 10), love.math.random(10, #RandomeNumber))])) == "number" then
		local xx = x[math.random(love.math.random(1, 10), love.math.random(10, #RandomeNumber))]
		for D = 1, 10, 0.1 do
			xx = x[love.math.random(math.random(1,10), love.math.random(10, #RandomeNumber))]
		end
		return xx
	else
		-- change else to elseif and add as many checks
		return 1
	end
end
