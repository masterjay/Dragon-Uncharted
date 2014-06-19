package model
{

	public class modelEnemy extends modelBase
	{
		
		private static var m_Instance:modelEnemy;

		public var uuid:String = "";
		public var max_hp:int=0;
		public var hp:int = 0;
		public var attack:int = 0;
		public var defend:int = 0;
		public var game_id:int = -1;
		public var seat_no:int = -1;
		
		public function modelEnemy()
		{}
		
		public static function fnGetInstance():modelEnemy
		{
			if (m_Instance == null)
			{
				m_Instance=new modelEnemy();
			}
			return m_Instance;
		}
		
		public function fnReset():void
		{
			uuid = "";
			hp = 0;
			attack = 0;
			defend = 0;
			game_id = -1
			seat_no = -1	
		}
	}
}