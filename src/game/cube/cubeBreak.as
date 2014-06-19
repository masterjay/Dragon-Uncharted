package game.cube
{
	import event.TiCubeEvent;
	
	import resources.GetCubeMCHandler;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class cubeBreak extends Sprite
	{
		
		private var m_mcBreak:MovieClip;

		public function cubeBreak()
		{
			super();
			this.addChild(fnInitBreak());
		}
		
		private function fnInitBreak():MovieClip
		{
			if(m_mcBreak == null)
			{
				m_mcBreak = new starling.display.MovieClip(GetCubeMCHandler.getAtlasCubeBreak().getTextures("h2_break"),20);

		}
			return m_mcBreak;
		}
		
			
		public function fnPlayBreakAni():void
		{
			m_mcBreak.x = -( m_mcBreak.width/4);
			m_mcBreak.y = -( m_mcBreak.height/4);
			m_mcBreak.addEventListener(Event.COMPLETE, fnBreakComplete);
			Starling.juggler.add(m_mcBreak);

			
		}
		
		private function fnBreakComplete(e:Event):void
		{
			m_mcBreak.removeEventListener(Event.COMPLETE, fnBreakComplete);
			Starling.juggler.remove(m_mcBreak);

			var ev:TiCubeEvent = new TiCubeEvent(TiCubeEvent.CUBE_BREAK_END_EVENT);
			this.dispatchEvent(ev);
		}			
		
		
	}
}