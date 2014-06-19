package base
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class TiDamageNumber extends Sprite
	{
		public function TiDamageNumber()
		{
			super();
		}
		protected var m_mcNumber:MovieClip
		
		protected function fnInitNumber():void
		{
			
			//m_mcNumber.addEventListener(Event.COMPLETE,fnComplete);
			m_mcNumber.loop = false;
			starling.core.Starling.juggler.add(m_mcNumber);
		}
		private function fnComplete(e:Event):void
		{
			// TODO Auto Generated method stub
			m_mcNumber.removeEventListener(Event.COMPLETE,fnComplete);
			starling.core.Starling.juggler.remove(m_mcNumber);
		}
		public function fnPlayAni():void
		{
			m_mcNumber.stop();
			m_mcNumber.play();
		}
	}
}