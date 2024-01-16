package utils;

import Date;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.system.scaleModes.RatioScaleMode;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.tweens.misc.VarTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import grafex.cutscenes.Cutscene;
import grafex.cutscenes.Cutscene.CutsceneFile;
import grafex.cutscenes.CutsceneHandler;
import grafex.cutscenes.DialogueBox;
import grafex.cutscenes.DialogueBoxPsych;
import grafex.cutscenes.DialogueBoxPsych.DialogueFile;
import grafex.data.RatingsData;
import grafex.data.StageData;
import grafex.data.WeekData;
import grafex.effects.PhillyGlow.PhillyGlowGradient;
import grafex.effects.PhillyGlow.PhillyGlowParticle;
import grafex.effects.shaders.Shaders.BloomEffect;
import grafex.effects.shaders.Shaders.BloomShader;
import grafex.effects.shaders.Shaders.SolidColorEffect;
import grafex.effects.shaders.Shaders.Tiltshift;
import grafex.effects.shaders.Shaders.TiltshiftEffect;
import grafex.effects.shaders.VHSShader;
import grafex.effects.WiggleEffect;
import grafex.effects.WiggleEffect.WiggleEffectType;
import grafex.sprites.attached.*;
import grafex.sprites.background.*;
import grafex.sprites.characters.Boyfriend;
import grafex.sprites.characters.Character;
import grafex.sprites.HealthIcon;
import grafex.states.editors.CharacterEditorState;
import grafex.states.editors.ChartingState;
import grafex.states.MainMenuState;
import grafex.states.options.OptionsMenu;
import grafex.states.substates.CNGameOverSubstate;
import grafex.states.substates.GameOverSubstate;
import grafex.states.substates.GameplayChangersSubstate;
import grafex.states.substates.LoadingState;
import grafex.states.substates.PauseSubState;
import grafex.systems.Conductor;
import grafex.systems.Conductor.Rating;
import grafex.systems.CustomFadeTransition;
import grafex.systems.FunkinLua;
import grafex.systems.notes.*;
import grafex.systems.notes.Note.EventNote;
import grafex.systems.Paths;
import grafex.systems.song.Section.SwagSection;
import grafex.systems.song.Song;
import grafex.systems.song.Song.SwagSong;
import grafex.systems.statesystem.MusicBeatState;
import grafex.Utils;
import haxe.Json;
import lime.app.Application;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.events.KeyboardEvent;
import openfl.filters.BitmapFilter;
import openfl.filters.BitmapFilter;
import openfl.filters.BlurFilter;
import openfl.filters.ColorMatrixFilter;
import openfl.filters.ShaderFilter;
import openfl.filters.ShaderFilter;
import openfl.Lib;
import openfl.media.SoundChannel;
import openfl.utils.Assets as OpenFlAssets;
import utils.animateatlas.AtlasFrameMaker;
import utils.LuaFlxState;

interface LuaFlxState {
	public var camGame:FlxCamera;
	//public var members(default, null):Array<Dynamic>;
	private var isPlayState:Bool;
	private var curStep:Int;
	private var curBeat:Int;

	private var curDecStep:Float;
	private var curDecBeat:Float;
	private var controls(get, never):Controls;
	
	private function get_controls():Controls;

	public function getControl(key:String):Bool;

	//public function callStageFunctions(event:String,args:Array<Dynamic>,gameStages:Map<String,FunkyFunct>):Void;

	public var modchartTweens:Map<String, FlxTween>;
	public var modchartSprites:Map<String, ModchartSprite>;
	public var modchartTimers:Map<String, FlxTimer>;
	public var modchartSounds:Map<String, FlxSound>;
	public var modchartTexts:Map<String, ModchartText>;
	public var modchartSaves:Map<String, FlxSave>;
	
	private function updateBeat():Void;

	private function updateCurStep():Void;
	public var persistentUpdate:Bool;

	//public function remove(Object:FlxBasic, ?Splice:Bool = false):FlxBasic;
	//public function callOnLuas(event:String, args:Array<Dynamic>, ?ignoreStops:Bool, ?exclusions:Array<String>):Dynamic;
	

	public function stepHit():Void;

	public function beatHit():Void;

	public function getLuaObject(tag:String, text:Bool=true):FlxSprite;
}
