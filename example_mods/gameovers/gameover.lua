function onGameOverStart()
    setObjectCamera('boyfriend', 'other')
    setProperty('boyfriend.x', 430)
    setProperty('boyfriend.y', 250)
    setLuaSpriteScrollFactor('boyfriend', 0, 0);
    
    makeLuaSprite('new', 'menus/freeplay/fpBG', 0, 0);
    setObjectCamera('new', 'other')
	screenCenter('new');
	addLuaSprite('new', false);
    setProperty("new.alpha", 0.2)
    setLuaSpriteScrollFactor('new', 0, 0);
    
end
