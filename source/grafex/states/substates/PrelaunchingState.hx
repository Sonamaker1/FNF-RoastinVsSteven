package grafex.states.substates;

import grafex.systems.statesystem.MusicBeatState;

class PrelaunchingState extends MusicBeatState
{
    override function create()
    {
        //Make it better in future - PurSnake
        MusicBeatState.switchState(new TitleState());
    }
}