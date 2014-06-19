package sound
{
	import config.TiMusicConfig;

	public class GameOverSound extends TiSoundBase
	{
		public function GameOverSound()
		{
			super();
			
			fnInit();
		}
		
		private function fnInit():void
		{
			// TODO Auto Generated method stub
			var ar:Array = new Array();
			ar.push(TiMusicConfig.SOUND_GAMEOVER);
			fnInitSoundName(ar);
		}
	}
}