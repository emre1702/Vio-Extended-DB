--
-- c_car_paint.lua
--
addEvent ( "triggerVioShader3", true )
addEventHandler( "triggerVioShader3", getRootElement(),
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		-- Create shader
		local myShader, tec = dxCreateShader ( "shader/car_paint.fx" )

		if not myShader then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
			--outputChatBox( "Using technique " .. tec )

			-- Set textures
			local textureVol = dxCreateTexture ( "shader/images/smallnoise3d.dds" );
			local textureCube = dxCreateTexture ( "shader/images/cube_env256.dds" );
			dxSetShaderValue ( myShader, "microflakeNMapVol_Tex", textureVol );
			dxSetShaderValue ( myShader, "showroomMapCube_Tex", textureCube );

			-- Apply to world texture
			engineApplyShaderToWorldTexture ( myShader, "vehiclegrunge256" )
		end
	end
)
