package event
{
	public class TiplayerDataHandlerEvent extends TiBasicEvent
	{
		
		public static const PLAYER_DATA_LOAD_COMPLETE:String="PLAYER_DATA_LOAD_COMPLETE"
		
		public function TiplayerDataHandlerEvent(type:String, detail:String="")
		{
			super(type, detail);
		}
	}
}