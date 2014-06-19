package handler
{
	import event.TiGameEvent;
	
	import game.host.Host;
	import game.monster.Solider;
	import game.monster.boss;
	import game.monster.dragon;
	import game.ui.startCountDown;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Sprite;

	public class LoadResourcesHandler extends Sprite
	{
		public function LoadResourcesHandler()
		{
		}
		private static var m_Instance:LoadResourcesHandler
		private var m_nResourcesCount:int = 0;
		private var m_nResourcesCompleteCount:int = 0;
		private var m_tDelayCall:DelayedCall
		private var m_host:Host
		public static function fnGetInstance():LoadResourcesHandler
		{
			if (m_Instance == null)
			{
				m_Instance = new LoadResourcesHandler();
			}
			return m_Instance;
		}
		
		public function fnLoadResources():void
		{
			fnLoadHost();
			fnLoadMonster();
			fnLoadUI();
			fnCheckResources();
		}
		private function fnLoadHost():void
		{
			m_nResourcesCount++
			
			Host.fnGetInstance().addEventListener(TiGameEvent.LOAD_RESOURCES_FINISH_EVENT,fnLoadResourceFinishEventHandler);
			Host.fnGetInstance().fnLoadResources();

		}
		
		private function fnLoadResourceFinishEventHandler(e:TiGameEvent):void
		{
			// TODO Auto Generated method stub
			m_nResourcesCompleteCount++
		}
		
		private function fnLoadMonster():void
		{
			Solider.fnGetInstance().addEventListener(TiGameEvent.LOAD_RESOURCES_FINISH_EVENT,fnLoadResourceFinishEventHandler);
			boss.fnGetInstance().addEventListener(TiGameEvent.LOAD_RESOURCES_FINISH_EVENT,fnLoadResourceFinishEventHandler);
			dragon.fnGetInstance().addEventListener(TiGameEvent.LOAD_RESOURCES_FINISH_EVENT,fnLoadResourceFinishEventHandler);
			m_nResourcesCount +=3

		}
		
		private function fnLoadUI():void
		{
			startCountDown.fnGetInstance().addEventListener(TiGameEvent.LOAD_RESOURCES_FINISH_EVENT,fnLoadResourceFinishEventHandler);
			m_nResourcesCount++

		}
		
		private function fnCheckResources():void
		{
			//if(m_nResourcesCompleteCount == m_nResourcesCount)
			{
				Starling.juggler.remove(m_tDelayCall);
				var ev:TiGameEvent = new TiGameEvent(TiGameEvent.LOAD_RESOURCES_FINISH_EVENT);
				dispatchEvent(ev);
			}
		//	else
			{
				m_tDelayCall = new DelayedCall(fnCheckResources,1);
				Starling.juggler.add(m_tDelayCall);
			}
		}
	}
}