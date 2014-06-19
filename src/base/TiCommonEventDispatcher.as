package base
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class TiCommonEventDispatcher extends EventDispatcher
	{
		private static var m_Instance: TiCommonEventDispatcher = new TiCommonEventDispatcher();
		
		public static function fnGetInstance(): TiCommonEventDispatcher 
		{
			if ( m_Instance == null ) 
			{
				m_Instance = new TiCommonEventDispatcher();
			}
			return m_Instance;
		}
		
		public function TiCommonEventDispatcher(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}