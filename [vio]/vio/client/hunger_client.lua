-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

foodBarX = math.floor ( screenwidth / 1.1707 ) - 1
foodBarY = math.floor ( screenheight / 6.6666 ) - 1
foodBarWidth = math.floor ( screenwidth / 10.37 )
foodBarHeight = math.floor ( screenheight / 51.42 )
foodBarY = foodBarY - ( ( 32 / 1080 ) * screenheight ) / 2 - foodBarHeight / 2

setElementData ( lp, "hunger", 50, false )

local showingFoodBar = false

function showHungerBar()

	if tonumber ( getElementData ( lp, "loggedin" ) ) == 1 and not isCursorShowing () then
		if not showingFoodBar then
			addEventHandler ( "onClientRender", getRootElement(), drawFoodBar )
			showingFoodBar = true
		end
	end
end

function drawFoodBar ()

	local x, y, width, height = foodBarX, foodBarY, foodBarWidth, foodBarHeight
	
	local hunger = getElementData ( lp, "hunger" ) / 100
	
	local spaceBarSize = screenwidth / ( 1920 / 5 )
	local hungerWidth = ( width - spaceBarSize * 2 ) * hunger
	hungerWidth = spaceBarSize + hungerWidth
	
	dxDrawImage ( x, y, width, height, "images/gui/hunger_empty.png", 0, 0, 0, nil, true )
	dxDrawImageSection ( x-1, y-1, hungerWidth, height, 1, 1, hungerWidth, height, "images/gui/hunger_full.png", 0, 0, 0, nil, true )
end

function hungerDeathFix ()

	if source == lp then
		setElementData ( lp, "hunger", 40 )
	end
end
addEventHandler ( "onClientPlayerWasted", getRootElement(), hungerDeathFix )

function hideHungerBar()

	if showingFoodBar then
		removeEventHandler ( "onClientRender", getRootElement(), drawFoodBar )
		showingFoodBar = false
	end
end

function moreHunger()

	if getElementData ( lp, "jailtime" ) then
		if getElementData ( lp, "jailtime" ) <= 0 and not pokering and not invulnerable then
			local curhunger = getElementData ( lp, "hunger" ) - 1
			if curhunger < 0 then curhunger = 0 end
			setElementData ( lp, "hunger", curhunger, false )
			if curhunger == 33 then
				outputChatBox ( "Besorg dir bald etwas zu essen, oder du faengst an, zu verhungern!", 125, 0, 0 )
			elseif curhunger < 25 then
				local loss = math.floor((25-curhunger)/2*20)/10
				setElementHealth ( lp, getElementHealth ( lp ) - loss )
				hudEinblendenDmg_func ( 0, 0, 0, 0, true )
			end
		end
	end
end
setTimer ( moreHunger, 50000, -1 )

function eatSomething_func ( value )

	if not value then value = 100 end
	setElementData ( lp, "hunger", getElementData ( lp, "hunger" )+value, false )
	if getElementData ( lp, "hunger" ) > 100 then
		setElementData ( lp, "hunger", 100, false )
	end
	showHungerBar()
	setTimer ( hideHungerBar, 4000, 1 )
end
addEvent ( "eatSomething", true )
addEventHandler ( "eatSomething", getRootElement(), eatSomething_func )