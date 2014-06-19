package game.ui
{
	import event.TiBattleEvent;
	import event.TiGameEvent;
	import event.TiGameFlowEvent;
	
	import resources.GetRoundTimeMCHandler;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;

	public class RoundTime extends Sprite
	{
		private var m_mcRoundTime:MovieClip
		private var m_bIsplaying:Boolean = false
		public function RoundTime()
		{
			this.addChild(fnInit());
		}
		
		private function fnInit():MovieClip
		{
			if(m_mcRoundTime === null)
			{
				m_mcRoundTime = new starling.display.MovieClip(GetRoundTimeMCHandler.getAtlas().getTextures("ani_time"),6);
			}
			return m_mcRoundTime;
		}
		
		public function fnPalyAni():void
		{
			this.visible = true;
		//	m_mcRoundTime.stop();
			m_mcRoundTime.addEventListener(Event.COMPLETE,fnRoundTimeFinish);
			starling.core.Starling.juggler.add(m_mcRoundTime);
			m_bIsplaying = true;
		}
		
		private function fnRoundTimeFinish(e:Event):void
		{   this.visible = false
			m_mcRoundTime.removeEventListener(Event.COMPLETE,fnRoundTimeFinish);
			starling.core.Starling.juggler.remove(m_mcRoundTime);
			var ev:TiGameFlowEvent = new TiGameFlowEvent(TiGameFlowEvent.GAME_FLOW_EVENT,TiGameFlowEvent.ROUND_TIME_FINISH);
			dispatchEvent(ev);
			m_bIsplaying = false
		}
		
		public function fnIsPlaying():Boolean
		{
			return m_bIsplaying
		}
	}
}