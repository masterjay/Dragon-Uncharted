package event
{
	import flash.geom.Point;
	
	import base.TiCube;
	
	import starling.events.Event;
	
	public class TiCubeEvent extends starling.events.Event
	{
		public static const CUBE_OVER_EVENT:String="CUBE_OVER_EVENT"
		public static const CUBE_MOVE_EVENT:String="CUBE_MOVE_EVENT"
		public static const CUBE_DOWN_EVENT:String="CUBE_DOWN_EVENT"
		public static const CUBE_UP_EVENT:String="CUBE_DOWN_EVENT"
		public static const CUBE_BREAK_END_EVENT:String = "CUBE_BREAK_END_EVENT";
		public static const CUBE_REMOVE_INIT_MARK_COMPLETE:String = "CUBE_REMOVE_INIT_MARK_COMPLETE";
		public static const CUBE_REMOVE_MARK_COMPLETE:String = "CUBE_REMOVE_MARK_COMPLETE";
		public static const CUBE_PLUS_COMPLETE:String = "CUBE_PLUS_COMPLETE";
		public var m_nCubeIndex:int = 0;
		public var m_cube:TiCube	
		public var m_po:Point = new Point();
		public var m_arRemove:Array =new Array();
		public function TiCubeEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}