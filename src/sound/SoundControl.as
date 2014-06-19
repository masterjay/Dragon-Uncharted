package sound
{
	import config.TiMusicConfig;
	
	import event.TiGameEvent;
	
	import starling.display.Sprite;
	

	public class SoundControl extends Sprite
	{
		private var gameOver:GameOverSound
		private var InGame:GameSound;
		private var soundBoss:GameDragonSound
		public function SoundControl()
		{
			gameOver = new GameOverSound();
			InGame = new GameSound();
			soundBoss = new GameDragonSound();
		}
		
		public function fnSelectMusic(strName:String):void
		{
			gameOver.fnStopMusic()
			InGame.fnStopMusic()
			soundBoss.fnStopMusic();
			
			switch(strName)
			{
				case TiMusicConfig.SOUND_INGAME:
					InGame.addEventListener(TiGameEvent.SOUND_DOWNLOAD_COMPLETE,fnPlayGameSound);

					InGame.fnSoundDownLoad();	
					break;
				case TiMusicConfig.SOUND_BOSS:
					soundBoss.fnBtnSoundPlay();	
					break;
				case TiMusicConfig.SOUND_GAMEOVER:
					gameOver.fnBtnSoundPlay();	
					break;
				
			}
		}
		
		private function fnPlayGameSound(e:TiGameEvent):void
		{
			InGame.fnBtnSoundPlay();
		}
	}
}