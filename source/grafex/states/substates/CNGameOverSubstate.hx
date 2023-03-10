package grafex.states.substates;

import grafex.systems.Paths;
import grafex.systems.Conductor;
import grafex.systems.statesystem.MusicBeatState;
import grafex.sprites.characters.Boyfriend;
import grafex.systems.statesystem.MusicBeatSubstate;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.FlxObject;
import flixel.util.FlxDirectionFlags;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxSubState;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class CNGameOverSubstate extends MusicBeatSubstate
{
    var dvd_logo:FlxSprite;
    var colliion:FlxTypedGroup<FlxSprite>;
    var blackie:FlxSprite;
    var isEnding:Bool = false;
    var statics:FlxSprite;

    public function new()
    {
        super();
        FlxG.worldBounds.set(1920,1080);

        PlayState.instance.setOnLuas('inGameOver', true);

		Conductor.songPosition = 0;

        blackie = new FlxSprite(0,200).makeGraphic(Std.int(FlxG.width * 3), Std.int(FlxG.height * 3), FlxColor.BLACK);
        blackie.screenCenter();
        blackie.alpha = 0;
        add(blackie);

        colliion = new FlxTypedGroup<FlxSprite>();
        add(colliion);

        colliion.add(new FlxSprite(-124, 553).makeGraphic(6000, 8)); // top
        colliion.add(new FlxSprite(FlxG.width + 461, 553).makeGraphic(8, 6000)); // right
        colliion.add(new FlxSprite(-124, FlxG.height + 911).makeGraphic(6000, 8)); // bottom
        colliion.add(new FlxSprite(-124, 553).makeGraphic(8, 6000)); // left
        colliion.forEach(function(spr:FlxSprite)
		{
			spr.solid = true;
            spr.immovable = true;
            spr.updateHitbox();
		});

        dvd_logo = new FlxSprite(260,700).loadGraphic(Paths.image('AnnoyingOrange'));
        dvd_logo.elasticity = 1;
        dvd_logo.solid = true;
        dvd_logo.updateHitbox();
        dvd_logo.velocity.set(100,100);
        dvd_logo.alpha = 0;
        add(dvd_logo);

        statics = new FlxSprite(0,0);
		statics.frames = Paths.getSparrowAtlas('misc/menuInterference');
		statics.animation.addByPrefix('epik', 'thing', 24, true);
		statics.animation.play('epik', true);
		statics.setGraphicSize(Std.int(statics.width * 10));
		add(statics);

        FlxFlicker.flicker(statics, 1, 0.06, false, false, function(flick:FlxFlicker)
        {
            blackie.alpha = 1;
            dvd_logo.alpha = 1;
        });
    }

    override function update(elapsed:Float)
	{
        super.update(elapsed);

        FlxG.collide(colliion, dvd_logo);

        if (dvd_logo.isTouching(FlxDirectionFlags.ANY))
        {
            dvd_logo.color = FlxColor.fromRGB(FlxG.random.int(0, 255),FlxG.random.int(0, 255),FlxG.random.int(0, 255));
        }

        if(FlxG.keys.justPressed.F11)
        {
           FlxG.fullscreen = !FlxG.fullscreen;
        }
        if (controls.ACCEPT)
		{
			endBullshit();
		}
        if (controls.BACK)
		{
			PlayState.deathCounter = 0;
			PlayState.seenCutscene = false;

			if (PlayState.isStoryMode)
				MusicBeatState.switchState(new StoryMenuState());
			else
				MusicBeatState.switchState(new FreeplayState());

			FlxG.sound.playMusic(Paths.music('freakyMenu'));
            Conductor.changeBPM(102);
			PlayState.instance.callOnLuas('onGameOverConfirm', [false]);
		}
    }

    function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
            statics.visible = false;
            dvd_logo.visible = false;
			FlxG.sound.play(Paths.sound('dvdShit'));
			new FlxTimer().start(2, function(tmr:FlxTimer)
			{
				MusicBeatState.resetState();
			});
			PlayState.instance.callOnLuas('onGameOverConfirm', [true]);
		}
	}
}