--GENERIC GAME OVER BG
function onGameOverStart()
    setProperty('boyfriend.y', 250)
    
    setObjectCamera('boyfriend', 'camHUD')
    setProperty('boyfriend.x', 430)
    setProperty('boyfriend.y', 250)

	setPropertyFromClass("flixel.FlxG","state.healthBarBG.visible", false)
	setPropertyFromClass("flixel.FlxG","state.healthBarHigh.visible", false)
	setPropertyFromClass("flixel.FlxG","state.healthBar.visible", false)
	setPropertyFromClass("flixel.FlxG","state.healthBarWN.visible", false)
	setPropertyFromClass("flixel.FlxG","state.healthStrips.visible", false)
	setPropertyFromClass("flixel.FlxG","state.iconP1.visible", false)
	setPropertyFromClass("flixel.FlxG","state.iconP2.visible", false)
	setPropertyFromClass("flixel.FlxG","state.judgementCounter.visible", false)
    setPropertyFromClass("flixel.FlxG","state.iconP1.visible", false)
    setPropertyFromClass("flixel.FlxG","state.iconP2.visible", false)
    setPropertyFromClass("flixel.FlxG","state.scoreTxt.visible", false)
	setPropertyFromClass("flixel.FlxG","state.timeBarBG.visible", false)
	setPropertyFromClass("flixel.FlxG","state.timeBar.visible", false)
	setPropertyFromClass("flixel.FlxG","state.timeTxt.visible", false)
	setPropertyFromClass("flixel.FlxG","state.strumLineNotes.visible", false)
    setPropertyFromClass("flixel.FlxG","camera.bgColor", getColorFromHex("0x00FFFFFF"))
    setPropertyFromClass("flixel.FlxG","state.persistentDraw", true)

    setLuaSpriteScrollFactor('boyfriend', 0, 0);
    --NOTE: BOYFRIEND IS SET TO "NOBODY" BY DEFAULT    
    
    --LMAO YOU CAN HAVE THE GAME PLAY ITSELF WITHOUT BOTPLAY AND ARROWS
    --setPropertyFromClass("flixel.FlxG","state.persistentUpdate", true)
        
    --rip this stops everything from working     
    --setPropertyFromClass("flixel.tweens.FlxTween","freezeStateName", "grafex.states.PlayState")

    local unZoom = 1/getPropertyFromClass("flixel.FlxG","camera.zoom")
    
	makeLuaSprite('new2', '', 0, 0);
    makeGraphic('new2',2,2,"000000")    
    --setObjectCamera('new2', 'other')
	scaleObject('new2', screenWidth*unZoom,screenHeight*unZoom)
    screenCenter('new2');
	setProperty("new2.alpha", 0.5)
    setLuaSpriteScrollFactor('new2', 0, 0);
    addLuaSprite('new2', true);
    
    makeLuaSprite('new', 'gameover/frameover', 0, 0);
    --setObjectCamera('new', 'other')
	scaleObject('new', unZoom,unZoom)
    screenCenter('new');
    addLuaSprite('new', true);
    setProperty("new.alpha", 1)
    setLuaSpriteScrollFactor('new', 0, 0);
    
    doTweenAlpha("camHUDTween", "camHUD", 0, 1.2, "cubeOut")
    
end

function onGameOverConfirm()
    doTweenAlpha("newTween", "new", 0, 1.2, "cubeOut")
    --doTweenAlpha("newTween", "new2", 1, 2.2, "cubeOut")
    
end

function deadUpdatePost()
    local unZoom = 1/getPropertyFromClass("flixel.FlxG","camera.zoom")
	scaleObject('new2', screenWidth*unZoom,screenHeight*unZoom)
    screenCenter('new2');
	
    scaleObject('new', unZoom,unZoom)
    screenCenter('new');
end
