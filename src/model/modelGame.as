package model
{
	public class modelGame extends modelBase
	{
		public var id:int;
		public var state:int;
		public var players:Array;// two object , not model player
		public var player_max:int;
		public var round_no:int;
		public var round_max:int;
		
		public function modelGame()
		{}
	}
}