package sound
{
	import config.TiMusicConfig;

	public class GameDragonSound extends TiSoundBase
	{
		public function GameDragonSound()
		{
			super();
			fnInit();
		}
		
		private function fnInit():void
		{
			var ar:Array = new Array();
			ar.push(TiMusicConfig.SOUND_BOSS);
			fnInitSoundName(ar);
			
		}
	}
}