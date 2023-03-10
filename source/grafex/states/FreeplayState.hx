package grafex.states;

import grafex.states.substates.ResetScoreSubState;
import grafex.states.substates.LoadingState;
import grafex.states.substates.GameplayChangersSubstate;
import grafex.systems.song.Song;
import grafex.systems.Conductor;
import grafex.systems.Paths;
import grafex.sprites.HealthIcon;
import grafex.sprites.Alphabet;
import grafex.systems.statesystem.MusicBeatState;
#if desktop
import utils.Discord.DiscordClient;
#end
import grafex.states.editors.ChartingState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.utils.Assets;
import flixel.system.FlxSound;
import openfl.utils.Assets as OpenFlAssets;
import grafex.data.WeekData;
import lime.app.Application;
import sys.FileSystem;
import flixel.util.FlxTimer;

using StringTools;

class FreeplayState extends MusicBeatState
{
	var songs:Array<SongMetadata> = [];

	var selector:FlxText;
	private static var curSelected:Int = 0;
	var curDifficulty:Int = 2;
	private static var lastDifficultyName:String = '';

	var scoreBG:FlxSprite;
	var scoreText:FlxText;
	var lerpScore:Int = 0;
	var lerpRating:Float = 0;
	var intendedScore:Int = 0;
	var intendedRating:Float = 0;
	var songText:FlxText;

	private var grpSongs:FlxTypedGroup<Alphabet>;
	private var curPlaying:Bool = false;

	private var iconArray:Array<HealthIcon> = [];

	var bg:FlxBackdrop;
	var intendedColor:Int;
	var colorTween:FlxTween;

	var songArray:Array<String> = ['Roasted', 'Snapback', 'Pancakes', 'Protest', 'Nuisance', 'My Own Creation', 'Racism', 'Starlight', 'Flan'];
    var cnLogoUp:FlxSprite;
	var cnLogoDown:FlxSprite;
	var cnLogoMiddle:FlxSprite;
	var artsGroup:FlxTypedGroup<FlxSprite>;
	var questionMarks:FlxSprite;

	override function create()
	{
		Paths.clearStoredMemory();
		Application.current.window.title = Main.appTitle + ' - Freeplay Menu';
		
		PlayState.isStoryMode = false;
		WeekData.reloadWeekFiles(false);

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menu", null);
		#end

		for (i in 0...WeekData.weeksList.length) {
			if(weekIsLocked(WeekData.weeksList[i])) continue;

			var leWeek:WeekData = WeekData.weeksLoaded.get(WeekData.weeksList[i]);
			var leSongs:Array<String> = [];
			var leChars:Array<String> = [];

			for (j in 0...leWeek.songs.length)
			{
				leSongs.push(leWeek.songs[j][0]);
				leChars.push(leWeek.songs[j][1]);
			}

			WeekData.setDirectoryFromWeek(leWeek);
			for (song in leWeek.songs)
			{
				var colors:Array<Int> = song[2];
				if(colors == null || colors.length < 3)
				{
					colors = [146, 113, 253];
				}
			}
		}
		WeekData.loadTheFirstEnabledMod();

	    for(i in 0...songArray.length)
		{
			addSong(songArray[i], 0, 'steven-new', FlxColor.fromRGB(146, 113, 253));
		}

		/*//KIND OF BROKEN NOW AND ALSO PRETTY USELESS//

		var initSonglist = Utils.coolTextFile(Paths.txt('freeplaySonglist'));
		for (i in 0...initSonglist.length)
		{
			if(initSonglist[i] != null && initSonglist[i].length > 0) {
				var songArray:Array<String> = initSonglist[i].split(":");
				addSong(songArray[0], 0, songArray[1], Std.parseInt(songArray[2]));
			}
		}*/

        bg = new FlxBackdrop(Paths.image('menus/freeplay/fpBG'), 10, 0, true, true);
		bg.scrollFactor.set(0,0);
		bg.antialiasing = true;
        bg.velocity.x = FlxG.random.float(-90, 90);
		bg.velocity.y = FlxG.random.float(-20, 20);
		add(bg);

		var leftCN:FlxBackdrop = new FlxBackdrop(Paths.image('menus/freeplay/fp-thingie'), 0, 10, false, true);
		leftCN.scrollFactor.set(0,0);
		leftCN.antialiasing = true;
		leftCN.x = 444;
		leftCN.velocity.y = 100;
		add(leftCN);

	    songText = new FlxText(350, 265, FlxG.width, "", 58);
		songText.setFormat(Paths.font("vcr.ttf"), 58, FlxColor.WHITE, CENTER);
		songText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1.1);
		songText.antialiasing = true;
    	songText.scrollFactor.set();
		add(songText); 
		WeekData.setDirectoryFromWeek();

