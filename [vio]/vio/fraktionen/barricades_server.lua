﻿SandBagCount = 0
barricadeID = 0

function placeObject_func ( type, x, y, z, rz )

	local player = client
	
	if type == "sandbag" and isArmy ( player ) then
		createSandBagWall ( player, x, y, z, rz )
	elseif type == "barricade" and isStateFaction ( player ) then
		createBarricade ( player, x, y, z, rz )
	end
	vioSetElementData ( player, "object", 0 )
end
addEvent ( "placeObject", true )
addEventHandler ( "placeObject", getRootElement(), placeObject_func )

function createBarricade ( player, x, y, z, rot )

	vioSetElementData ( player, "objectToPlace", false )
	outputChatBox ( "Barrikade platziert!", player, 0, 125, 0 )
	showCursor ( player, false )
	_G["barricadeNo"..barricadeID] = createObject ( 1422, x, y, z+0.3, 0, 0, rot )
	setTimer ( destroyElement, 600000, 1, _G["barricadeNo"..barricadeID] )
	barricadeID = barricadeID + 1
end

function createSandBagWall ( player, x, y, z, rot )

	SandBagCount = SandBagCount + 1
	vioSetElementData ( player, "objectToPlace", false )
	showCursor ( player, false )
	_G["motherSandBag"..SandBagCount] = createObject ( 2060, 2496.7041015625, -1668.75390625, 12.492603302002, 0, 0, 0 )
	local bag = createObject ( 2060, 2495.7702636719, -1668.7458496094, 12.492603302002, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2494.8322753906, -1668.7738037109, 12.492603302002, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2494.1926269531, -1668.8299560547, 12.500406265259, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2494.2319335938, -1668.8308105469, 12.717599868774, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2495.2297363281, -1668.8103027344, 12.717599868774, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2496.1931152344, -1668.8334960938, 12.717599868774, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2496.6818847656, -1668.8083496094, 12.667600631714, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2496.5300292969, -1668.8012695313, 12.892597198486, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2495.5554199219, -1668.8256835938, 12.892597198486, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2494.5422363281, -1668.791015625, 12.892597198486, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2494.603515625, -1668.7868652344, 13.117593765259, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2495.4057617188, -1668.8317871094, 13.117593765259, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2496.3583984375, -1668.8572998047, 13.117593765259, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2496.3583984375, -1668.8564453125, 13.117593765259, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2496.28515625, -1668.8714599609, 13.317590713501, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2495.3916015625, -1668.8935546875, 13.317590713501, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2494.71484375, -1668.8049316406, 13.317590713501, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2494.8161621094, -1668.7650146484, 13.492588043213, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	local bag = createObject ( 2060, 2496.375, -1668.845703125, 13.492588043213, 0, 0, 0 )
	setElementParent ( bag, _G["motherSandBag"..SandBagCount] )
	attachElementsInCorrectWay ( bag, _G["motherSandBag"..SandBagCount] )
	setElementPosition ( _G["motherSandBag"..SandBagCount], x, y-1, z )
	setObjectRotation ( _G["motherSandBag"..SandBagCount], 0, 0, rot )
	setTimer ( destroyElement, 180000, 1, _G["motherSandBag"..SandBagCount] )
end