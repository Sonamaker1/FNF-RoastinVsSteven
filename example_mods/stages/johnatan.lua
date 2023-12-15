function onCreate()
    setProperty('dumb_bitch.scale.x',1.2);
    setProperty('dumb_bitch.scale.y',1.2);
    screenCenter('dumb_bitch');
	setProperty('dumb_bitch.y',getProperty('dumb_bitch.y') +500 )
    setProperty('dumb_bitch.x',getProperty('dumb_bitch.x') -160 )
    
    --setProperty('dad.x',getProperty('dad.x') + 160 )
    --setProperty('boyfriend.x',getProperty('boyfriend.x') + 160 )
    --setProperty('mordo.x',getProperty('mordo.x') + 160 )
    makeLuaSprite('bg', 'stages/johnatan/johnny_bg', 0, 0);
	setLuaSpriteScrollFactor('bg', 0.9, 0.9);
    scaleObject('bg', 1.5, 1.5);
    screenCenter('bg');
	setProperty('bg.y',getProperty('bg.y')+620);
    setProperty('bg.x',getProperty('bg.x')-220);
	addLuaSprite('bg', false);
    
end

local johnIsDead =false;
function noteMiss()
    if not johnIsDead then
        loadGraphic('dumb_bitch', "stages/johnatan/johnny");
        setProperty('dumb_bitch.scale.x',1.2);
        setProperty('dumb_bitch.scale.y',1.2);
        screenCenter('dumb_bitch');
	    setProperty('dumb_bitch.y',getProperty('dumb_bitch.y') +700 )
        setProperty('dumb_bitch.x',getProperty('dumb_bitch.x') -160 )
        johnIsDead = true;        
    end
end
