package sound
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	import config.TiMusicConfig;
	
	import starling.display.Sprite;
	
	public class GameSound extends TiSoundBase
	{
		public function GameSound()
		{
			super();
			group1_creationCompleteHandler();
		}
		
		protected function group1_creationCompleteHandler():void
		{
			// TODO Auto-generated method stub
			
			var ar:Array=new Array();
			ar.push(TiMusicConfig.SOUND_INGAME);
			fnInitSoundName(ar);
			
		}
		
		
	}
}