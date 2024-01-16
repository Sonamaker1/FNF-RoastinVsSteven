package grafex.states.substates;

import utils.LuaFlxState;
import grafex.systems.Paths;
import grafex.systems.Conductor;
import grafex.systems.statesystem.MusicBeatState;
import grafex.sprites.characters.Boyfriend;
import grafex.systems.statesystem.MusicBeatSubstate;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import grafex.systems.FunkinLua;
import flixel.FlxCamera;
import flixel.util.FlxSave;
#if sys
import sys.FileSystem;
#end

using StringTools;
class GameOverSubstate extends MusicBeatSubstate
{
	private var isPlayState = false;
	
	public var boyfriend:Boyfriend;
	var updateCamera:Bool = false;
	var playingDeathSound:Bool = false;
	var ableToCamBeat:Bool = false;
	public static var instance:GameOverSubstate;
	var stageSuffix:String = "";

	public static var characterName:String = 'nobody';
	public static var deathSoundName:String = 'fnf_loss_sfx';
	public static var loopSoundName:String = 'gameOver';
	public static var endSoundName:String = 'gameOverEnd';
	public static var deathLoopBpm:Float = 102;
	public var luaArray:Array<FunkinLua> = [];
	public var camGame:FlxCamera;
	
	public static function resetVariables() {
		characterName = 'nobody';//'bf-dead';
		deathSoundName = 'fnf_loss_sfx';
		loopSoundName = 'gameOver';
		endSoundName = 'gameOverEnd';
		var _song = PlayState.SONG;
		if(_song != null)
		{
			if(_song.gameOverChar != null && _song.gameOverChar.trim().length > 0) characterName = _song.gameOverChar;
			if(_song.gameOverSound != null && _song.gameOverSound.trim().length > 0) deathSoundName = _song.gameOverSound;
			if(_song.gameOverLoop != null && _song.gameOverLoop.trim().length > 0) loopSoundName = _song.gameOverLoop;
			if(_song.gameOverEnd != null && _song.gameOverEnd.trim().length > 0) endSoundName = _song.gameOverEnd;
			if(_song.deathLoopBpm != null && (_song.deathLoopBpm) > 0) deathLoopBpm = _song.deathLoopBpm;
		}
	}

	override function create()
	{
		instance = this;
		camGame = FlxG.camera;
		
		var G = PlayState.instance;
		var stage = PlayState.SONG.stage;
		#if sys
		if(FileSystem.exists("mods/gameovers/gameover.lua")){
			G.luaArray.push(new FunkinLua("mods/gameovers/gameover.lua")); //You can add more of these!
		}
		if(FileSystem.exists('mods/gameovers/${stage}.lua')){
			G.luaArray.push(new FunkinLua('mods/gameovers/${stage}.lua')); //You can add more of these!
		}
		#end
		PlayState.instance.callOnLuas('onGameOverStart', []);
		super.create();
		
		
	}

	public function new()
	{
		super();
		instance = this;
		FlxG.worldBounds.set(1920,1080);
		PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;

		boyfriend = new Boyfriend(0, 0, characterName);
		boyfriend.updateHitbox;
		boyfriend.screenCenter();
		boyfriend.x += boyfriend.cameraPosition[0];
		boyfriend.y += boyfriend.cameraPosition[1];
		add(boyfriend);

		if(deathSoundName.length > 0){
			FlxG.sound.play(Paths.sound(deathSoundName));
		}
		Conductor.changeBPM(deathLoopBpm); //Interesting choice... I'll change it a little though
		// FlxG.camera.followLerp = 1;
		FlxG.camera.scroll.set();
		
		if(characterName.length > 0 && characterName != "nobody"){
			boyfriend.playAnim('firstDeath');
		}
		//PlayState.curState = this;
	}

	var isFollowingAlready:Bool = false;
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		FlxG.camera.zoom = FlxMath.lerp(PlayState.defaultCamZoom, FlxG.camera.zoom, Utils.boundTo(1 - (elapsed * 3.125), 0, 1));
		if(FlxG.keys.justPressed.F11)
		{
			FlxG.fullscreen = !FlxG.fullscreen;
		}
		PlayState.instance.callOnLuas('deadUpdate', [elapsed]);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;
			PlayState.chartingMode = false;

			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new MainMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
            		Conductor.changeBPM(102); 
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}

		if (boyfriend.animation.curAnim != null && boyfriend.animation.curAnim.name == 'firstDeath')
		{
			if (boyfriend.animation.curAnim.finished && !playingDeathSound)
			{
				coolStartDeath();
				boyfriend.startedDeath = true;
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
		PlayState.instance.callOnLuas('deadUpdatePost', [elapsed]);
	}

	override function beatHit()
	{
		super.beatHit();

		if(ableToCamBeat)
		{
			if(FlxG.camera.zoom < 1.35 && ClientPrefs.camZooms && curBeat % 2 == 0)
				FlxG.camera.zoom += 0.025;
		  	if(FlxG.camera.zoom < 1.35 && ClientPrefs.camZooms && curBeat % 2 == 1)
				FlxG.camera.zoom -= 0.025;
		}
		PlayState.instance.callOnLuas('deadBeatHit', []);
		//FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function coolStartDeath(?volume:Float = 1):Void
	{
		FlxG.sound.playMusic(Paths.music(loopSoundName), volume);
		//ableToCamBeat = true;
	}

	function endBullshit():Void
	{
		if (!isEnding)
		{
			ableToCamBeat = false;
			isEnding = true;
			boyfriend.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music(endSoundName));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					MusicBeatState.resetState();
				});
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}
