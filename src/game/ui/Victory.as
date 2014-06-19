package game.ui
{
	import event.TiGameEvent;
	
	import resources.GetAllResourcesHandler;
	import resources.GetTextureHandler;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Victory extends Sprite
	{
		private var m_imgVictory:Image
		private var m_btnTryAgain:Button
		public function Victory()
		{
			super();
			this.addChild(fnInitImg());
			this.addChild(fnInitButton());
		}
		
		private function fnInitImg():Image
		{
		//	m_imgVictory = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strVICTORY));
			m_imgVictory = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("victory"));
			return m_imgVictory;
		}
		
		private function fnInitButton():Button
		{
		//	m_btnTryAgain = new Button(GetTextureHandler.fnGetTexture(GetTextureHandler.strVICTORY_TRY_AGAIN));
			m_btnTryAgain = new Button(GetAllResourcesHandler.getAtlasAll().getTexture("victory_try_again"));
			m_btnTryAgain.addEventListener(Event.TRIGGERED,fnRestartGame);
			m_btnTryAgain.x = 110;
			m_btnTryAgain.y = 110;
			return m_btnTryAgain;
		}
		
		private function fnRestartGame():void
		{
			// TODO Auto Generated method stub
			dispatchEventWith(TiGameEvent.GAME_RESTART);
		}
	}
}