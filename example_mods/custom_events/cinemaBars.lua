-- Event notes hooks
alreadyActive = false
function onEvent(name,value1,value2)
	if name == 'cinemaBars' then
		if value2 == null then
			value2 = 1
		end
		if value1 == 'True' then
			if alreadyActive == false then
				makeLuaSprite('bartop','',0,-100) --NormalPos 30
    				makeGraphic('bartop',1280,100,'000000')
    				addLuaSprite('bartop',false)
    				setObjectCamera('bartop','other')
    				setScrollFactor('bartop',0,0)

    				makeLuaSprite('barbot','',0,750) --NormalPos 650
    				makeGraphic('barbot',1280,100,'000000')
    				addLuaSprite('barbot',false)
    				setScrollFactor('barbot',0,0)
    				setObjectCamera('barbot','other')
				alreadyActive = true;

				doTweenY('MoveBT','bartop',-30,value2)
				doTweenY('MoveBB','barbot',650,value2)
			elseif alreadyActive == true then
				debugPrint('alreadyThere')	
				doTweenY('MoveBT','bartop',-30,value2)
				doTweenY('MoveBB','barbot',650,value2)
			end
		end
		if value1 == 'False' then
			if alreadyActive == false then
				debugPrint('You should probably use the cinemaBars event !True! first before you call !False!')
			end
			if alreadyActive == true then
				doTweenY('MoveBT','bartop',-100,value2)
				doTweenY('MoveBB','barbot',750,value2)	
			end
		end
	end
end


