function showAchievmentWindow ()

	if gWindow["achievmentList"] then
		destroyElement ( gWindow["achievmentList"] )
	end
	
	gWindow["achievmentList"] = guiCreateWindow(screenwidth/2-300/2,120,300,422,"Achievments",false)
	guiSetAlpha ( gWindow["achievmentList"], 1 )
	guiWindowSetMovable ( gWindow["achievmentList"], false )
	guiWindowSetSizable ( gWindow["achievmentList"], false )
	
	gImage[2] = guiCreateStaticImage(10,29,50,50,"images/pokal.bmp",false,gWindow["achievmentList"])
	gLabel[4] = guiCreateLabel(78,33,186,47,"Hier kannst du sehen,\nwelche Achievments du bereits\nerreicht hast.",false,gWindow["achievmentList"])
	guiLabelSetColor(gLabel[4],255,255,255)
	guiLabelSetVerticalAlign(gLabel[4],"top")
	guiLabelSetHorizontalAlign(gLabel[4],"left",false)
	guiSetFont(gLabel[4],"default-bold-small")
	
	currentAchievments = 0

	addAchievment ( "Schlaflos in SA", getElementData ( lp, "schlaflosinsa" ) == "done" )
	addAchievment ( "Waffenschieber", getElementData ( lp, "gunloads" ) == "done" )
	addAchievment ( "Angler", getElementData ( lp, "angler_achiev" ) == "done" )
	addAchievment ( "Mr. License", getElementData ( lp, "licenses_achiev" ) == "done" )
	addAchievment ( "Der Sammler", getElementData ( lp, "collectr_achiev" ) == "done" )
	addAchievment ( "The Truth is out there", getElementData ( lp, "thetruthisoutthere_achiev" ) == "done" )
	addAchievment ( "Silent Assassin", getElementData ( lp, "silentassasin_achiev" ) == "done" )
	addAchievment ( "Reallife WTF?", getElementData ( lp, "rl_achiev" ) == "done" )
	addAchievment ( "Eigene Fuesse", getElementData ( lp, "own_foots" ) == "done" )
	addAchievment ( "King of the Hill", getElementData ( lp, "kingofthehill_achiev" ) == "done" )
	addAchievment ( "Highway to Hell", getElementData ( lp, "highwaytohell_achiev" ) == "done" )
	addAchievment ( "Schmied", getElementData ( lp, "totalHorseShoes" ) == 25 )	
	addAchievment ( "Revolverheld", getElementData ( lp, "revolverheld_achiev" ) == 1 )
	addAchievment ( "Chicken Dinner", getElementData ( lp, "chickendinner_achiev" ) == 1 )
	addAchievment ( "Nichts geht mehr", getElementData ( lp, "nichtsgehtmehr_achiev" ) == 1 )
	addAchievment ( "Highscore", getElementData ( lp, "highscore_achiev" ) )
end

function addAchievment ( text, done )

	currentAchievments = currentAchievments + 1
	local x = 11
	if currentAchievments / 2 == math.floor ( currentAchievments / 2 ) then
		x = 151
	end
	
	local y = 90 + math.floor ( currentAchievments / 2 ) * 32
	
	gLabel["achievment"..currentAchievments] = guiCreateLabel(x,y,130,14,text,false,gWindow["achievmentList"])
	guiLabelSetVerticalAlign(gLabel["achievment"..currentAchievments],"top")
	guiLabelSetHorizontalAlign(gLabel["achievment"..currentAchievments],"left",false)
	guiSetFont(gLabel["achievment"..currentAchievments],"default-bold-small")
	
	if done then
		guiLabelSetColor(gLabel["achievment"..currentAchievments],0,200,0)
		gImage["achievment"..currentAchievments] = guiCreateStaticImage( x + 68, y + 7, 43, 21,"images/gui/done.png",false,gWindow["achievmentList"])
	else
		guiLabelSetColor(gLabel["achievment"..currentAchievments],200,200,0)
	end
end