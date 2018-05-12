-------------------------
------- (c) 2010 --------
------- by Zipper -------
-- and Vio MTA:RL Crew --
-------------------------

function achievsound_func ()

	local sound = playSound ("sounds/reached.mp3", false)
	setSoundVolume ( sound, .3 )
end
addEvent ( "achievsound", true )
addEventHandler ( "achievsound", getRootElement(), achievsound_func )

function mousesound_func ()
	local sound = playSound ("sounds/mouseclick.wav", false)
	setSoundVolume ( sound, 1 )
end

function phonesound_func ()

	local sound = playSound ("sounds/cellphone.ogg", false)
	setSoundVolume ( sound, .3 )
end
addEvent ( "phonesound", true )
addEventHandler ( "phonesound", getRootElement(), phonesound_func )

function sprunksound_func ()

	local sound = playSound ("sounds/sprunk.ogg", false)
	setSoundVolume ( sound, .3 )
end
addEvent ( "sprunksound", true )
addEventHandler ( "sprunksound", getRootElement(), sprunksound_func )

function highnoonsound_func ( rnd )

	local sound = playSound ("sounds/highnoon.ogg", false)
	setSoundVolume ( sound, 1 )
	setTimer ( bellsound_func, rnd*1000, 1, sound )
end
addEvent ( "highnoonsound", true )
addEventHandler ( "highnoonsound", getRootElement(), highnoonsound_func )

function bellsound_func ( sound )

	stopSound ( sound )
	local sound = playSound ("sounds/bell.ogg", false)
	setSoundVolume ( sound, 1 )
end
addEvent ( "bellsound", true )
addEventHandler ( "bellsound", getRootElement(), bellsound_func )

function katjuschasound_func ( rockets, timeBetween, x, y, z )

	local sound = playSound3D ("sounds/katjuscha.wav", x, y, z, false)
	setSoundVolume ( sound, 1 )
	setTimer ( katjuschaPlaySound, timeBetween, rockets, x, y, z )
end
addEvent ( "katjuschasound", true )
addEventHandler ( "katjuschasound", getRootElement(), katjuschasound_func )

function katjuschaPlaySound ( x, y, z)

	local sound = playSound3D ("sounds/katjuscha.wav", x, y, z, false)
	setSoundVolume ( sound, 1 )
end

txd = engineLoadTXD ( "images/raindanc.txd" )
engineImportTXD ( txd, 563 )