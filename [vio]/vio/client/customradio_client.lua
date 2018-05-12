--[[
string.find ( "", "|" )

http://metafiles.gl-systemhaus.de/hr/youfm_rock.m3u
http://metafiles.gl-systemhaus.de/hr/youfm_2.m3u
http://listen.technobase.fm/dsl.pls

index.val:
	[Name]
[Name].val
	URL

    0: Radio Off
    1: Playback FM
    2: K-Rose
    3: K-DST
    4: Bounce FM
    5: SF-UR
    6: Radio Los Santos
    7: Radio X
    8: CSR 103.9
    9: K-Jah West
    10: Master Sounds 98.3
    11: WCTR
    12: User Track Player
]]
radioChannelsName = {}
	radioChannelsName[0] = "Radio aus"
	radioChannelsName[1] = "Playback FM"
	radioChannelsName[2] = "K-Rose"
	radioChannelsName[3] = "K-DST"
	radioChannelsName[4] = "Bounce FM"
	radioChannelsName[5] = "SF-UR"
	radioChannelsName[6] = "Radio Los Santos"
	radioChannelsName[7] = "Radio X"
	radioChannelsName[8] = "CSR 103.9"
	radioChannelsName[9] = "K-Jah West"
	radioChannelsName[10] = "Master Sounds 98.3"
	radioChannelsName[11] = "WCTR"
	radioChannelsName[12] = "User Track Player"

radioChannelNameRenderTimer = false

function saveNewCustomRadioChannel ( name, url )

	if string.find ( name, "|" ) == nil and name ~= "index" then
		setClientData ( "custom_radio/index", getClientData ( "custom_radio/index" ).."|"..name )
		setClientData ( "custom_radio/"..name, url )
		
		return true
	else
		return false
	end
end

function getCustomRadioChannels ()

	local channels = {}
	local result = true
	local i = 1
	while result do
		result = gettok ( getClientData ( "custom_radio/index" ), i, string.byte ( '|' ) )
		if result then
			channels[result] = getClientData ( "custom_radio/"..result )
		end
		i = i + 1
	end
	return channels
end

function getCustomRadioChannelURL ( name )

	return getClientData ( "custom_radio/"..name )
end

function deleteCustomRadioChannel ( name )

	local channels = {}
	local result = true
	local i = 1
	while result do
		result = gettok ( getClientData ( "custom_radio/index" ), i, string.byte ( '|' ) )
		if result then
			if not ( result == name ) then
				channels[result] = getClientData ( "custom_radio/"..result )
			end
		end
		i = i + 1
	end
	
	local new = ""
	for key, index in pairs ( channels ) do
		new = new.."|"..key
	end
	setClientData ( "custom_radio/index", new )
	
	customRadioChannels[name] = false
	
	return channels
end

function checkIfCustomRadioChannelExists ( name )

	local result = true
	local i = 1
	while result do
		result = gettok ( getClientData ( "custom_radio/index" ), i, string.byte ( '|' ) )
		if result then
			if result == name then
				return true
			end
		end
		i = i + 1
	end
	return false
end

if not doesClientDataExists ( "custom_radio/index" ) then
	setClientData ( "custom_radio/index", "" )
	
	local a1, b2 = saveNewCustomRadioChannel ( "You FM Rock", "http://metafiles.gl-systemhaus.de/hr/youfm_rock.m3u" )
	local a2, b2 = saveNewCustomRadioChannel ( "You FM", "http://metafiles.gl-systemhaus.de/hr/youfm_2.m3u" )
	local a3, b3 = saveNewCustomRadioChannel ( "Technobase", "http://listen.technobase.fm/dsl.pls" )
end

function drawRadioChannelName ( name, withSound )

	radioChannelNameToRender = name
	
	if isTimer ( radioChannelNameRenderTimer ) then
		killTimer ( radioChannelNameRenderTimer )
		removeEventHandler ( "onClientRender", getRootElement(), renderRadioChannelName )
	end
	addEventHandler ( "onClientRender", getRootElement(), renderRadioChannelName )
	radioChannelNameRenderTimer = setTimer (
		function ()
			radioChannelNameToRender = ""
			removeEventHandler ( "onClientRender", getRootElement(), renderRadioChannelName )
			playSoundFrontEnd ( 35 )
			radioChannelNameRenderTimer = false
		end,
	3000, 1 )
	if withSound then
		playSoundFrontEnd ( 34 )
	end
end

function renderRadioChannelName ()

	dxDrawText ( radioChannelNameToRender, 2, 2.0 + 5, screenwidth, screenheight, tocolor ( 0, 0, 0, 255 ), 2.5, "default", "center", "top", false, false, false )
	dxDrawText ( radioChannelNameToRender, 0, 0.0 + 5, screenwidth, screenheight, tocolor ( 184, 134, 11, 255 ), 2.5, "default", "center", "top", false, false, false )
