package grafex.states;

import grafex.states.substates.ExitGameState;
import grafex.systems.statesystem.MusicBeatState;
import grafex.systems.Paths;
import grafex.systems.Conductor;

import grafex.sprites.Alphabet;

import grafex.effects.shaders.ColorSwap;

import grafex.states.MainMenuState;
import grafex.states.substates.FlashingState;

#if desktop
import utils.Discord.DiscordClient;
import sys.thread.Thread;
#end
import grafex.Utils;
import flixel.FlxG;
import flixel.addons.effects.FlxTrail;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.input.keyboard.FlxKey;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import haxe.Json;
import ColorblindFilters;
import openfl.display.Bitmap;
import grafex.data.WeekData;
import openfl.display.BitmapData;
import sys.FileSystem;
import sys.io.File;
import flixel.addons.display.FlxBackdrop;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.system.ui.FlxSoundTray;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import openfl.Assets;
import lime.ui.WindowAttributes;

using StringTools;

class FuckYouState extends MusicBeatState
{
    override public function create():Void
    {
        FlxG.sound.music.stop();
        FlxG.sound.playMusic(Paths.music('GET_DUNKED'), 6);

        var orang:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('AnnoyingOrange', 'preload'));
        orang.setGraphicSize(Std.int(4.5 * orang.width));
        orang.screenCenter();
        add(orang);

        new FlxTimer().start(2.2, function(tmr:FlxTimer)
        {
            trace('FUCK YOU HTML SITES LMAOOOOOOOOOOOOOOOO');
            yourRAMdies();
        });

        super.create();
    }

    function yourRAMdies()
    {
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
        Utils.browserLoad('https://www.youtube.com/watch?v=akT0wxv9ON8');
    }
}