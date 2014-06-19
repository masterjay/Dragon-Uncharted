package event
{

	public class TiServerEvent extends TiBasicEvent
	{
		public static const SERVER_EVENT:String="SERVER_EVENT"
		public static const SERVER_SIGNIN_COMPLETE_EVENT:String="SERVER_SIGNIN_COMPLETE_EVENT"
		public static const SERVER_ENTER_GAME_COMPLETE_EVENT:String="SERVER_ENTER_GAMEN_COMPLETE_EVENT"

			
		public function TiServerEvent(type:String, detail:String="",bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type,detail,bubbles);
		}
	}
}