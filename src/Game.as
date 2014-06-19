package
{
	import flash.geom.Rectangle;
	
	import event.TiBattleEvent;
	import event.TiGameEvent;
	
	import game.GameStage;
	import game.LandingPage;
	
	import handler.LoadResourcesHandler;
	
	import resources.GetFontHandler;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.text.TextField;
	
	public class Game extends Sprite
	{
		private var m_loadlingPage:LandingPage
		private var m_gameStage:GameStage
		
				public function Game()
		{
			super();
			this.addEventListener(Event.ENTER_FRAME,fnAddedToStage);
		}
		private var myfont:GetFontHandler
		private function fnAddedToStage(e:Event):void
		{
			// TODO Auto Generated method stub
		//	this.addChild(mfont);
			this.removeEventListener(Event.ENTER_FRAME,fnAddedToStage);
			m_loadlingPage = new LandingPage()
			this.addChild(m_loadlingPage);
			m_loadlingPage.addEventListener(TiGameEvent.NAVIGATION_BATTLE_START_EVENT,fnGotoBattlePage);
			m_loadlingPage.addEventListener(TiGameEvent.INIT_COMPLETE,fnInitCompleteHandler);
			
			
		}
		
		
		private function fnGotoBattlePage(e:TiBattleEvent):void
		{
			m_loadlingPage.removeEventListener(TiGameEvent.NAVIGATION_BATTLE_START_EVENT,fnGotoBattlePage);
			this.removeChildren();
			m_gameStage = new GameStage();
			this.addChild(m_gameStage);
		}
		
		private function fnInitCompleteHandler(e:Event):void
		{
			var ev:TiGameEvent = new TiGameEvent(TiGameEvent.INIT_COMPLETE,"",true);
			dispatchEvent(ev);
		}
	}
}