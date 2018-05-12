-------------------------
------- (c) 2009 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

gButton = {}
gLabel = {}

function showVincenzosGunshop_func()

	guiSetVisible ( WaffenauswahlFenster, true )
	showCursor ( true )
	setElementData ( lp, "ElementClicked", true )
end
addEvent ( "showVincenzosGunshop", true)
addEventHandler ( "showVincenzosGunshop", getRootElement(), showVincenzosGunshop_func)

function SubmitVincenzosGunshopAbbrechenBtn (btn)

	if btn == "left" then
		guiSetVisible ( WaffenauswahlFenster, false )
		showCursor ( false )
		triggerServerEvent ( "cancel_gui_server", lp )
	end
end
addEvent ( "SubmitVincenzosGunshopAbbrechen", true)
addEventHandler ( "SubmitVincenzosGunshopAbbrechen", getRootElement(), SubmitVincenzosGunshopAbbrechenBtn)

gunshopCasino = createMarker ( 2176.7465820313, 1619.2484130859, 998.951171875, "cylinder", 1.5, 125, 0, 0, 150 )
setElementInterior ( gunshopCasino, 1 )
addEventHandler ( "onClientMarkerHit", gunshopCasino,
	function ( hit, dim )
		if dim and hit == lp then
			local x1, y1, z1 = getElementPosition ( source )
			local x2, y2, z2 = getElementPosition ( hit )
			if getDistanceBetweenPoints3D ( x1, y1, z1, x2, y2, z2 ) < 5 then
				showVincenzosGunshop_func()
			end
		end
	end
)

function SubmitVincenzosGunshopBaseballBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "baseballbat", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopSchaufelBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "schaufel", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopMesserBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "messer", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopSchlagringBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "schlagring", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshop9mmBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "9mm", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshop9mmSDBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "9mmsd", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopDeagleBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "eagle", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopMp5Btn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "mp5", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopShotgunBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "shotty", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopAk47Btn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "ak47", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopM4Btn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "m4", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopGewehrBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "gewehr", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopSGewehrBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "sniper", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopRaketenwerferBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "raketenwerfer", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopLuparaBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "gun", "lupara", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopArmorBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "armor", "armor" )
	end
end

function SubmitVincenzosGunshop9mmAmmoBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "ammo", "9mmammo", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopEagleAmmoBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "ammo", "eagleammo", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopMp5AmmoBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "ammo", "mp5ammo", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopSchrotBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "ammo", "schrot", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopAk47AmmoBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "ammo", "ak47ammo", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopM4AmmoBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "ammo", "m4ammo", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopGewehrAmmoBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "ammo", "gewehrammo", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopSGewehrAmmoBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "ammo", "sgewehrammo", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function SubmitVincenzosGunshopRaketeBtn ( btn )

	if btn == "left" then
		local w0 = getPedWeapon ( lp, 0 )
		local w1 = getPedWeapon ( lp, 1 )
		local w2 = getPedWeapon ( lp, 2 )
		local w3 = getPedWeapon ( lp, 3 )
		local w4 = getPedWeapon ( lp, 4 )
		local w5 = getPedWeapon ( lp, 5 )
		local w6 = getPedWeapon ( lp, 6 )
		local w7 = getPedWeapon ( lp, 7 )
		triggerServerEvent ( "gunbuy", lp, lp, "ammo", "rocket", w0, w1, w2, w3, w4, w5, w6, w7 )
	end
end

