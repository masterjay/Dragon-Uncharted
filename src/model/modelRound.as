package model
{
	public class modelRound extends modelBase
	{
		public var id:String
		public var state:int 
		public var time:int = 0;
		public var hp:Array
		public var attack:Array 
		public var defend:Array 
		public var game_over:Boolean 
		public var winner:String;
		
		
		public function modelRound()
		{
		}
	}
}