		scoreText = new FlxText(songText.x, 375, FlxG.width, "", 40);
		scoreText.setFormat(Paths.font("vcr.ttf"), 40, FlxColor.WHITE, CENTER);
		scoreText.antialiasing = true;
		scoreText.setBorderStyle(OUTLINE, FlxColor.BLACK, 1.1);
		add(scoreText);

		if(curSelected >= songs.length) curSelected = 0;

		lastDifficultyName = 'Hard';

		var swag:Alphabet = new Alphabet(1, 0, "swag");

		cnLogoUp = new FlxSprite(-250, 213).loadGraphic(Paths.image('menus/freeplay/cnLogoUpside'));
		cnLogoUp.antialiasing = true;
		cnLogoUp.setGraphicSize(Std.int(cnLogoUp.width * 0.4));

		cnLogoMiddle = new FlxSprite(cnLogoUp.x, 178).loadGraphic(Paths.image('menus/freeplay/cnLogoMiddleside'));
		cnLogoMiddle.antialiasing = true;
		cnLogoMiddle.setGraphicSize(Std.int(cnLogoMiddle.width * 0.4));

		var logoBg:FlxSprite = new FlxSprite(84, 320).makeGraphic(399, 171, FlxColor.WHITE);

		cnLogoDown = new FlxSprite(cnLogoUp.x, 410).loadGraphic(Paths.image('menus/freeplay/cnLogoDownside'));
		cnLogoDown.antialiasing = true;
		cnLogoDown.setGraphicSize(Std.int(cnLogoDown.width * 0.4));

        add(logoBg);

		questionMarks = new FlxSprite(cnLogoMiddle.x, cnLogoMiddle.y).loadGraphic(Paths.image('menus/freeplay/arts/unknown'));
	    questionMarks.antialiasing = false;
		questionMarks.visible = false;
		questionMarks.setGraphicSize(Std.int(questionMarks.width * 0.4));
		add(questionMarks);

		artsGroup = new FlxTypedGroup<FlxSprite>();
		add(artsGroup);

        for(i in 0...songArray.length)
		{
			var arts:FlxSprite = new FlxSprite(cnLogoMiddle.x, cnLogoMiddle.y).loadGraphic(Paths.image('menus/freeplay/arts/' + songArray[i]));
			arts.antialiasing = true;
			arts.setGraphicSize(Std.int(arts.width * 0.4));
			arts.ID = i;
			artsGroup.add(arts);
		}

		add(cnLogoMiddle);
		add(cnLogoUp);
		add(cnLogoDown);

		changeSelection();

		// JUST DOIN THIS SHIT FOR TESTING!!!
		/* 
			var md:String = Markdown.markdownToHtml(Assets.getText('CHANGELOG.md'));

			var texFel:TextField = new TextField();
			texFel.width = FlxG.width;
			texFel.height = FlxG.height;
			// texFel.
			texFel.htmlText = md;

			FlxG.stage.addChild(texFel);

			// scoreText.textField.htmlText = md;

			trace(md);
		 */