function _CreateVincenzosGunshop ()

	local screenwidth, screenheight = guiGetScreenSize ()
	
	WaffenauswahlFenster = guiCreateWindow(screenwidth/2-319/2,screenheight/2-613/2,319,613,"Waffenauswahl",false)
	guiSetAlpha(WaffenauswahlFenster,1)
	Introtext = guiCreateLabel(0.0376,0.0375,0.953,0.0816,"Comesta?\nWillkommen bei Vincenzos Waffenladen - Der beste in\nganz San Andreas!",true,WaffenauswahlFenster)
	guiSetAlpha(Introtext,1)
	guiLabelSetColor(Introtext,255,255,255)
	guiLabelSetVerticalAlign(Introtext,"top")
	guiLabelSetHorizontalAlign(Introtext,"left",false)
	
	gLabel["pistolen"] = guiCreateLabel(0.0345,0.2414,0.1818,0.0245,"Pistolen",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["pistolen"],1)
	guiLabelSetColor(gLabel["pistolen"],125,000,20)
	guiLabelSetVerticalAlign(gLabel["pistolen"],"top")
	guiLabelSetHorizontalAlign(gLabel["pistolen"],"left",false)
	gLabel["meele"] = guiCreateLabel(0.0345,0.1256,0.1881,0.0277,"Nahkampf",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["meele"],1)
	guiLabelSetColor(gLabel["meele"],125,000,20)
	guiLabelSetVerticalAlign(gLabel["meele"],"top")
	guiLabelSetHorizontalAlign(gLabel["meele"],"left",false)
	gLabel["mps"] = guiCreateLabel(0.0345,0.3573,0.3197,0.0245,"Maschinenpistolen",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["mps"],1)
	guiLabelSetColor(gLabel["mps"],125,0,20)
	guiLabelSetVerticalAlign(gLabel["mps"],"top")
	guiLabelSetHorizontalAlign(gLabel["mps"],"left",false)
	gLabel["shotguns"] = guiCreateLabel(0.4044,0.3573,0.3197,0.0245,"Schrotflinten",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["shotguns"],1)
	guiLabelSetColor(gLabel["shotguns"],125,0,20)
	guiLabelSetVerticalAlign(gLabel["shotguns"],"top")
	guiLabelSetHorizontalAlign(gLabel["shotguns"],"left",false)
	gLabel["sturmgewehre"] = guiCreateLabel(0.0345,0.4878,0.3135,0.0245,"Sturmgewehre",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["sturmgewehre"],1)
	guiLabelSetColor(gLabel["sturmgewehre"],125,000,25)
	guiLabelSetVerticalAlign(gLabel["sturmgewehre"],"top")
	guiLabelSetHorizontalAlign(gLabel["sturmgewehre"],"left",false)
	gLabel["gewehre"] = guiCreateLabel(0.4013,0.4878,0.1787,0.0245,"Gewehre",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["gewehre"],1)
	guiLabelSetColor(gLabel["gewehre"],125,0,25)
	guiLabelSetVerticalAlign(gLabel["gewehre"],"top")
	guiLabelSetHorizontalAlign(gLabel["gewehre"],"left",false)
	gLabel["sonstiges"] = guiCreateLabel(0.0345,0.6003,0.3135,0.0245,"Sonstiges",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["sonstiges"],1)
	guiLabelSetColor(gLabel["sonstiges"],125,0,25)
	guiLabelSetVerticalAlign(gLabel["sonstiges"],"top")
	guiLabelSetHorizontalAlign(gLabel["sonstiges"],"left",false)
	gLabel["ammo"] = guiCreateLabel(0.0345,0.7129,0.3135,0.0245,"Munition",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["ammo"],1)
	guiLabelSetColor(gLabel["ammo"],125,0,25)
	guiLabelSetVerticalAlign(gLabel["ammo"],"top")
	guiLabelSetHorizontalAlign(gLabel["ammo"],"left",false)
	
	gLabel["baseball"] = guiCreateLabel(0.0282,0.207,0.2,0.0245,"  "..baseball_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["baseball"],1)
	guiLabelSetColor(gLabel["baseball"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["baseball"],"top")
	guiLabelSetHorizontalAlign(gLabel["baseball"],"left",false)
	gLabel["shovel"] = guiCreateLabel(0.3668,0.207,0.2,0.033,"  "..shovels_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["shovel"],1)
	guiLabelSetColor(gLabel["shovel"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["shovel"],"top")
	guiLabelSetHorizontalAlign(gLabel["shovel"],"left",false)
	gLabel["knife"] = guiCreateLabel(0.5768,0.207,0.2,0.0277,"  "..knife_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["knife"],1)
	guiLabelSetColor(gLabel["knife"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["knife"],"top")
	guiLabelSetHorizontalAlign(gLabel["knife"],"left",false)
	gLabel["ring"] = guiCreateLabel(0.7649,0.207,0.2,0.0261,"  "..schlagringe_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["ring"],1)
	guiLabelSetColor(gLabel["ring"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["ring"],"top")
	guiLabelSetHorizontalAlign(gLabel["ring"],"left",false)
	gLabel["9mm"] = guiCreateLabel(0.0282,0.3263,0.2,0.0245,"  "..pistol_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["9mm"],1)
	guiLabelSetColor(gLabel["9mm"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["9mm"],"top")
	guiLabelSetHorizontalAlign(gLabel["9mm"],"left",false)
	gLabel["9mmsd"] = guiCreateLabel(0.2038,0.3263,0.2,0.033,"  "..sdpistol_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["9mmsd"],1)
	guiLabelSetColor(gLabel["9mmsd"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["9mmsd"],"top")
	guiLabelSetHorizontalAlign(gLabel["9mmsd"],"left",false)
	gLabel["deagle"] = guiCreateLabel(0.5611,0.3263,0.2,0.033,"  "..eagle_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["deagle"],1)
	guiLabelSetColor(gLabel["deagle"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["deagle"],"top")
	guiLabelSetHorizontalAlign(gLabel["deagle"],"left",false)
	gLabel["mp5"] = guiCreateLabel(0.0313,0.4454,0.2,0.0245,"  "..mp_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["mp5"],1)
	guiLabelSetColor(gLabel["mp5"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["mp5"],"top")
	guiLabelSetHorizontalAlign(gLabel["mp5"],"left",false)
	gLabel["shotgun"] = guiCreateLabel(0.4044,0.4454,0.2,0.0245,"  "..shotgun_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["shotgun"],1)
	guiLabelSetColor(gLabel["shotgun"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["shotgun"],"top")
	guiLabelSetHorizontalAlign(gLabel["shotgun"],"left",false)
	gLabel["ak47"] = guiCreateLabel(0.0282,0.5726,0.2,0.1,"  "..ak_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["ak47"],1)
	guiLabelSetColor(gLabel["ak47"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["ak47"],"top")
	guiLabelSetHorizontalAlign(gLabel["ak47"],"left",false)
	gLabel["m4"] = guiCreateLabel(0.2069,0.5726,0.2,0.05,"  "..m_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["m4"],1)
	guiLabelSetColor(gLabel["m4"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["m4"],"top")
	guiLabelSetHorizontalAlign(gLabel["m4"],"left",false)
	gLabel["gewehr"] = guiCreateLabel(0.4013,0.5726,0.2,0.05,"  "..gewehr_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["gewehr"],1)
	guiLabelSetColor(gLabel["gewehr"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["gewehr"],"top")
	guiLabelSetHorizontalAlign(gLabel["gewehr"],"left",false)
	gLabel["sgewehr"] = guiCreateLabel(0.5831,0.5726,0.2,0.05,"  "..sgewehr_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["sgewehr"],1)
	guiLabelSetColor(gLabel["sgewehr"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["sgewehr"],"top")
	guiLabelSetHorizontalAlign(gLabel["sgewehr"],"left",false)
	gLabel["raklauncher"] = guiCreateLabel(0.0376,0.6835,0.2,0.0245,"  "..rakwerfer_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["raklauncher"],1)
	guiLabelSetColor(gLabel["raklauncher"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["raklauncher"],"top")
	guiLabelSetHorizontalAlign(gLabel["raklauncher"],"left",false)
	gLabel["lupara"] = guiCreateLabel(0.5266,0.6835,0.2,0.0245,"  "..spezgun_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["lupara"],1)
	guiLabelSetColor(gLabel["lupara"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["lupara"],"top")
	guiLabelSetHorizontalAlign(gLabel["lupara"],"left",false)
	gLabel["armor"] = guiCreateLabel(0.3229,0.6835,0.2,0.0245,"  "..armor_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["armor"],1)
	guiLabelSetColor(gLabel["armor"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["armor"],"top")
	guiLabelSetHorizontalAlign(gLabel["armor"],"left",false)
	gLabel["9mmammo"] = guiCreateLabel(0.0282,0.7945,0.2,0.0245,"  "..pistolammo_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["9mmammo"],1)
	guiLabelSetColor(gLabel["9mmammo"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["9mmammo"],"top")
	guiLabelSetHorizontalAlign(gLabel["9mmammo"],"left",false)
	gLabel["deagleammo"] = guiCreateLabel(0.2257,0.7945,0.2,0.0245,"  "..eagleammo_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["deagleammo"],1)
	guiLabelSetColor(gLabel["deagleammo"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["deagleammo"],"top")
	guiLabelSetHorizontalAlign(gLabel["deagleammo"],"left",false)
	gLabel["mp5ammo"] = guiCreateLabel(0.4922,0.7945,0.2,0.0245,"  "..mpammo_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["mp5ammo"],1)
	guiLabelSetColor(gLabel["mp5ammo"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["mp5ammo"],"top")
	guiLabelSetHorizontalAlign(gLabel["mp5ammo"],"left",false)
	gLabel["schrot"] = guiCreateLabel(0.0345,0.8728,0.2,0.0245,"  "..shotgunammo_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["schrot"],1)
	guiLabelSetColor(gLabel["schrot"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["schrot"],"top")
	guiLabelSetHorizontalAlign(gLabel["schrot"],"left",false)
	gLabel["akammo"] = guiCreateLabel(0.3041,0.8728,0.2,0.0245,"  "..akammo_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["akammo"],1)
	guiLabelSetColor(gLabel["akammo"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["akammo"],"top")
	guiLabelSetHorizontalAlign(gLabel["akammo"],"left",false)
	gLabel["m4ammo"] = guiCreateLabel(0.5862,0.8728,0.2,0.0245,"  "..mammo_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["m4ammo"],1)
	guiLabelSetColor(gLabel["m4ammo"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["m4ammo"],"top")
	guiLabelSetHorizontalAlign(gLabel["m4ammo"],"left",false)
	gLabel["gewehrammo"] = guiCreateLabel(0.0313,0.9543,2,0.0245,"  "..gewehrammo_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["gewehrammo"],1)
	guiLabelSetColor(gLabel["gewehrammo"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["gewehrammo"],"top")
	guiLabelSetHorizontalAlign(gLabel["gewehrammo"],"left",false)
	gLabel["sgewehrammo"] = guiCreateLabel(0.3354,0.9543,2,0.0245,"  "..sgewehrammo_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["sgewehrammo"],1)
	guiLabelSetColor(gLabel["sgewehrammo"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["sgewehrammo"],"top")
	guiLabelSetHorizontalAlign(gLabel["sgewehrammo"],"left",false)
	gLabel["raketen"] = guiCreateLabel(0.6646,0.9543,0.2,0.0245,"  "..rak_price.." $",true,WaffenauswahlFenster)
	guiSetAlpha(gLabel["raketen"],1)
	guiLabelSetColor(gLabel["raketen"],000,125,000)
	guiLabelSetVerticalAlign(gLabel["raketen"],"top")
	guiLabelSetHorizontalAlign(gLabel["raketen"],"left",false)
	
	gButton["mgunshopcancel"] = guiCreateButton(0.7649,0.1,0.2038,0.0457,"Abbrechen",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["mgunshopcancel"],1)
	gButton["baseball"] = guiCreateButton(0.0282,0.1582,0.3229,0.0457,"Baseballschlaeger",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["baseball"],1)
	gButton["shovel"] = guiCreateButton(0.3668,0.1582,0.1944,0.0457,"Schaufel",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["shovel"],1)
	gButton["knife"] = guiCreateButton(0.5768,0.1582,0.1724,0.0457,"Messer",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["knife"],1)
	gButton["schlagring"] = guiCreateButton(0.7649,0.1582,0.2038,0.0457,"Schlagring",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["schlagring"],1)
	gButton["9mm"] = guiCreateButton(0.0282,0.2724,0.1567,0.0457,"9mm",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["9mm"],1)
	gButton["9mmSD"] = guiCreateButton(0.2038,0.2724,0.3417,0.0457,"9mm Schallgedaempft",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["9mmSD"],1)
	gButton["deagle"] = guiCreateButton(0.5611,0.2724,0.2602,0.0457,"Desert Eagle",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["deagle"],1)
	gButton["mp5"] = guiCreateButton(0.0313,0.3915,0.1567,0.0457,"MP5",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["mp5"],1)
	gButton["shotgun"] = guiCreateButton(0.4044,0.3899,0.2445,0.0457,"Schrotflinte",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["shotgun"],1)
	gButton["ak-47"] = guiCreateButton(0.0282,0.5204,0.1567,0.0457,"AK-47",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["ak-47"],1)
	gButton["m4"] = guiCreateButton(0.2069,0.5204,0.1003,0.0457,"M4",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["m4"],1)
	gButton["gewehr"] = guiCreateButton(0.4013,0.5188,0.1693,0.0457,"Gewehr",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["gewehr"],1)
	gButton["sgewehr"] = guiCreateButton(0.5831,0.5188,0.3292,0.0457,"Scharfschuetzen-\ngewehr",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["sgewehr"],1)
	gButton["raketenwerfer"] = guiCreateButton(0.0313,0.6281,0.2727,0.0457,"Raketenwerfer",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["raketenwerfer"],1)
	gButton["lupara"] = guiCreateButton(0.3229,0.6281,0.1787,0.0457,"Lupara",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["lupara"],1)
	gButton["armor"] = guiCreateButton(0.5266,0.6281,0.2445,0.0457,"Schusssichere\nWeste",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["armor"],1)
	gButton["9mmammo"] = guiCreateButton(0.0282,0.7439,0.1787,0.0457,"9mm Magazin",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["9mmammo"],1)
	gButton["eagleammo"] = guiCreateButton(0.2257,0.7439,0.2508,0.0457,"Desert Eagle Magazin",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["eagleammo"],1)
	gButton["mp5ammo"] = guiCreateButton(0.4922,0.7439,0.2508,0.0457,"MP5 Magazin",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["mp5ammo"],1)
	gButton["schrot"] = guiCreateButton(0.0282,0.8254,0.2602,0.0457,"Schrotkugeln",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["schrot"],1)
	gButton["ak-47ammo"] = guiCreateButton(0.3041,0.8254,0.2602,0.0457,"AK-47 Magazin",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["ak-47ammo"],1)
	gButton["m4ammo"] = guiCreateButton(0.5862,0.8238,0.2226,0.0457,"M4 Magazin",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["m4ammo"],1)
	gButton["gewehrammo"] = guiCreateButton(0.0313,0.9021,0.2821,0.0457,"Gewehrpatrone",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["gewehrammo"],1)
	gButton["sgewehrammo"] = guiCreateButton(0.3354,0.9021,0.3135,0.0457,"Scharfschuetzen\nPatrone",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["sgewehrammo"],1)
	gButton["rakete"] = guiCreateButton(0.6646,0.9021,0.2038,0.0457,"Rakete",true,WaffenauswahlFenster)
	guiSetAlpha(gButton["rakete"],1)
	
	guiWindowSetMovable ( WaffenauswahlFenster, false )
	guiWindowSetSizable  ( WaffenauswahlFenster, false )
	
	addEventHandler("onClientGUIClick", gButton["mgunshopcancel"], SubmitVincenzosGunshopAbbrechenBtn, false)
	addEventHandler("onClientGUIClick", gButton["baseball"], SubmitVincenzosGunshopBaseballBtn, false)
	addEventHandler("onClientGUIClick", gButton["shovel"], SubmitVincenzosGunshopSchaufelBtn, false)
	addEventHandler("onClientGUIClick", gButton["knife"], SubmitVincenzosGunshopMesserBtn, false)
	addEventHandler("onClientGUIClick", gButton["schlagring"], SubmitVincenzosGunshopSchlagringBtn, false)
	addEventHandler("onClientGUIClick", gButton["9mm"], SubmitVincenzosGunshop9mmBtn, false)
	addEventHandler("onClientGUIClick", gButton["9mmSD"], SubmitVincenzosGunshop9mmSDBtn, false)
	addEventHandler("onClientGUIClick", gButton["deagle"], SubmitVincenzosGunshopDeagleBtn, false)
	addEventHandler("onClientGUIClick", gButton["mp5"], SubmitVincenzosGunshopMp5Btn, false)
	addEventHandler("onClientGUIClick", gButton["shotgun"], SubmitVincenzosGunshopShotgunBtn, false)
	addEventHandler("onClientGUIClick", gButton["ak-47"], SubmitVincenzosGunshopAk47Btn, false)
	addEventHandler("onClientGUIClick", gButton["m4"], SubmitVincenzosGunshopM4Btn, false)
	addEventHandler("onClientGUIClick", gButton["gewehr"], SubmitVincenzosGunshopGewehrBtn, false)
	addEventHandler("onClientGUIClick", gButton["sgewehr"], SubmitVincenzosGunshopSGewehrBtn, false)
	addEventHandler("onClientGUIClick", gButton["raketenwerfer"], SubmitVincenzosGunshopRaketenwerferBtn, false)
	addEventHandler("onClientGUIClick", gButton["lupara"], SubmitVincenzosGunshopLuparaBtn, false)
	addEventHandler("onClientGUIClick", gButton["armor"], SubmitVincenzosGunshopArmorBtn, false)
	addEventHandler("onClientGUIClick", gButton["9mmammo"], SubmitVincenzosGunshop9mmAmmoBtn, false)
	addEventHandler("onClientGUIClick", gButton["eagleammo"], SubmitVincenzosGunshopEagleAmmoBtn, false)
	addEventHandler("onClientGUIClick", gButton["mp5ammo"], SubmitVincenzosGunshopMp5AmmoBtn, false)
	addEventHandler("onClientGUIClick", gButton["schrot"], SubmitVincenzosGunshopSchrotBtn, false)
	addEventHandler("onClientGUIClick", gButton["ak-47ammo"], SubmitVincenzosGunshopAk47AmmoBtn, false)
	addEventHandler("onClientGUIClick", gButton["m4ammo"], SubmitVincenzosGunshopM4AmmoBtn, false)
	addEventHandler("onClientGUIClick", gButton["gewehrammo"], SubmitVincenzosGunshopGewehrAmmoBtn, false)
	addEventHandler("onClientGUIClick", gButton["sgewehrammo"], SubmitVincenzosGunshopSGewehrAmmoBtn, false)
	addEventHandler("onClientGUIClick", gButton["rakete"], SubmitVincenzosGunshopRaketeBtn, false)
	
	guiSetVisible ( WaffenauswahlFenster, false )
end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function ()
		_CreateVincenzosGunshop()
	end
)