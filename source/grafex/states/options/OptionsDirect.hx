package grafex.states.options;
import grafex.systems.Paths;
import grafex.systems.statesystem.MusicBeatState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxG;
import lime.app.Application;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;

class OptionsDirect extends MusicBeatState
{
	override function create()
	{
		//transIn = FlxTransitionableState.defaultTransIn;
		//transOut = FlxTransitionableState.defaultTransOut;

		Application.current.window.title = Main.appTitle + ' - Options';

		persistentUpdate = true;

        var movingBG:FlxBackdrop;
        movingBG = new FlxBackdrop(Paths.image('menus/freeplay/fpBG'), 10, 0, true, true);
		movingBG.scrollFactor.set(0,0);
		movingBG.alpha = 0.8;
        movingBG.velocity.x = FlxG.random.float(-90, 90);
		movingBG.velocity.y = FlxG.random.float(-20, 20);
		add(movingBG);

		var rightCN:FlxBackdrop = new FlxBackdrop(Paths.image('menus/options/op-thingie'), 0, 10, false, true);
		rightCN.scrollFactor.set(0,0);
		rightCN.x = -1000;
		rightCN.flipX = true;
		rightCN.velocity.y = -100;
		add(rightCN);

        var leftCN:FlxBackdrop = new FlxBackdrop(Paths.image('menus/freeplay/fp-thingie'), 0, 10, false, true);
		leftCN.scrollFactor.set(0,0);
		leftCN.x = 980;
		leftCN.velocity.y = 100;
		add(leftCN);

		openSubState(new OptionsMenu());
	}
}