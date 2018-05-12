function showBikerGarageGui ()

	gWindow["bikerGarage"] = guiCreateWindow(screenwidth/2-362/2,screenheight/2-136/2,362,136,"Garage",false)
	guiSetAlpha(gWindow["bikerGarage"],1)
	showCursor ( true )
	setElementData ( lp, "ElementClicked", true )
	
	gButton["bikerGarageArmor"] = guiCreateButton(10,77,79,38,"Van\nbeladen",false,gWindow["bikerGarage"])
	guiSetAlpha(gButton["bikerGarageArmor"],1)
	guiSetFont(gButton["bikerGarageArmor"],"default-bold-small")
	gButton["bikerGarageRepair"] = guiCreateButton(97,77,79,38,"Reparieren",false,gWindow["bikerGarage"])
	guiSetAlpha(gButton["bikerGarageRepair"],1)
	guiSetFont(gButton["bikerGarageRepair"],"default-bold-small")
	gButton["bikerGarageArm"] = guiCreateButton(184,77,79,37,"Bewaffnen",false,gWindow["bikerGarage"])
	guiSetAlpha(gButton["bikerGarageArm"],1)
	guiSetFont(gButton["bikerGarageArm"],"default-bold-small")
	gButton["closeGarageGUI"] = guiCreateButton(273,77,79,38,"Schliessen",false,gWindow["bikerGarage"])
	guiSetAlpha(gButton["closeGarageGUI"],1)
	guiSetFont(gButton["closeGarageGUI"],"default-bold-small")
	addEventHandler ( "onClientGUIClick", gButton["closeGarageGUI"],
		function ()
			destroyElement ( gWindow["bikerGarage"] )
			showCursor ( false )
			setElementData ( lp, "ElementClicked", false )
		end,
	false )
	addEventHandler ( "onClientGUIClick", gButton["bikerGarageArm"],
		function ()
			destroyElement ( gWindow["bikerGarage"] )
			showCursor ( false )
			setElementData ( lp, "ElementClicked", false )
			triggerServerEvent ( "onBikershopMenuTest", lp, lp ) 
		end,
	false )
	addEventHandler ( "onClientGUIClick", gButton["bikerGarageRepair"],
		function ()
			triggerServerEvent ( "bikerGarageRecieve", lp, 2 )
		end,
	false )
	addEventHandler ( "onClientGUIClick", gButton["bikerGarageArmor"],
		function ()
			triggerServerEvent ( "bikerGarageRecieve", lp, 4 )
		end,
	false )
	
	gLabel[1] = guiCreateLabel(118,33,146,34,"Damit kannst du vom Van\naus Waffen verkaufen.",false,gWindow["bikerGarage"])
	guiSetAlpha(gLabel[1],1)
	guiLabelSetColor(gLabel[1],200,200,0)
	guiLabelSetVerticalAlign(gLabel[1],"top")
	guiLabelSetHorizontalAlign(gLabel[1],"left",false)
	guiSetFont(gLabel[1],"default-bold-small")
	gLabel[3] = guiCreateLabel(36,117,24,12,"100 $",false,gWindow["bikerGarage"]) -- Armor
	guiSetAlpha(gLabel[3],1)
	guiLabelSetColor(gLabel[3],0,200,0)
	guiLabelSetVerticalAlign(gLabel[3],"top")
	guiLabelSetHorizontalAlign(gLabel[3],"left",false)
	guiSetFont(gLabel[3],"default-small")
	gLabel[4] = guiCreateLabel(124,116,24,12,"10 $",false,gWindow["bikerGarage"]) -- Repair
	guiSetAlpha(gLabel[4],1)
	guiLabelSetColor(gLabel[4],0,200,0)
	guiLabelSetVerticalAlign(gLabel[4],"top")
	guiLabelSetHorizontalAlign(gLabel[4],"left",false)
	guiSetFont(gLabel[4],"default-small")
	gLabel[5] = guiCreateLabel(210,116,24,12,"125 $",false,gWindow["bikerGarage"]) -- Arm
	guiSetAlpha(gLabel[5],1)
	guiLabelSetColor(gLabel[5],0,200,0)
	guiLabelSetVerticalAlign(gLabel[5],"top")
	guiLabelSetHorizontalAlign(gLabel[5],"left",false)
	guiSetFont(gLabel[5],"default-small")
end

local marker = createMarker ( 2446.498046875, 1584.8681640625, 10.078818321228, "cylinder", 5, 255, 0, 0, 150 )
addEventHandler ( "onClientMarkerHit", marker, 
	function ( hit, dim )
		if hit == lp and dim then
		
			local veh = getPedOccupiedVehicle ( lp )
			
			if veh then
			
				if getVehicleOccupant( veh ) == lp then
					showBikerGarageGui ()
				end
			
			else
				showBikerGarageGui ()
			end			
			
		end
	end
)

local marker2 = createMarker ( -2246.0700683594, -2310.4572753906, 29.894678115845, "cylinder", 5, 255, 0, 0, 150 )
addEventHandler ( "onClientMarkerHit", marker2, 
	function ( hit, dim )
		
		if hit == lp and dim then
		
			local veh = getPedOccupiedVehicle ( lp )
			
			if veh then
			
				if getVehicleOccupant( veh ) == lp then
					showBikerGarageGui ()
				end
			
			else
				showBikerGarageGui ()
			end			
			
		end
		
	end
)

function bikerKnockingOff ( bool )

	setPedCanBeKnockedOffBike ( lp, bool )

end

addEvent( "onBikerBoolGiven", true )
addEventHandler( "onBikerBoolGiven", getRootElement(), bikerKnockingOff )