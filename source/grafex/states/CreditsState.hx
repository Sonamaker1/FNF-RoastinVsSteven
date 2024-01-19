package grafex.states;

import grafex.sprites.attached.AttachedSprite;
import grafex.sprites.Alphabet;
import grafex.systems.Paths;
import grafex.systems.statesystem.MusicBeatState;
import grafex.Utils;
#if desktop
import utils.Discord.DiscordClient;
#end
import flash.text.TextField;
import lime.app.Application;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import grafex.effects.shaders.CreditsBG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import sys.FileSystem;
import sys.io.File;
import lime.utils.Assets;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<CenteredText>;
	private var iconArray:FlxTypedGroup<FlxSprite>;
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var theShaderBG:CreditsBG;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		persistentUpdate = true;

		Application.current.window.title = Main.appTitle + ' - Credits';

		FlxG.sound.playMusic(Paths.music('theDEVS'));

        theShaderBG = new CreditsBG();

		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.shader = theShaderBG;
		add(bg);

		var textBG2:FlxSprite = new FlxSprite(64, 0).makeGraphic(502, FlxG.height, FlxColor.WHITE);
		textBG2.scrollFactor.set(0,0);
		add(textBG2);
		var textBG:FlxSprite = new FlxSprite(75, 0).makeGraphic(480, FlxG.height, FlxColor.BLACK);
		textBG.scrollFactor.set(0,0);
		add(textBG);

		grpOptions = new FlxTypedGroup<CenteredText>();
		add(grpOptions);
        #if MODS_ALLOWED
		var path:String = 'modsList.txt';
		if(FileSystem.exists(path))
		{
			var leMods:Array<String> = Utils.coolTextFile(path);
			for (i in 0...leMods.length)
			{
				if(leMods.length > 1 && leMods[0].length > 0) {
					var modSplit:Array<String> = leMods[i].split('|');
					if(!Paths.ignoreModFolders.contains(modSplit[0].toLowerCase()) && !modsAdded.contains(modSplit[0]))
					{
						if(modSplit[1] == '1')
							pushModCreditsToList(modSplit[0]);
						else
							modsAdded.push(modSplit[0]);
					}
				}
			}
		}
		var arrayOfFolders:Array<String> = Paths.getModDirectories();
		arrayOfFolders.push('');
		for (folder in arrayOfFolders)
		{
			pushModCreditsToList(folder);
		}
		#end
	

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['FrimpleSchnips',		'frimple',		    'Head Honcho, Creator of the Mod, Main Sprite Artist and Animator, Smart fella',				'https://twitter.com/FrimpleSchnips',	        '444444'],
			['n3ps3n',			    'n3p',			    'Director, Main Coder',						'https://twitter.com/bendeeeey2',		        'B42F71'],
			['CBag',				'cbag',			    'Director, Musician, Charter, Coder',		'https://twitter.com/CBag28_',			        '5E99DF'],
			['Raymondvito',			'raymondvito',		'Musician',		                           	'https://www.youtube.com/@RaymondVito',			'9E29CF'],
			['JulianMOCs',			'julian',			'Musician',		                            'https://twitter.com/JulianMOCs1',			    '9E29CF'],
			['Propsnax',			'propsnax',			'Musician',	                                'https://twitter.com/Propsnax',			        'E1843A'],
			['Pinezapples',		    'pinezapples',		'Musician',							        'https://twitter.com/Pinezapples',	            'DCD294'],
			['Saffron',				'saffron',			'Musician',			                        'https://www.youtube.com/@saikedemon',			'64A250'],
			['Inoprishelenets',	    'ino',			    'Menu Theme Composer',						'https://www.youtube.com/@Inoprishelenets',		'7D40B2'],
			['Frostic',				'frostic',			'BG Artist and Charter',					'https://twitter.com/FrimpleSchnips',		    '483D92'],
			['Stick-Pi',		    'stickpi',	        'UI Artist',							    'https://twitter.com/KlysTjklys',	            'CF2D2D'],
			['NandoMations',		'nando',		    'Animator and Artist',						'https://twitter.com/real_mashions',		    '378FC7'],
			['MohnBlumen',		    'mohnblumen',	    'Artist',								    'https://www.youtube.com/@tomsk4064',	        'FADC45'],
			['ThirdTimeLucky',	    'lucky',			'Animator and Artist',						'https://twitter.com/Iam3rdTimeLucky',			'5ABD4B'],
			['BellowBomb',			'bellow',		    'Artist',								    'https://twitter.com/_Slimeling_',		        '378FC7'],
			['KnackMaster77',	    'knack',			'Artist',							        'https://twitter.com/KnackMaster_77',		    '7D40B2'],
			['Ruby_',				'ruby',			    'Artist',									'https://twitter.com/ruby151106',		        '483D92'],
			['Suki',		        'suki',	            'Logo Artist',							    'https://twitter.com/SukiTheTako',	            'CF2D2D'],
			['Someone',			    'someone',		    'Concept Artist',							'https://twitter.com/FrimpleSchnips',		    '378FC7'],
			['haylow',		        'haylow',	        'Charter',								    'https://twitter.com/hayliuem',	                'FADC45'],
			['Toad',	            'toad',			    'Charter, Coder',							'https://twitter.com/Toadstols',			    '5ABD4B'],
			['BoyZa_',			    'boyza',		    'Charter',								    'https://twitter.com/boyza___',		            '378FC7'],
			['PurSnake',			'pursnake',		    'Coder',								    'https://twitter.com/PurSniki',		            '8C41B6'],
			['LeSlay',				'leslay',			'Chromatic Scale Maker',					'https://twitter.com/LeSlayWasTaken',		    '483D92'],
			['DexterTheStick',		'dexterthestick',	'Chromatic Scale Maker',					'https://twitter.com/DexterTheStick',	        'CF2D2D'],
			['SonicStrong',			'sonicstrong',		'Chromatic Scale Maker',					'https://twitter.com/sonicstrong',		        '378FC7'],
			['FriedFrick',		    'fried frick',	    'Chromatic Scale Maker',					'https://twitter.com/FriedFrick',	            'FADC45'],
			['Friend',	            'friend',			'3D Artist',								'https://twitter.com/FriendFred3',			    '5ABD4B'],
			['KhrisKhros',			'khris khross',		'Concept Musician',							'https://twitter.com/khris_khros',		        '378FC7'],
			['Doctor Ross',			'doctor ross',		'Directing Help',							'https://mobile.twitter.com/texansshark',		'378FC7'],
			['Squibble',			'squibble',		'Script help',								    'https://www.youtube.com/channel/UCFauerFFkn1WlPCY3Y3iTIQ',		'378FC7'],
			['Nick',				'nick',		'Script help',								        'youtube.com',		'378FC7'],
			['Winn',				'winn',		'Source and Lua Programming + Final Build',		'https://www.youtube.com/@whatify9636',		'378FC7'],
			['You!!!',			    'you',		        'Yes, you! Thank you so much for playing this mod. We worked really hard on it and we hope you liked it!',			'https://www.youtube.com/watch?v=T_aiaYkcSDo',	'378FC7']
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}

		var iconBG:FlxSprite = new FlxSprite(700, 115).loadGraphic(Paths.image('menus/credits/portraitBG'));
		iconBG.scrollFactor.set(0,0);
		iconBG.antialiasing = true;
		add(iconBG);

		iconArray = new FlxTypedGroup<FlxSprite>();
		add(iconArray);
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:CenteredText = new CenteredText(0, 70 * i, creditsStuff[i][0]);
			optionText.setFormat(Paths.font("vcr.ttf"), 45, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			optionText.scrollFactor.set(0, 0);
			optionText.antialiasing = ClientPrefs.globalAntialiasing;
			//optionText.yMult = 90;
			optionText.trgetY = i;
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:FlxSprite = new FlxSprite(800,175).loadGraphic(Paths.image('menus/credits/sketches/' + creditsStuff[i][1]));
				icon.scrollFactor.set(0,0);
				icon.setGraphicSize(Std.int(1.475 * icon.width));
				icon.ID = i;
				icon.antialiasing = true;
	
				// using a FlxGroup is too much fuss!
				iconArray.add(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
		}

		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);
		
		descText = new FlxText(675, 500, 500, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
        if(FlxG.keys.justPressed.F11)
        {
        	FlxG.fullscreen = !FlxG.fullscreen;
        }
		
        if(FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		theShaderBG.iTime.value[0] += elapsed;

		if(!quitting)
			{
				if(creditsStuff.length > 1)
				{
					var shiftMult:Int = 1;
					if(FlxG.keys.pressed.SHIFT) shiftMult = 3;
	
					var upP = controls.UI_UP_P;
					var downP = controls.UI_DOWN_P;
	
					if (upP)
					{
						changeSelection(-1 * shiftMult);
						holdTime = 0;
					}
					if (downP)
					{
						changeSelection(1 * shiftMult);
						holdTime = 0;
					}
	
					if(controls.UI_DOWN || controls.UI_UP)
					{
						var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
						holdTime += elapsed;
						var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);
	
						if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
						{
							changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
						}
					}
				}
	
				if(controls.ACCEPT) {
					if (creditsStuff[curSelected][3] == '' || creditsStuff[curSelected][3] == null) {
						FlxG.sound.play(Paths.sound('cancelMenu'));
					}else{
						Utils.browserLoad(creditsStuff[curSelected][3]);
					}
				}

				if (controls.BACK)
				{
					if(colorTween != null) {
						colorTween.cancel();
					}
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new MainMenuState());
					FlxG.sound.music.stop();
					quitting = true;
				}
			}
			super.update(elapsed);
		}
	
		var moveTween:FlxTween = null;

	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		for (item in iconArray.members)
		{
			item.visible = false;

			if (item.ID == curSelected)
			{
				item.visible = true;
			}
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.trgetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.5;

			if (item.trgetY == 0) {
				item.alpha = 1;
			}
		}
		descText.text = creditsStuff[curSelected][2];
		descText.y = 425;

		if(moveTween != null) moveTween.cancel();
		moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});

		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	#if MODS_ALLOWED
	private var modsAdded:Array<String> = [];
	function pushModCreditsToList(folder:String)
	{
		if(modsAdded.contains(folder)) return;

		var creditsFile:String = null;
		if(folder != null && folder.trim().length > 0) creditsFile = Paths.mods(folder + '/data/credits.txt');
		else creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if(arr.length >= 5) arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
		modsAdded.push(folder);
	}
	#end

	function getCurrentBGColor()
	{
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}

class CenteredText extends FlxText
{
	public var trgetY:Float;

    public function new(x:Int, y:Int, text:String)
	{
		super(x, y);

		this.text = text;
	}

	override function update(elapsed:Float)
	{
		var scaledY = FlxMath.remapToRange(trgetY, 0, 1, 0, 1.3);

		var lerpVal:Float = Utils.boundTo(elapsed * 9.6, 0, 1);
		y = FlxMath.lerp(y, (scaledY * 120) + (FlxG.height * 0.48), lerpVal);
		x = FlxMath.lerp(x, trgetY + 130, lerpVal);

		super.update(elapsed);
	}
}
