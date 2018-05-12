_showCursor = showCursor

function showCursor ( player, bool )

	setElementData ( player, "cursorShowing", bool )
	return _showCursor ( player, bool )
end