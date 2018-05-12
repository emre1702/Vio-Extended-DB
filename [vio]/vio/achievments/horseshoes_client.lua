function hideHorseshoe_func ( horseShoe )

	setElementDimension ( horseShoe, 2 )
end
addEvent ( "hideHorseshoe", true )
addEventHandler ( "hideHorseshoe", getRootElement(), hideHorseshoe_func )