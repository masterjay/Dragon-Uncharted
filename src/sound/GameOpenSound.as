package sound
{
	import config.TiMusicConfig;
	
	
	public class GameOpenSound extends TiSoundBase
	{
		public function GameOpenSound()
		{
			super();
			group1_creationCompleteHandler();
		}
		
		
		
	
		protected function group1_creationCompleteHandler():void
		{
			// TODO Auto-generated method stub
			var ar:Array = new Array();
			ar.push(TiMusicConfig.SOUND_GAMEOPEN);
			fnInitSoundName(ar);
			
		}
		
		
	}
}