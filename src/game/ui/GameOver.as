package game.ui
{
	import event.TiGameEvent;
	
	import resources.GetAllResourcesHandler;
	import resources.GetTextureHandler;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameOver extends Sprite
	{
		private var m_imgGameOver:Image
		private var m_btnTryAgain:Button
		public function GameOver()
		{
			super();
			this.addChild(fnInitImg());
			this.addChild(fnInitButton());
		}
		
		private function fnInitImg():Image
		{
		//	m_imgGameOver = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strGAME_OVER));
			m_imgGameOver = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("gameover"));

			return m_imgGameOver;
		}
		
		private function fnInitButton():Button
		{
		//	m_btnTryAgain = new Button(GetTextureHandler.fnGetTexture(GetTextureHandler.strGAME_OVER_TRY_AGAIN));
			m_btnTryAgain = new Button(GetAllResourcesHandler.getAtlasAll().getTexture("game_over_try_again"));

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