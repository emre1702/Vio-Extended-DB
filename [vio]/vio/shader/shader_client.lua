function showShaderGui ( )
	
	local x, y = guiGetScreenSize()
	local windowx = x/2 - 181
	local windowy = y/2 - 277/2

	gWindow["shaderSettings"] = guiCreateWindow( windowx, windowy, 362, 277, "Shader", false )
	gLabel["shaderInfo"] = guiCreateLabel( 9, 25, 345, 20, "Hier kannst du die verschiedenen Shader an- bzw. ausschalten!", false, gWindow["shaderSettings"] )
	
	gLabel["shaderWater"] = guiCreateLabel( 9, 50, 105, 20, "Wasser-Shader:", false, gWindow["shaderSettings"] )
	gLabel["shaderBloom"] = guiCreateLabel( 9, 75, 105, 20, "Bloom-Shader:", false, gWindow["shaderSettings"] )
	gLabel["shaderCarpaint"] = guiCreateLabel( 9, 100, 105, 20, "Carpaint-Shader:", false, gWindow["shaderSettings"] )
	gLabel["shaderRoadshine"] = guiCreateLabel( 9, 125, 105, 20, "Roadshine-Shader:", false, gWindow["shaderSettings"] )
	
	gLabel["shaderInfoRe"] = guiCreateLabel( 9, 150, 330, 20, "ACHTUNG: Aenderungen werden nach Reconnect wirksam!", false, gWindow["shaderSettings"] )
	
	gCheck["shaderWater"] = guiCreateCheckBox( 120, 50, 15, 20, "", false, false, gWindow["shaderSettings"] )
	gCheck["shaderBloom"] = guiCreateCheckBox( 120, 75, 15, 20, "", false, false, gWindow["shaderSettings"] )
	gCheck["shaderCarpaint"] = guiCreateCheckBox( 120, 100, 15, 20, "", false, false, gWindow["shaderSettings"] )
	gCheck["shaderRoadshine"] = guiCreateCheckBox( 120, 125, 15, 20, "", false, false, gWindow["shaderSettings"] )
	
	gButtons["shaderClose"] = guiCreateButton( 109.5, 232, 143, 40, "Schliessen", false, gWindow["shaderSettings"] )

	guiSetFont( gLabel["shaderInfo"], "default-bold-small" )
	guiSetFont( gLabel["shaderWater"], "default-bold-small" )
	guiSetFont( gLabel["shaderBloom"], "default-bold-small" )
	guiSetFont( gLabel["shaderCarpaint"], "default-bold-small" )
	guiSetFont( gLabel["shaderRoadshine"], "default-bold-small" )
	guiSetFont( gLabel["shaderInfoRe"], "default-bold-small" )
	
	guiSetAlpha( gWindow["shaderSettings"], 1 )
	guiSetAlpha( gLabel["shaderInfo"], 1 )
	guiSetAlpha( gLabel["shaderWater"], 1 )
	guiSetAlpha( gLabel["shaderBloom"], 1 )
	guiSetAlpha( gLabel["shaderCarpaint"], 1 )
	guiSetAlpha( gLabel["shaderRoadshine"], 1 )
	guiSetAlpha( gLabel["shaderInfoRe"], 1 )
	guiSetAlpha( gCheck["shaderWater"], 1 )
	guiSetAlpha( gCheck["shaderBloom"], 1 )
	guiSetAlpha( gCheck["shaderCarpaint"], 1 )
	guiSetAlpha( gCheck["shaderRoadshine"], 1 )
	guiSetAlpha( gButtons["shaderClose"], 1 )
	
	local vals = {}
	vals[1] = "Water"
	vals[2] = "Bloom"
	vals[3] = "Carpaint"
	vals[4] = "Roadshine"	
	
	for i = 1, 4 do
	
		local info = getElementData( getLocalPlayer(), "shader"..vals[i] )
		local te
		if tonumber(info) == 1 then te = true else te = false end
		
		guiCheckBoxSetSelected ( gCheck["shader"..vals[i]], te )
	
	end
	
	addEventHandler ( "onClientGUIClick", gButtons["shaderClose"],
		function ()
		
			--[[local s_client = {}
			
			s_client[1] = guiCheckBoxGetSelected ( gCheck["shaderWater"] )
			s_client[2] = guiCheckBoxGetSelected ( gCheck["shaderBloom"] )
			s_client[3] = guiCheckBoxGetSelected ( gCheck["shaderCarpaint"] )
			s_client[4] = guiCheckBoxGetSelected ( gCheck["shaderRoadshine"] )
			
			for i, bool in pairs ( s_client ) do
			
				local aboolean
				
				if bool == true then
					aboolean = 1
				elseif bool == false then
					aboolean = 0
				end
			
				setElementData ( getLocalPlayer(), "shader"..i, aboolean, true )
			
			end]]
			
			for i = 1, 4 do
			
				local info = guiCheckBoxGetSelected ( gCheck["shader"..vals[i]] )
				local te
				if info == true then te = 1 else te = 0 end
				
				setElementData ( getLocalPlayer(), "shader"..vals[i], te, true )
			
			end
			
			destroyElement ( gWindow["shaderSettings"] )
			showCursor ( false )
			setElementData ( getLocalPlayer(), "shaderedit", false )
						
		end )
		
end

function changeShader ( commandName )

	if isElement(gWindow["shaderSettings"]) then
		return
	end
	
	if getElementData ( getLocalPlayer(), "loggedin" ) == 0 then
		return
	end

	showCursor ( true )
	showShaderGui ( )
	
	setElementData ( getLocalPlayer(), "shaderedit", true )

end

addCommandHandler ( "shader", changeShader )

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()),
function()
	guiSetInputMode("no_binds_when_editing")
end)