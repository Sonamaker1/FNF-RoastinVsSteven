function onCreate()
	-- background shit

	makeLuaSprite('bacon', 'stages/pancakes/bacon_bg', 0, 0);
	setLuaSpriteScrollFactor('bacon', 0.9, 0.9);
    screenCenter('bacon');
	scaleObject('bacon', 1.0, 1.0);

	addLuaSprite('bacon', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