end

customRadioChannels = getCustomRadioChannels ()
curRadioChannel = 0
customRadioChannel = false

function customRadioChannelSwitchUp ()
	local customRadioChannelsInList = {}
	local i = 0
	for key, index in pairs ( customRadioChannels ) do
		i = i + 1
		customRadioChannelsInList[i] = key
	end
	
	curRadioChannel = curRadioChannel + 1
	if curRadioChannel > 12 + i then
		curRadioChannel = 0
	end
	
	if curRadioChannel > 12 then
		drawRadioChannelName ( customRadioChannelsInList[curRadioChannel-12], true )
	else
		drawRadioChannelName ( radioChannelsName[curRadioChannel], true )
	end
	
	allowedToChangeRadioChannel = true
	setRadioChannel ( 0 )
	allowedToChangeRadioChannel = false
	
	if isTimer ( radioChannelNameTimer ) then
		killTimer ( radioChannelNameTimer )
	end
	radioChannelNameTimer = setTimer ( makeCurrentRadioChannelHearable, 3000, 1 )
	stopSound ( customRadioChannel )
end
function customRadioChannelSwitchDown ()
	local customRadioChannelsInList = {}
	local i = 0
	for key, index in pairs ( customRadioChannels ) do
		i = i + 1
		customRadioChannelsInList[i] = key
	end
	
	curRadioChannel = curRadioChannel - 1
	if curRadioChannel < 0 then
		curRadioChannel = 12 + i
	end
	
	if curRadioChannel > 12 then
		drawRadioChannelName ( customRadioChannelsInList[curRadioChannel-12], true )
	else
		drawRadioChannelName ( radioChannelsName[curRadioChannel], true )
	end
	
	allowedToChangeRadioChannel = true
	setRadioChannel ( 0 )
	allowedToChangeRadioChannel = false
	
	if isTimer ( radioChannelNameTimer ) then
		killTimer ( radioChannelNameTimer )
	end
	radioChannelNameTimer = setTimer ( makeCurrentRadioChannelHearable, 3000, 1 )
	stopSound ( customRadioChannel )
end
bindKey ( "radio_next", "down", customRadioChannelSwitchUp )
bindKey ( "radio_previous", "down", customRadioChannelSwitchDown )
showPlayerHudComponent ( "radio", false )

allowedToChangeRadioChannel = false
addEventHandler ( "onClientPlayerRadioSwitch", getRootElement(),
	function ( station )
		if not allowedToChangeRadioChannel then
			cancelEvent ()
		end
	end
)

function makeCurrentRadioChannelHearable ()

	allowedToChangeRadioChannel = true
	if curRadioChannel > 12 then
		local customRadioURLsInList = {}
		local i = 0
		for key, index in pairs ( customRadioChannels ) do
			i = i + 1
			customRadioURLsInList[i] = index
		end
		customRadioChannel = playSound ( customRadioURLsInList[curRadioChannel-12], true )
		playSoundFrontEnd ( 35 )
	else
		setRadioChannel ( curRadioChannel )
	end
	allowedToChangeRadioChannel = false
end

function stopRadio ()

	radioChannelNameToRender = ""
	playSoundFrontEnd ( 35 )
	stopSound ( customRadioChannel )
	allowedToChangeRadioChannel = true
	setRadioChannel ( 0 )
	allowedToChangeRadioChannel = false
	if isTimer ( radioChannelNameTimer ) then
		killTimer ( radioChannelNameTimer )
	end
	if isTimer ( radioChannelNameRenderTimer ) then
		killTimer ( radioChannelNameRenderTimer )
		removeEventHandler ( "onClientRender", getRootElement(), renderRadioChannelName )
	end
end
addEventHandler ( "onClientPedWasted", lp, stopRadio )
addEventHandler ( "onClientPlayerVehicleExit", lp, stopRadio )

addEventHandler ( "onClientPlayerVehicleEnter", lp, makeCurrentRadioChannelHearable )

-- Placeable --
function recieveSoundSource ( x, y, z, url )

	local sound = playSound3D ( url, x, y, z, true )
	setTimer ( checkIfSoundSourceStillExists, 1000, 1, source, sound )
end
addEvent ( "recieveSoundSource", true )
addEventHandler ( "recieveSoundSource", getRootElement(), recieveSoundSource )

function checkIfSoundSourceStillExists ( object, sound )

	if isElement ( object ) then
		setTimer ( checkIfSoundSourceStillExists, 1000, 1, object, sound )
	else
		stopSound ( sound )
	end
end