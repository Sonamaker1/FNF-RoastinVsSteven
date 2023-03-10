package grafex.states;

import grafex.states.options.OptionsDirect;
import grafex.systems.Paths;
import grafex.systems.statesystem.MusicBeatState;
#if desktop
import utils.Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import grafex.data.WeekData;
import flixel.system.FlxAssets.FlxShader;
import lime.app.Application;
import grafex.states.editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;
import flixel.addons.display.FlxBackdrop;
import grafex.data.EngineData;
import grafex.systems.Conductor;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var curSelected:Int = 0;

	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var menuItems:FlxTypedGroup<FlxText>;
	var menuArtBG:FlxSprite;
	var menuArts:FlxTypedGroup<FlxSprite>;

    public static var firstStart:Bool = true;

	var logo:FlxSprite;

	var optionShit:Array<String> = [
		'MAIN SERIES',
		'BONUS EPISODES',
		'CREDITS',
		//#if !switch 'donate', #end // you can uncomment this if you want - Xale
		'OPTIONS'
	];

	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var arrowLeftKeys:Array<FlxKey>;
	var arrowRightKeys:Array<FlxKey>;

    public static var finishedFunnyMove:Bool = false;
        
    override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menu", null);
		#end
        WeekData.loadTheFirstEnabledMod();
        FlxG.watch.addQuick("beatShit", curBeat);
		FlxG.watch.addQuick("stepShit", curStep);

        if(FlxG.sound.music != null)
			if (!FlxG.sound.music.playing)
			{	
				FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.7);
				Conductor.changeBPM(120);
			}

        FlxG.mouse.visible = false;
        //FlxG.mouse.useSystemCursor = true;

		Application.current.window.title = Main.appTitle + ' - Main Menu';
		
		camGame = new FlxCamera();

		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));	
		arrowRightKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('ui_right'));
		arrowLeftKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('ui_left'));
		
		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];
		//FlxG.cameras.setDefaultDrawTarget(camGame, true);
		
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		var bg:FlxSprite = new FlxSprite(0,0).makeGraphic(Std.int(FlxG.width * 2), Std.int(FlxG.height * 2), FlxColor.WHITE);
		bg.scrollFactor.set(0,0);
		bg.screenCenter();
		add(bg);

		var grad:FlxSprite = new FlxSprite(10,0).loadGraphic(Paths.image('menus/main/gradient'));
		grad.scrollFactor.set(0,0);
		grad.setGraphicSize(Std.int(0.72 * grad.width));
		grad.screenCenter();
		add(grad);

		logo = new FlxSprite(-1075, -612);
		logo.frames = Paths.getSparrowAtlas('menus/roastin_logo');
		logo.animation.addByPrefix('bump', 'logo bumpin', 24, false);
		logo.setGraphicSize(Std.int(0.28 * logo.width));
		logo.antialiasing = ClientPrefs.globalAntialiasing;
		add(logo);

		menuArtBG = new FlxSprite(-627, 234).makeGraphic(365, 412, FlxColor.BLACK);
        menuArtBG.scrollFactor.set(0,0);
		add(menuArtBG);
		FlxTween.tween(menuArtBG, {x: 73}, 1, {ease: FlxEase.quadOut});

		menuItems = new FlxTypedGroup<FlxText>();
		add(menuItems);
		menuArts = new FlxTypedGroup<FlxSprite>();
		add(menuArts);

		var scale:Float = 1;

		for (i in 0...optionShit.length)
			{
				var menuArt:FlxSprite = new FlxSprite(-900,-75).loadGraphic(Paths.image('menus/main/arts/' + optionShit[i]));
				menuArt.scrollFactor.set(0,0);
				menuArt.antialiasing = true;
				menuArt.setGraphicSize(Std.int(0.38 * menuArt.width));
				menuArt.ID = i;
		        menuArts.add(menuArt);
				FlxTween.tween(menuArt, {x: -200}, 1, {ease: FlxEase.quadOut});
				
				var offset:Float = 88 - (Math.max(optionShit.length, 4) - 4) * 80;
				var menuItem:FlxText = new FlxText(FlxG.width * 3, (i * 90)  + offset + 20, optionShit[i], 45);
				menuItem.setFormat(Paths.font("vcr.ttf"), 45, 0xFF5B5B5C, RIGHT);
				menuItem.ID = i;
				menuItems.add(menuItem);
				var scr:Float = (optionShit.length - 4) * 0.135;
				if(optionShit.length < 6) scr = 0;
				menuItem.scrollFactor.set(0, yScroll);
				menuItem.antialiasing = ClientPrefs.globalAntialiasing;
				finishedFunnyMove = true;
				menuItem.x= 800;

				changeItem();
			}
            firstStart = false;

		FlxG.camera.follow(camFollowPos, null, 1);
		
		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Grafex Engine v" + EngineData.grafexEngineVersion #if debug + " Debug" #end, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v0.2.8", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;
	var clickCount:Int = 0;
	var colorEntry:FlxColor;
	
	override function update(elapsed:Float)
	{		
		if (FlxG.sound.music != null)
            Conductor.songPosition = FlxG.sound.music.time;

		//Conductor.songPosition = FlxG.sound.music.time; // this is such a bullshit, we messed with this around 2 hours - Xale

		var lerpVal:Float = Utils.boundTo(elapsed * 9, 0, 1);

        if(FlxG.keys.justPressed.F11)
    		FlxG.fullscreen = !FlxG.fullscreen;
		if(selectedSomethin)
			new FlxTimer().start(0.1, function(tmr:FlxTimer)
				{
					FlxG.mouse.visible = false;
				});

		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if(FlxG.mouse.wheel != 0)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
					changeItem(-FlxG.mouse.wheel);
				}
			
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}
			else if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

            if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
                FlxG.mouse.visible = false;
                TitleState.fromMainMenu = true;
			}

			if (controls.ACCEPT || FlxG.mouse.justPressed)
			{
				select();
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		FlxG.watch.addQuick("beatShit", curBeat);

		super.update(elapsed);
	}

	override function stepHit()
		{
			super.stepHit();
		}

	override function beatHit()
		{
			super.beatHit();
			logo.animation.play('bump', false);
		} // no Epilepsy - PurSnake

    function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}

		menuItems.forEach(function(spr:FlxText)
			{
				if (spr.ID == curSelected && finishedFunnyMove)
				{
					spr.alpha = 1;
					FlxTween.tween(spr, {x: 735}, 0.15, {
					    ease: FlxEase.linear});
				}

				if (spr.ID != curSelected)
				{
					spr.alpha = 0.6;
					FlxTween.tween(spr, {x: 800}, 0.15, {
				    	ease: FlxEase.linear});
				} 
			}); 

		menuArts.forEach(function(spr:FlxSprite)
		{
            spr.visible = false;

			if(spr.ID == curSelected)
			{
				spr.visible = true;
			}
		});
	}


        function select()
		{
                if (optionShit[curSelected] == 'donate')
				{
					Utils.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));
                    FlxTween.tween(logo, {y : -1100}, 0.5, {
						ease: FlxEase.quadOut,
					});

					FlxTween.tween(menuArtBG, {y : 1059}, 0.5, {
						ease: FlxEase.quadOut,
					});

                    menuArts.forEach(function(spr:FlxSprite)
					{
						FlxTween.tween(spr, {y : 750}, 0.5, {
						    ease: FlxEase.quadOut,
					    });
					});

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected == spr.ID)
							{
								FlxTween.tween(spr, {x : -575}, 0.75, {
									ease: FlxEase.quadInOut,
								});					
							}
                        if (curSelected != spr.ID)
							{
								FlxTween.tween(spr, {alpha: 0}, 0.4, {
									ease: FlxEase.quadOut,
									
								});
								FlxTween.tween(spr, {x : 850}, 0.55, {
									ease: FlxEase.quadOut,
									onComplete: function(twn:FlxTween)
									{
										spr.kill();
									}
								});					
							}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'MAIN SERIES':
										MusicBeatState.switchState(new StoryMenuState());
									case 'BONUS EPISODES':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'CREDITS':
										MusicBeatState.switchState(new CreditsState());

										FlxG.sound.music.stop();
                                        FlxG.sound.music == null;
									case 'OPTIONS':
										//MusicBeatState.switchState(new options.OptionsState());
										MusicBeatState.switchState(new OptionsDirect());

                                        FreeplayState.destroyFreeplayVocals();
                                        FlxG.sound.music.stop();
                                        FlxG.sound.music == null;                      
								}
							});
						}
					});
				}
        }	

}