package event
{

	public class TiBattleEvent extends TiBasicEvent
	{
		

		public static const BOSS_STAGE:String="BOSS_STAGE"
		public static const MONSTER_INIT_FINISH_EVENT:String="MONSTER_INIT_FINISH_EVENT"
		public static const MONSTER_ATTACT_FINISH_EVENT:String="MONSTER_ATTACT_FINISH_EVENT"
		public static const MONSTER_ATTACT_EVENT:String="MONSTER_ATTACT_EVENT"
		public static const MONSTER_SUFFER_FINISH_EVENT:String="MONSTER_SUFFER_FINISH_EVENT"
		public static const MONSTER_DIE_FINISH_EVENT:String="MONSTER_DIE_FINISH_EVENT"
		public static const MONSTER_HIT_HOST_EVENT:String="MONSTER_HIT_HOST_EVENT"
		public static const SHOW_MONSTER_LIFE_EVENT:String="SHOW_MONSTER_LIFE_EVENT"

		public static const HOST_INIT_FINISH_EVENT:String="HOST_INIT_FINISH_EVENT"
		public static const HOST_ATTACT_FINISH_EVENT:String="HOST_ATTACT_FINISH_EVENT"
		public static const HOST_HIT_MONSTER_EVENT:String="HOST_HIT_MONSTER_EVENT"
		public static const HOST_DIE_FINISH_EVENT:String="HOST_DIE_FINISH_EVENT"
		public static const ROUND_FINISH_EVENT:String="ROUND_FINISH_EVENT"
		public static const SHOW_HOST_LIFE_EVENT:String="SHOW_MONSTER_LIFE_EVENT"
		public static const SUCCESS_EVENT:String="SUCCESS_EVENT"
			
		public function TiBattleEvent(type:String, detail:String="",bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type,detail);
		}
	}
}