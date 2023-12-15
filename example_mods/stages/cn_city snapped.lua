function onCreate()
	-- background shit
	
	makeLuaSprite('Cn_city_sky', 'Cn_city_sky', -700, 30);
	setLuaSpriteScrollFactor('Cn_city_sky', 0.9, 0.9);
	
	makeLuaSprite('cn_city_bg', 'cn_city_bg', -1100, 30);
	setLuaSpriteScrollFactor('cn_city_bg', 0.9, 0.9);
	scaleObject('cn_city_bg', 1.2, 1.2);

	addLuaSprite('Cn_city_sky', false);
	addLuaSprite('cn_city_bg', false);

	makeAnimatedLuaSprite('foreground','FG', -600, 1030);
	addAnimationByPrefix('foreground','foreground','foreground',12,true)
	addLuaSprite('foreground', true)
	objectPlayAnimation('foreground','FG', true)
	scaleObject('foreground', 1.2, 1.2)

	makeAnimatedLuaSprite('real foreground','BG', -650, 450);
	addAnimationByPrefix('real foreground','real foreground','real foreground',24,true)
	addLuaSprite('real foreground', false)
	objectPlayAnimation('real foreground','BG', true)
	scaleObject('real foreground', 1.3, 1.3)
	
	makeLuaSprite('annoying', 'annoying', 940, 0);
	addLuaSprite('annoying',true)
	setLuaSpriteScrollFactor('annoying', 0.0, 0.0);
	scaleObject('annoying', 0.3, 0.3)

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end