﻿-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function showStats ()

	if gWindow["stats"] then
		destroyElement ( gWindow["stats"] )
		createStatsWindow ()
	else
		createStatsWindow ()
	end
end

function createStatsWindow()

	local buttonText = guiGetText ( gButtons["selfstatus"] )
	if buttonText == "Sucht" then
		showAddictInfo_func ( false )
		guiSetText ( gButtons["selfstatus"], "Achiev-\nments" )
	elseif buttonText == "Achiev-\nments" then
		showAchievmentWindow ()
		guiSetVisible ( gWindow["suchtInfo"], false )
		guiSetText ( gButtons["selfstatus"], "Status" )
	else
		guiSetVisible ( gWindow["achievmentList"], false )
		guiSetText ( gButtons["selfstatus"], "Sucht" )
		
		local job = jobNames [ getElementData ( lp, "job" ) ]
		fraktion = tonumber ( getElementData ( lp, "fraktion" ) )
		fraktion = fraktionsNamen[fraktion]
		if not fraktion then
			fraktion = "Zivilist"
		end
		if not job then
			job = "Arbeitslos"
		end
		local playtime = getElementData ( lp, "playingtime" )
		local playtimehours = math.floor(playtime/60)
		local playtimeminutes = playtime-playtimehours*60
		if playtimeminutes < 10 then
			playtimeminutes = "0"..playtimeminutes
		end
		local playtime = playtimehours..":"..playtimeminutes
		local todayMinutes = getElementData ( lp, "timePlayedToday" ) - math.floor ( getElementData ( lp, "timePlayedToday" ) / 60 ) * 60
		if todayMinutes < 10 then
			todayMinutes = "0"..todayMinutes
		end
		local playtimeToday = math.floor ( getElementData ( lp, "timePlayedToday" ) / 60 )..":"..todayMinutes
		if getElementData ( lp, "perso" ) == 1 then p = "[x]" else p = "[_]" end
		if getElementData ( lp, "carlicense" ) == 1 then cl = "[x]" else cl = "[_]" end
		if getElementData ( lp, "bikelicense" ) == 1 then bl = "[x]" else bl = "[_]" end
		if getElementData ( lp, "fishinglicense" ) == 1 then fl = "[x]" else fl = "[_]" end
		if getElementData ( lp, "lkwlicense" ) == 1 then ll = "[x]" else ll = "[_]" end
		if getElementData ( lp, "gunlicense" ) == 1 then gl = "[x]" else gl = "[_]" end
		if getElementData ( lp, "motorbootlicense" ) == 1 then mbl = "[x]" else mbl = "[_]" end
		if getElementData ( lp, "segellicense" ) == 1 then sl = "[x]" else sl = "[_]" end
		if getElementData ( lp, "planelicenseb" ) == 1 then pbl = "[x]" else pbl = "[_]" end
		if getElementData ( lp, "planelicensea" ) == 1 then pal = "[x]" else pal = "[_]" end
		if getElementData ( lp, "helilicense" ) == 1 then hl = "[x]" else hl = "[_]" end
		local gwd = getElementData ( lp, "armyperm9" )
		if not gwd then
			gwd = "0 %"
		else
			gwd = gwd.." %"
		end
		gWindow["stats"] = guiCreateWindow(screenwidth/2-477/2,120,477,370,"Persoenliche Informationen",false)
		guiSetAlpha(gWindow["stats"],1)
		guiWindowSetMovable(gWindow["stats"])
		guiWindowSetSizable(gWindow["stats"])
		gLabel["name"] = guiCreateLabel(21,41,36,16,"Name:",false,gWindow["stats"])
		guiSetFont ( gLabel["name"], 3 )
		guiSetAlpha(gLabel["name"],1)
		guiLabelSetColor(gLabel["name"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["name"],"top")
		guiLabelSetHorizontalAlign(gLabel["name"],"left",false)
		gLabel["spielzeitWert"] = guiCreateLabel(80,66,200,16,"Heute: "..playtimeToday..", Insg.: "..playtime,false,gWindow["stats"])
		guiSetAlpha(gLabel["spielzeitWert"],1)
		guiLabelSetColor(gLabel["spielzeitWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["spielzeitWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["spielzeitWert"],"left",false)
		gLabel["spielzeit"] = guiCreateLabel(21,66,50,15,"Spielzeit:",false,gWindow["stats"])
		guiSetFont ( gLabel["spielzeit"], 3 )
		guiSetAlpha(gLabel["spielzeit"],1)
		guiLabelSetColor(gLabel["spielzeit"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["spielzeit"],"top")
		guiLabelSetHorizontalAlign(gLabel["spielzeit"],"left",false)
		gLabel["nameWert"] = guiCreateLabel(60,41,109,18,getPlayerName(getLocalPlayer()),false,gWindow["stats"])
		guiSetAlpha(gLabel["nameWert"],1)
		guiLabelSetColor(gLabel["nameWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["nameWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["nameWert"],"left",false)
		gLabel["warns"] = guiCreateLabel(21,92,38,15,"Warns:",false,gWindow["stats"])
		guiSetFont ( gLabel["warns"], 3 )
		guiSetAlpha(gLabel["warns"],1)
		guiLabelSetColor(gLabel["warns"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["warns"],"top")
		guiLabelSetHorizontalAlign(gLabel["warns"],"left",false)
		gLabel["warnsWert"] = guiCreateLabel(65,92,109,18,tostring(getElementData(lp,"warns")),false,gWindow["stats"])
		guiSetAlpha(gLabel["warnsWert"],1)
		guiLabelSetColor(gLabel["warnsWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["warnsWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["warnsWert"],"left",false)
		gLabel["adminlevel"] = guiCreateLabel(21,116,71,15,"Admin Level:",false,gWindow["stats"])
		guiSetFont ( gLabel["warns"], 3 )
		guiSetAlpha(gLabel["adminlevel"],1)
		guiLabelSetColor(gLabel["adminlevel"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["adminlevel"],"top")
		guiLabelSetHorizontalAlign(gLabel["adminlevel"],"left",false)
		gLabel["adminlevelWert"] = guiCreateLabel(98,116,109,18,tostring(getElementData(lp,"adminlvl")),false,gWindow["stats"])
		guiSetAlpha(gLabel["adminlevelWert"],1)
		guiLabelSetColor(gLabel["adminlevelWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["adminlevelWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["adminlevelWert"],"left",false)
		gLabel["fraktion"] = guiCreateLabel(21,144,49,16,"Fraktion:",false,gWindow["stats"])
		guiSetFont ( gLabel["fraktion"], 3 )
		guiSetAlpha(gLabel["fraktion"],1)
		guiLabelSetColor(gLabel["fraktion"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["fraktion"],"top")
		guiLabelSetHorizontalAlign(gLabel["fraktion"],"left",false)
		gLabel["fraktionWert"] = guiCreateLabel(74,144,109,18,tostring(fraktion),false,gWindow["stats"])
		guiSetAlpha(gLabel["fraktionWert"],1)
		guiLabelSetColor(gLabel["fraktionWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["fraktionWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["fraktionWert"],"left",false)
		gLabel["tode"] = guiCreateLabel(21,169,34,16,"Tode:",false,gWindow["stats"])
		guiSetFont ( gLabel["tode"], 3 )
		guiSetAlpha(gLabel["tode"],1)
		guiLabelSetColor(gLabel["tode"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["tode"],"top")
		guiLabelSetHorizontalAlign(gLabel["tode"],"left",false)
		gLabel["todeWert"] = guiCreateLabel(60,169,109,18,tostring(getElementData ( lp, "deaths" )),false,gWindow["stats"])
		guiSetAlpha(gLabel["todeWert"],1)
		guiLabelSetColor(gLabel["todeWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["todeWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["todeWert"],"left",false)
		gLabel["morde"] = guiCreateLabel(20,191,39,16,"Morde:",false,gWindow["stats"])
		guiSetFont ( gLabel["morde"], 3 )
		guiSetAlpha(gLabel["morde"],1)
		guiLabelSetColor(gLabel["morde"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["morde"],"top")
		guiLabelSetHorizontalAlign(gLabel["morde"],"left",false)
		gLabel["mordeWert"] = guiCreateLabel(65,191,109,18,tostring(getElementData(lp,"kills")),false,gWindow["stats"])
		guiSetAlpha(gLabel["mordeWert"],1)
		guiLabelSetColor(gLabel["mordeWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["mordeWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["mordeWert"],"left",false)
		gLabel["drogen"] = guiCreateLabel(20,213,43,16,"Drogen:",false,gWindow["stats"])
		guiSetFont ( gLabel["drogen"], 3 )
		guiSetAlpha(gLabel["drogen"],1)
		guiLabelSetColor(gLabel["drogen"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["drogen"],"top")
		guiLabelSetHorizontalAlign(gLabel["drogen"],"left",false)
		gLabel["drogenWert"] = guiCreateLabel(69,213,109,18,tostring(getElementData(lp,"drugs")),false,gWindow["stats"])
		guiSetAlpha(gLabel["drogenWert"],1)
		guiLabelSetColor(gLabel["drogenWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["drogenWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["drogenWert"],"left",false)
		gLabel["materialien"] = guiCreateLabel(20,236,60,16,"Materialien:",false,gWindow["stats"])
		guiSetFont ( gLabel["materialien"], 3 )
		guiSetAlpha(gLabel["materialien"],1)
		guiLabelSetColor(gLabel["materialien"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["materialien"],"top")
		guiLabelSetHorizontalAlign(gLabel["materialien"],"left",false)
		gLabel["materialienWert"] = guiCreateLabel(85,236,109,18,tostring(getElementData(lp,"mats")),false,gWindow["stats"])
		guiSetAlpha(gLabel["materialienWert"],1)
		guiLabelSetColor(gLabel["materialienWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["materialienWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["materialienWert"],"left",false)
		gLabel["paeckchen"] = guiCreateLabel(20,258,130,16,"Gefundene Paeckchen:",false,gWindow["stats"])
		guiSetFont ( gLabel["paeckchen"], 3 )
		guiSetAlpha(gLabel["paeckchen"],1)
		guiLabelSetColor(gLabel["paeckchen"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["paeckchen"],"top")
		guiLabelSetHorizontalAlign(gLabel["paeckchen"],"left",false)
		gLabel["paeckchenWert"] = guiCreateLabel(155,258,109,18,tostring(tostring(getElementData ( lp, "foundpackages" )).."/25"),false,gWindow["stats"])
		guiSetAlpha(gLabel["paeckchenWert"],1)
		guiLabelSetColor(gLabel["paeckchenWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["paeckchenWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["paeckchenWert"],"left",false)
		gLabel["bonuspunkte"] = guiCreateLabel(19,283,78,16,"Bonuspunkte:",false,gWindow["stats"])
		guiSetFont ( gLabel["bonuspunkte"], 3 )
		guiSetAlpha(gLabel["bonuspunkte"],1)
		guiLabelSetColor(gLabel["bonuspunkte"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["bonuspunkte"],"top")
		guiLabelSetHorizontalAlign(gLabel["bonuspunkte"],"left",false)
		gLabel["bonuspunkteWert"] = guiCreateLabel(102,283,109,18,tostring(getElementData ( lp, "bonuspoints")),false,gWindow["stats"])
		guiSetAlpha(gLabel["bonuspunkteWert"],1)
		guiLabelSetColor(gLabel["bonuspunkteWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["bonuspunkteWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["bonuspunkteWert"],"left",false)
		gLabel["job"] = guiCreateLabel(18,307,25,15,"Job:",false,gWindow["stats"])
		guiSetFont ( gLabel["job"], 3 )
		guiSetAlpha(gLabel["job"],1)
		guiLabelSetColor(gLabel["job"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["job"],"top")
		guiLabelSetHorizontalAlign(gLabel["job"],"left",false)
		gLabel["jobWert"] = guiCreateLabel(46,307,109,18,job,false,gWindow["stats"])
		guiSetAlpha(gLabel["jobWert"],1)
		guiLabelSetColor(gLabel["jobWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["jobWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["jobWert"],"left",false)
		gLabel["geld"] = guiCreateLabel(18,330,98,15,"Geld (Bar/Bank):",false,gWindow["stats"])
		guiSetFont ( gLabel["geld"], 3 )
		guiSetAlpha(gLabel["geld"],1)
		guiLabelSetColor(gLabel["geld"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["geld"],"top")
		guiLabelSetHorizontalAlign(gLabel["geld"],"left",false)
		gLabel["geldWert"] = guiCreateLabel(123,330,109,18,tostring(getElementData(lp,"money").."/"..tostring(getElementData(lp,"bankmoney"))).." $",false,gWindow["stats"])
		guiSetAlpha(gLabel["geldWert"],1)
		guiLabelSetColor(gLabel["geldWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["geldWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["geldWert"],"left",false)
		gLabel["personalausweis"] = guiCreateLabel(291,41,92,16,"Personalausweis:",false,gWindow["stats"])
		guiSetFont ( gLabel["personalausweis"], 3 )
		guiSetAlpha(gLabel["personalausweis"],1)
		guiLabelSetColor(gLabel["personalausweis"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["personalausweis"],"top")
		guiLabelSetHorizontalAlign(gLabel["personalausweis"],"left",false)
		gLabel["personalausweisWert"] = guiCreateLabel(395,41,81,16,p,false,gWindow["stats"])
		guiSetAlpha(gLabel["personalausweisWert"],1)
		guiLabelSetColor(gLabel["personalausweisWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["personalausweisWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["personalausweisWert"],"left",false)
		gLabel["fuehrerschein"] = guiCreateLabel(291,64,81,16,"Fuehrerschein:",false,gWindow["stats"])
		guiSetFont ( gLabel["fuehrerschein"], 3 )
		guiSetAlpha(gLabel["fuehrerschein"],1)
		guiLabelSetColor(gLabel["fuehrerschein"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["fuehrerschein"],"top")
		guiLabelSetHorizontalAlign(gLabel["fuehrerschein"],"left",false)
		gLabel["fuehrerscheinWert"] = guiCreateLabel(395,64,81,16,cl,false,gWindow["stats"])
		guiSetAlpha(gLabel["fuehrerscheinWert"],1)
		guiLabelSetColor(gLabel["fuehrerscheinWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["fuehrerscheinWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["fuehrerscheinWert"],"left",false)
		gLabel["angelschein"] = guiCreateLabel(291,87,72,16,"Angelschein:",false,gWindow["stats"])
		guiSetFont ( gLabel["angelschein"], 3 )
		guiSetAlpha(gLabel["angelschein"],1)
		guiLabelSetColor(gLabel["angelschein"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["angelschein"],"top")
		guiLabelSetHorizontalAlign(gLabel["angelschein"],"left",false)
		gLabel["angelscheinWert"] = guiCreateLabel(395,87,81,16,fl,false,gWindow["stats"])
		guiSetAlpha(gLabel["angelscheinWert"],1)
		guiLabelSetColor(gLabel["angelscheinWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["angelscheinWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["angelscheinWert"],"left",false)
		gLabel["motorradschein"] = guiCreateLabel(291,111,87,15,"Motorradschein:",false,gWindow["stats"])
		guiSetFont ( gLabel["motorradschein"], 3 )
		guiSetAlpha(gLabel["motorradschein"],1)
		guiLabelSetColor(gLabel["motorradschein"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["motorradschein"],"top")
		guiLabelSetHorizontalAlign(gLabel["motorradschein"],"left",false)
		gLabel["motorradscheinWert"] = guiCreateLabel(395,111,81,16,bl,false,gWindow["stats"])
		guiSetAlpha(gLabel["motorradscheinWert"],1)
		guiLabelSetColor(gLabel["motorradscheinWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["motorradscheinWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["motorradscheinWert"],"left",false)
		gLabel["lkwschein"] = guiCreateLabel(290,137,71,15,"LKW-Schein:",false,gWindow["stats"])
		guiSetFont ( gLabel["lkwschein"], 3 )
		guiSetAlpha(gLabel["lkwschein"],1)
		guiLabelSetColor(gLabel["lkwschein"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["lkwschein"],"top")
		guiLabelSetHorizontalAlign(gLabel["lkwschein"],"left",false)
		gLabel["lkwscheinWert"] = guiCreateLabel(395,137,81,16,ll,false,gWindow["stats"])
		guiSetAlpha(gLabel["lkwscheinWert"],1)
		guiLabelSetColor(gLabel["lkwscheinWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["lkwscheinWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["lkwscheinWert"],"left",false)
		gLabel["flugscheina"] = guiCreateLabel(290,162,98,15,"Flugschein Typ A:",false,gWindow["stats"])
		guiSetFont (gLabel["flugscheina"], 3 )
		guiSetAlpha(gLabel["flugscheina"],1)
		guiLabelSetColor(gLabel["flugscheina"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["flugscheina"],"top")
		guiLabelSetHorizontalAlign(gLabel["flugscheina"],"left",false)
		gLabel["flugscheinaWert"] = guiCreateLabel(395,162,81,16,pal,false,gWindow["stats"])
		guiSetAlpha(gLabel["flugscheinaWert"],1)
		guiLabelSetColor(gLabel["flugscheinaWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["flugscheinaWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["flugscheinaWert"],"left",false)
		gLabel["flugscheinb"] = guiCreateLabel(290,186,98,15,"Flugschein Typ B:",false,gWindow["stats"])
		guiSetFont (gLabel["flugscheinb"], 3 )
		guiSetAlpha(gLabel["flugscheinb"],1)
		guiLabelSetColor(gLabel["flugscheinb"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["flugscheinb"],"top")
		guiLabelSetHorizontalAlign(gLabel["flugscheinb"],"left",false)
		gLabel["flugscheinbWert"] = guiCreateLabel(395,186,81,16,pbl,false,gWindow["stats"])
		guiSetAlpha(gLabel["flugscheinbWert"],1)
		guiLabelSetColor(gLabel["flugscheinbWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["flugscheinbWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["flugscheinbWert"],"left",false)
		gLabel["flugscheinc"] = guiCreateLabel(290,208,98,15,"Helikopterschein:",false,gWindow["stats"])
		guiSetFont (gLabel["flugscheinc"], 3 )
		guiSetAlpha(gLabel["flugscheinc"],1)
		guiLabelSetColor(gLabel["flugscheinc"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["flugscheinc"],"top")
		guiLabelSetHorizontalAlign(gLabel["flugscheinc"],"left",false)
		gLabel["flugscheincWert"] = guiCreateLabel(395,208,81,16,hl,false,gWindow["stats"])
		guiSetAlpha(gLabel["flugscheincWert"],1)
		guiLabelSetColor(gLabel["flugscheincWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["flugscheincWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["flugscheincWert"],"left",false)
		gLabel["segelschein"] = guiCreateLabel(290,232,66,15,"Segelschein:",false,gWindow["stats"])
		guiSetFont (gLabel["segelschein"], 3 )
		guiSetAlpha(gLabel["segelschein"],1)
		guiLabelSetColor(gLabel["segelschein"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["segelschein"],"top")
		guiLabelSetHorizontalAlign(gLabel["segelschein"],"left",false)
		gLabel["segelscheinWert"] = guiCreateLabel(395,232,81,16,sl,false,gWindow["stats"])
		guiSetAlpha(gLabel["segelscheinWert"],1)
		guiLabelSetColor(gLabel["segelscheinWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["segelscheinWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["segelscheinWert"],"left",false)
		gLabel["motorbootschein"] = guiCreateLabel(290,255,96,15,"Motorbootschein:",false,gWindow["stats"])
		guiSetFont (gLabel["motorbootschein"], 3 )
		guiSetAlpha(gLabel["motorbootschein"],1)
		guiLabelSetColor(gLabel["motorbootschein"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["motorbootschein"],"top")
		guiLabelSetHorizontalAlign(gLabel["motorbootschein"],"left",false)
		gLabel["motorbootscheinWert"] = guiCreateLabel(395,255,81,16,mbl,false,gWindow["stats"])
		guiSetAlpha(gLabel["motorbootscheinWert"],1)
		guiLabelSetColor(gLabel["motorbootscheinWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["motorbootscheinWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["motorbootscheinWert"],"left",false)
		gLabel["waffenschein"] = guiCreateLabel(290,280,80,15,"Waffenschein:",false,gWindow["stats"])
		guiSetFont (gLabel["waffenschein"], 3 )
		guiSetAlpha(gLabel["waffenschein"],1)
		guiLabelSetColor(gLabel["waffenschein"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["waffenschein"],"top")
		guiLabelSetHorizontalAlign(gLabel["waffenschein"],"left",false)
		gLabel["waffenscheinWert"] = guiCreateLabel(395,280,81,16,gl,false,gWindow["stats"])
		guiSetAlpha(gLabel["waffenscheinWert"],1)
		guiLabelSetColor(gLabel["waffenscheinWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["waffenscheinWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["waffenscheinWert"],"left",false)
		
		gLabel["gwd"] = guiCreateLabel(290,307,95,15,"GWD-Note:",false,gWindow["stats"])
		guiSetFont ( gLabel["gwd"], 3 )
		guiSetAlpha(gLabel["gwd"],1)
		guiLabelSetColor(gLabel["gwd"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["gwd"],"top")
		guiLabelSetHorizontalAlign(gLabel["gwd"],"left",false)
		gLabel["gwdWert"] = guiCreateLabel(390,307,109,18,gwd,false,gWindow["stats"])
		guiSetAlpha(gLabel["gwdWert"],1)
		guiLabelSetColor(gLabel["gwdWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["gwdWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["gwdWert"],"left",false)
		
		
		foundViewPoints = getElementData ( lp, "viewpoints" )
		gLabel["geld"] = guiCreateLabel(290,330,98,15,"Aussichtspunkte:",false,gWindow["stats"])
		guiSetFont ( gLabel["geld"], 3 )
		guiSetAlpha(gLabel["geld"],1)
		guiLabelSetColor(gLabel["geld"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["geld"],"top")
		guiLabelSetHorizontalAlign(gLabel["geld"],"left",false)
		gLabel["geldWert"] = guiCreateLabel(390,330,109,18,foundViewPoints.." / 10",false,gWindow["stats"])
		guiSetAlpha(gLabel["geldWert"],1)
		guiLabelSetColor(gLabel["geldWert"],255,255,255)
		guiLabelSetVerticalAlign(gLabel["geldWert"],"top")
		guiLabelSetHorizontalAlign(gLabel["geldWert"],"left",false)
	end
end