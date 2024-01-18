function onCreate()
	-- background shit

	makeLuaSprite('bg', 'stages/walmart/bg', 0, 0);
	setLuaSpriteScrollFactor('bg', 0.7, 0.85);
    scaleObject('bg', 1.2, 1.2);
	screenCenter('bg');
	
	makeLuaSprite('floor', 'stages/walmart/floor', 0, 0);
	setLuaSpriteScrollFactor('floor', 0.9, 0.9);
    scaleObject('floor', 1.2, 1.2);
	screenCenter('floor');
	
	makeLuaSprite('lights', 'stages/walmart/lights', 0, 0);
	setLuaSpriteScrollFactor('lights', 0.9, 0.9);
    scaleObject('lights', 1.2, 1.2);
	screenCenter('lights');
	
	addLuaSprite('bg', false);
	addLuaSprite('floor', false);
	addLuaSprite('lights', true);
	setProperty('dadGroup.x', -300);
	setProperty('gfGroup.x', 150);
	setProperty('boyfriendGroup.x', 800);
	setProperty('cn_cops.x', 50);
	setProperty('cn_cops.y', 200);
	setScrollFactor('cn_cops', 1, 1);

	setObjectOrder('floor' , 0)
	setObjectOrder('bg' , 0)
	--setSpriteOrder('bg' , getObjectOrder('cn_cops'))
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end
