package event
{

	public class TiGameEvent extends TiBasicEvent
	{
		public static const GAME_EVENT:String="GAME_EVENT"
		public static const NAVIGATION_BATTLE_START_EVENT:String="NAVIGATION_BATTLE_START_EVENT"
		public static const COUNT_DOWN_FINISH_EVENT:String="COUNT_DOWN_FINISH_EVENT"
		public static const LOAD_RESOURCES_FINISH_EVENT:String="LOAD_RESOURCES_FINISH_EVENT"
		public static const GAME_RESTART:String="GAME_RESTART"
		public static const SOUND_DOWNLOAD_COMPLETE:String="SOUND_DOWNLOAD_COMPLETE"
		public static const INIT_COMPLETE:String="INIT_COMPLETE"
		


			
		public function TiGameEvent(type:String, detail:String="",bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type,detail,bubbles);
		}
	}
}