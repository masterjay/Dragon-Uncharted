package model
{

	public class modelPlayer extends modelBase
	{
		
		private static var m_Instance:modelPlayer;

		public var uuid:String="";
		public var hp:int = 0;
		public var max_hp:int = 0;
		public var attack:int = 0;
		public var defend:int = 0;
		public var game_id:int = -1;
		public var seat_no:int = -1;
		
		public function modelPlayer()
		{}
		
		public static function fnGetInstance():modelPlayer
		{
			if (m_Instance == null)
			{
				m_Instance=new modelPlayer();
			}
			return m_Instance;
		}
		
		public function fnReset():void
		{
			hp = 0;
			attack = 0;
			defend = 0;
			game_id = -1
			seat_no = -1	
		}
	}
}