function onCreate()
	-- background shit

	makeLuaSprite('cliff', 'cliff', -830, 280);
	setLuaSpriteScrollFactor('cliff', 0.9, 0.9);
	scaleObject('cliff', 1.0, 1.0);

	addLuaSprite('cliff', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end