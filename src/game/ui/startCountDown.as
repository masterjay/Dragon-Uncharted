package game.ui
{
	
	import event.TiBattleEvent;
	import event.TiGameEvent;
	
	import resources.GetAllResourcesHandler;
	import resources.GetStartCountDownMCHandler;
	import resources.GetTextureHandler;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class startCountDown extends Sprite
	{
		public function startCountDown()
		{
			super();
			this.addChild(fnInitCountDownBase());
			this.addChild(fnInitCountDown());
			this.addChild(fnInitCircle());
		}
		private static var m_Instance:startCountDown;
		private var mcCountDown:MovieClip
		private var mcCircle:MovieClip
		private var m_countDownBase:Image 
		
		private function fnInitCountDownBase():Image
		{
		//	m_countDownBase = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strCOUNT_DOWN_BASE));
			m_countDownBase = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("countdownbase"));
			return m_countDownBase;
			
		}
		
		private function fnInitCountDown():MovieClip
		{
			if(mcCountDown == null)
			{
				mcCountDown = new starling.display.MovieClip(GetStartCountDownMCHandler.getAtlasStartCountDown().getTextures("mc_count_down"),20);
				mcCountDown.x = 65
				mcCountDown.y = 72
			}
			return mcCountDown;
		}
		
		private function fnInitCircle():MovieClip
		{
			if(mcCircle == null)
			{
				mcCircle = new starling.display.MovieClip(GetStartCountDownMCHandler.getAtlasStartCountDown().getTextures("mc_cycle"),20);
				mcCircle.x = 55;
				mcCircle.y = 45
			}
			return mcCircle;
		}
		
		
		public static function fnGetInstance():startCountDown
		{
			if (m_Instance == null)
			{
				m_Instance=new startCountDown();
			}
			return m_Instance;
		}
		
		public function fnPalyAni():void
		{
			this.visible = true;
			mcCountDown.addEventListener(Event.COMPLETE,fnCountDownFinish);
			starling.core.Starling.juggler.add(mcCountDown);
			starling.core.Starling.juggler.add(mcCircle);
		}
		
		private function fnCountDownFinish(e:Event):void
		{   this.visible = false
			mcCountDown.removeEventListener(Event.COMPLETE,fnCountDownFinish);
			starling.core.Starling.juggler.remove(mcCountDown);
			starling.core.Starling.juggler.remove(mcCircle);
			var ev:TiGameEvent = new TiGameEvent(TiGameEvent.COUNT_DOWN_FINISH_EVENT);
			dispatchEvent(ev);
		}
	}
}