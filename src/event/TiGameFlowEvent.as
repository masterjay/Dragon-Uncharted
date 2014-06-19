package event
{

	public class TiGameFlowEvent extends TiBasicEvent
	{
		public static const GAME_FLOW_EVENT:String="GAME_FLOW_EVENT"
		
		public static const GAME_READY:String="GAME_READY"
		public static const GAME_PAYING:String="GAME_PAYING"
	//	public static const GAME_OVER:String="GAME_OVER"

		public static const ROUND_START_WAITING:String="ROUND_START_WAITING"
		public static const ROUND_TIME_FINISH:String = "ROUND_TIME_FINISH";
		public static const ROUND_START:String="ROUND_START"
		public static const ROUND_END_WAITING:String = "ROUND_END_WAITING";	
		public static const ROUND_END:String="END_ROUND"
		public static const ROUND_OVER_WAITING:String="ROUND_OVER_WAITING"
		public static const ROUND_OVER:String="ROUND_OVER"


			
		public function TiGameFlowEvent(type:String, detail:String="",bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type,detail,bubbles);
		}
	}
}