		var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		#if PRELOAD_ALL
		var leText:String = "Press SPACE to listen to the Song / Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 16;
		#else
		var leText:String = "Press CTRL to open the Gameplay Changers Menu / Press RESET to Reset your Score and Accuracy.";
		var size:Int = 18;
		#end
		var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, leText, size);
		text.setFormat(Paths.font("vcr.ttf"), size, FlxColor.WHITE, RIGHT);
		text.scrollFactor.set();
		add(text);
		super.create();
	}

	override function closeSubState() {
		changeSelection(0, false);
		super.closeSubState();
	}

	public function addSong(songName:String, weekNum:Int, songCharacter:String, color:Int)
	{
		songs.push(new SongMetadata(songName, weekNum, songCharacter, color));
	}

	function weekIsLocked(name:String):Bool {
		var leWeek:WeekData = WeekData.weeksLoaded.get(name);
		return (!leWeek.startUnlocked && leWeek.weekBefore.length > 0 && (!StoryMenuState.weekCompleted.exists(leWeek.weekBefore) || !StoryMenuState.weekCompleted.get(leWeek.weekBefore)));
	}
	
	/*public function addWeek(songs:Array<String>, weekNum:Int, weekColor:Int, ?songCharacters:Array<String>)
	{
		if (songCharacters == null)
			songCharacters = ['bf'];

		var num:Int = 0;
		for (song in songs)
		{
			addSong(song, weekNum, songCharacters[num]);
			this.songs[this.songs.length-1].color = weekColor;

			if (songCharacters.length != 1)
				num++;
		}
	}*/

	var instPlaying:Int = -1;
    var holdTime:Float = 0;
	var songForText:String;
   private static var vocals:FlxSound = null;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		if(FlxG.keys.justPressed.F11)
        	FlxG.fullscreen = !FlxG.fullscreen;

        if (FlxG.sound.music.volume < 0.7)
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

		lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, Utils.boundTo(elapsed * 24, 0, 1)));
		lerpRating = FlxMath.lerp(lerpRating, intendedRating, Utils.boundTo(elapsed * 12, 0, 1));

		if (Math.abs(lerpScore - intendedScore) <= 10)
			lerpScore = intendedScore;
		if (Math.abs(lerpRating - intendedRating) <= 0.01)
			lerpRating = intendedRating;

		var ratingSplit:Array<String> = Std.string(Highscore.floorDecimal(lerpRating * 100, 2)).split('.');
		if(ratingSplit.length < 2) { //No decimals, add an empty space
			ratingSplit.push('');
		}
		
		while(ratingSplit[1].length < 2) { //Less than 2 decimals in it, add decimals then
			ratingSplit[1] += '0';
		}

		scoreText.text = 'Score: ' + lerpScore;

		FlxG.camera.zoom = FlxMath.lerp(1, FlxG.camera.zoom, Utils.boundTo(1 - (elapsed * 3.125), 0, 1));

		var rightP = controls.UI_RIGHT_P;
		var leftP = controls.UI_LEFT_P;
		var accepted = controls.ACCEPT;
		var space = FlxG.keys.justPressed.SPACE;
		var ctrl = FlxG.keys.justPressed.CONTROL;

		var shiftMult:Int = 1;
		if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

		if(songs.length > 1)
		{
			if (leftP)
			{
				changeSelection(-shiftMult);
				holdTime = 0;
			}
			if (rightP)
			{
				changeSelection(shiftMult);
				holdTime = 0;
			}
		}

		if(FlxG.mouse.wheel != 0)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
				changeSelection(-shiftMult * FlxG.mouse.wheel, false);
			}

		if (controls.BACK)
		{
			if(colorTween != null) {
				colorTween.cancel();
			}
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if(ctrl)
		{
			openSubState(new GameplayChangersSubstate());
		}
		else if(space)
		{
			if(instPlaying != curSelected)
			{
				#if PRELOAD_ALL
                                destroyFreeplayVocals();
				FlxG.sound.music.volume = 0;
				Paths.currentModDirectory = songs[curSelected].folder;
				var poop:String = Highscore.formatSong(songs[curSelected].songName.toLowerCase(), curDifficulty);
				PlayState.SONG = Song.loadFromJson(poop, songs[curSelected].songName.toLowerCase());
                                if (PlayState.SONG.needsVoices)
					vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song));
				else
					vocals = new FlxSound();
				FlxG.sound.list.add(vocals);
				FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song), 0.7);
				vocals.play();
				vocals.persist = true;
				vocals.looped = true;
				vocals.volume = 0.7;
				Conductor.changeBPM(PlayState.SONG.bpm);
				instPlaying = curSelected;
				#end
			}
		}

		else if (accepted || FlxG.mouse.justPressed)
		{
			persistentUpdate = false;
			var songLowercase:String = Paths.formatToSongPath(songs[curSelected].songName);
			var poop:String = Highscore.formatSong(songLowercase, curDifficulty);
			/*#if MODS_ALLOWED
			if(!sys.FileSystem.exists(Paths.modsJson(songLowercase + '/' + poop)) && !sys.FileSystem.exists(Paths.json(songLowercase + '/' + poop))) {
			#else
			if(!OpenFlAssets.exists(Paths.json(songLowercase + '/' + poop))) {
			#end
				poop = songLowercase;
				curDifficulty = 1;
				trace('Couldnt find file');
			}*/
			trace(poop);

			PlayState.SONG = Song.loadFromJson(poop, songLowercase);
			PlayState.isStoryMode = false;
			PlayState.storyDifficulty = curDifficulty;

			trace('CURRENT WEEK: ' + WeekData.getWeekFileName());
			if(colorTween != null) {
				colorTween.cancel();
			}
			
			if (FlxG.keys.pressed.SHIFT){
				LoadingState.loadAndSwitchState(new ChartingState());
			}else{
				LoadingState.loadAndSwitchState(new PlayState());
			}

			FlxG.sound.music.volume = 0;
					
			destroyFreeplayVocals();


		}
		else if(controls.RESET)
        {
            persistentUpdate = false;
			openSubState(new ResetScoreSubState(songs[curSelected].songName, curDifficulty, songs[curSelected].songCharacter));
			FlxG.sound.play(Paths.sound('scrollMenu'));
		}
		super.update(elapsed);
	}

	override function beatHit() {
		super.beatHit();

		if (FlxG.camera.zoom < 1.35 && ClientPrefs.camZooms && curBeat % 2 == 0)
			FlxG.camera.zoom += 0.015;
	}
	public static function destroyFreeplayVocals() {
		if(vocals != null) {
			vocals.stop();
			vocals.destroy();
		}
		vocals = null;
	}

	function changeSelection(change:Int = 0, playSound:Bool = true)
	{
		if(playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);

		curSelected += change;

		if (curSelected < 0)
			curSelected = songs.length - 1;
		if (curSelected >= songs.length)
			curSelected = 0;

		// selector.y = (70 * curSelected) + 30;

		#if !switch
		intendedScore = Highscore.getScore(songs[curSelected].songName, curDifficulty);
		intendedRating = Highscore.getRating(songs[curSelected].songName, curDifficulty);
		#end

		var bullShit:Int = 0;
		
		Paths.currentModDirectory = songs[curSelected].folder;
		PlayState.storyWeek = songs[curSelected].week;

		switch(curSelected)
		{
			case 2:
			    if(!ClientPrefs.pancakesUnlocked)
				{
					songForText = '???';
				}
				else
				{
					songForText = 'Pancakes';
				}
			case 3:
			    if(!ClientPrefs.protestUnlocked)
				{
					songForText = '???';
				}
				else
				{
					songForText = 'Protest';
				}
			case 4:
			    if(!ClientPrefs.nuisanceUnlocked)
				{
					songForText = '???';
				}
				else
				{
					songForText = 'Nuisance';
				}
			case 5:
			    if(!ClientPrefs.mocUnlocked)
				{
					songForText = '???';
				}
				else
				{
					songForText = 'MOC';
				}
			case 6:
			    if(!ClientPrefs.racismUnlocked)
				{
					songForText = '???';
				}
				else
				{
					songForText = 'Racism';
				}
			case 7:
			    if(!ClientPrefs.starlightUnlocked)
				{
					songForText = '???';
				}
				else
				{
					songForText = 'Starlight';
				}
			case 8:
			    if(!ClientPrefs.flanUnlocked)
				{
					songForText = '???';
				}
				else
				{
					songForText = 'Flan';
				}
			default:
			    songForText = songs[curSelected].songName;
		}
		songText.text = '< ' + songForText + ' >';

		FlxTween.tween(cnLogoUp, {y: cnLogoMiddle.y + 35}, 0.12, {
			onComplete: function(twn:FlxTween)
			{
				updateArts();
			}
		});

		FlxTween.tween(cnLogoDown, {y: 410}, 0.12);

		Utils.difficulties = Utils.defaultDifficulties.copy();
		var diffStr:String = WeekData.getCurrentWeek().difficulties;
		if(diffStr != null) diffStr = diffStr.trim(); //Fuck you HTML5

		if(diffStr != null && diffStr.length > 0)
		{
			var diffs:Array<String> = diffStr.split(',');
			var i:Int = diffs.length - 1;
			while (i > 0)
			{
				if(diffs[i] != null)
				{
					diffs[i] = diffs[i].trim();
					if(diffs[i].length < 1) diffs.remove(diffs[i]);
				}
				--i;
			}

			if(diffs.length > 0 && diffs[0].length > 0)
			{
				Utils.difficulties = diffs;
			}
		}
		
		curDifficulty = 2;
	}

	function updateArts()
	{
		for (item in artsGroup.members)
		{
			item.visible = false;

			if (item.ID == curSelected && songForText != '???')
			{
				item.visible = true;
			}
		}

		questionMarks.visible = songForText == '???';

		FlxTween.tween(cnLogoUp, {y: 90}, 0.12);
		FlxTween.tween(cnLogoDown, {y: 430}, 0.12);
	}
}

class SongMetadata
{
	public var songName:String = "";
	public var week:Int = 0;
	public var songCharacter:String = "";
	public var color:Int = -7179779;
	public var folder:String = "";

	public function new(song:String, week:Int, songCharacter:String, color:Int)
	{
		this.songName = song;
		this.week = week;
		this.songCharacter = songCharacter;
		this.color = color;
		this.folder = Paths.currentModDirectory;
		if(this.folder == null) this.folder = '';
	}
}