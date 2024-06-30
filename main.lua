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
			Sin = (math.sin(D) * math.sin(D)) * x
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
	return math.ceil(math.random(math.random(Sin/50 , Sin/100), math.random(Sin/1, Sin/50)))
end

---@diagnostic disable-next-line: undefined-global
function love.load()
	-- Sets a randomeseed
	math.randomseed(RandomSeedMaker((os.time()/math.random(math.random(1, 10), math.random(10, 100))) * math.random(math.random(1, 10), math.random(10, 100))))
	--Variables used to increment theb value feed in Sin or Cos
	counter1 = 0
	counter2 = 0
	counter3 = 0
	counter4 = 0
	-- Timers
	GlobalTimer = 0
	timer = 0
	timer1 = 0
	--Bools to allow execution of some blocks of code
	ThrowDice = false
	AllowFull10Th = false
	AllowS = true
	-- Variable to count how many consecutive "6" randomely poped up in a row
	SixCounter = 0
	-- Tables to hold objects (in our case rectangles)
	MotherOfObjects = {}
	SpressCopyMotherOfObjects = {}
	-- Get the weight and hight of the screes
	ScrWe = love.graphics.getWidth()
	ScriH = love.graphics.getHeight()
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
	font2 = love.graphics.setNewFont(12)
	
	-- function to create 10000 rectangles or squares
	function DiceMaker(M, DiceObRem)
		for D = 1, M * DiceObRem, 1 do
			local object = {}
			object.divX = math.random(1, 12)
			object.divY = math.random(1, 12)
			object.x = (math.sin(counter1) * (((ScrWe/1.4))/object.divX * ((math.cos(counter2)) + 1)/2)) + (ScrWe / 2)
			object.y = (math.cos(counter2) * (((ScriH/1.4))/object.divY * ((math.cos(counter2)) + 1)/2)) + (ScriH / 4.2)
			object.r = math.random(0 , 100) / 100
			object.g = math.random(0 , 100) / 100
			object.b = math.random(0 , 100) / 100
			object.width = 1
			object.height = 1
			object.name = math.random(1, 6)
			table.insert(MotherOfObjects, object)
			counter1 = counter1 + 0.1
			counter2 = counter2 + 0.1
		end

		counter1 = 0
		counter2 = 0
	end
	-- function to create 480 selecting rectangles or squares
	function DiceNumberSelector(M, DiceObRem)
		for D = 1, M * DiceObRem, 1 do
			local object = {}
			object.divX = math.random(1, 12)
			object.divY = math.random(1, 12)
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

		if timer > (math.random(12, 20)/100) then
			timer = 0
			for In, val in pairs(RandomeSelector) do
				val.x = (math.sin(counter3) * ((((ScrWe/1.4)-((ScrWe/100)*1))/val.divX) * ((math.cos(counter3)) + 1)/2)) + (ScrWe / 2)
				val.y = (math.cos(counter4) * ((((ScriH/1.4)-((ScriH/100)*1))/val.divY) * ((math.cos(counter4)) + 1)/2)) + (ScriH / 4.2)
			end
		end
		-- Runs once timer is greater
		if timer1 >= 1 then
			timer1 = 0
			ThrowDice = false
			for In, val1 in pairs(RandomeSelector) do
				for In, val2 in pairs(MotherOfObjects) do
					if DOTP(val2.x, val2.y, val1.x, val1.y) < (math.random(1, 20) / math.random(10, 100)) then
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
			math.randomseed(RandomSeedMaker((os.time()/math.random(math.random(1, 10), math.random(10, 100))) * math.random(math.random(1, 10), math.random(10, 100))))
			-- filles Freshly created tables with rectangles and values
			if AllowFull10Th then
				AllowFull10Th = false
				DiceMaker(10000, DiceObRem)
				DiceNumberSelector(480, DiceObRem)
				AllowS = true
			end
		end
	end
	if timer1 >= 1 then
		ThrowDice = false
		timer1 = 0
	end
end

function love.draw()
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
		love.graphics.printf(ShowRandomReneratedNumber1, font1, 0, 76, ScrWe, "center")
	end
	-- Prints how many rectangles are flooting around
	love.graphics.setColor(1, 0, 1)
	love.graphics.printf( #MotherOfObjects.." Objects  and Selectors : "..#RandomeSelector.." Press \"S\" to throw dice", font2, 0, 3, ScrWe, "center")--, r, sx, sy, ox, oy, kx, ky )
	-- Displays the Timer
	love.graphics.printf( "Timer : "..math.ceil(GlobalTimer).."\nCalculating in Seconds : "..timer1, font2, 0, 25, ScrWe, "center")--, r, sx, sy, ox, oy, kx, ky )

end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	end

	if key == "s" then
		if AllowS then
			AllowS = false
			AllowFull10Th = true
			ThrowDice = true
		end
	end

	if key == "c" then
		DiceObRem1R = DiceObRem1R + 1
		DiceMaker(100, DiceObRem1R)
	end

	if key == "1" or key == "kp1" then
		DiceObRem1S = DiceObRem1S + 1
		DiceNumberSelector(12, DiceObRem1S)
	end

	if key == "o" then
		AllowFull10Th = false
		DiceObRem = DiceObRem + 1
		DiceMaker(10000, DiceObRem)
		DiceNumberSelector(480, DiceObRem)
		AllowS = true
	end
	if key == "r" then
		love.load()
	end
end
-- Function to calculate distance between two points
function DOTP(x1, y1, x2, y2)
	return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

-- Checks if randomly generated data is a number or something else
function OutPutBasedOnTypeOfData(x)
	math.randomseed(RandomSeedMaker((os.time()/math.random(math.random(1, 10), math.random(10, 100))) * math.random(math.random(1, 10), math.random(10, 100))))
	if type(tonumber(x[math.random(math.random(1, 10), math.random(10, #RandomeNumber))])) == "number" then
 		local xx = x[math.random(math.random(1, 10), math.random(10, #RandomeNumber))]
		for D = 1, 10, 0.01 do
			xx = x[math.random(math.random(1,10), math.random(10, #RandomeNumber))]
		end
		return xx
	else
		-- change else to elseif and add as many checks
	end
end
