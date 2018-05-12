-- Language Allround --

lang = {}

function lang.val ( value, player )

	local nativeLanguage
	if lp then
		nativeLanguage = getElementData ( lp, "language" )
	else
		nativeLanguage = vioGetElementData ( player, "language" )
	end
	if not nativeLanguage then
		nativeLanguage = "german"
	end
	local txt = _G["lang."..nativeLanguage..".val"][value]
	if not txt then
		txt = lang.german.val
	end
	return txt
end