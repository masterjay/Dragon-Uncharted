package handler
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	

	public class TiVoiceCollector extends EventDispatcher
	{
		
	
		
		
		private var m_sound:Sound;
		public static var m_SoundSwapCube:Sound;
		public static var m_SoundCubeBreak:Sound;
		public static var m_SoundAttack:Sound
		public static var m_Soundopening:Sound;
		public static var m_Soundonepoint09:Sound;
		public static var m_SoundDar:Sound
		public static var m_SoundDie:Sound
		public static var m_SoundDragonAttack:Sound
		public static var m_SoundDragonShow:Sound
		public static var m_SoundDragonAttackGathering:Sound
		
		[Embed(source="../resources/assets/sound/cubebreak.mp3")]		
		private static var soundCubeBreak:Class;
		
		[Embed(source="../resources/assets/sound/cubechange.mp3")]		
		private static var soundCubeChange:Class;
		
		[Embed(source="../resources/assets/sound/attack.mp3")]		
		private static var soundAttack:Class;
		
		[Embed(source="../resources/assets/sound/dardar.mp3")]		
		private static var soundDar:Class;

		[Embed(source="../resources/assets/sound/die.mp3")]		
		private static var soundDie:Class;
		[Embed(source="../resources/assets/sound/dragonattack.mp3")]		
		private static var soundDragonAttack:Class;
		
		[Embed(source="../resources/assets/sound/dragonshow.mp3")]		
		private static var soundDragonShow:Class;
		
		[Embed(source="../resources/assets/sound/dragonattackgathering.mp3")]		
		private static var soundDragonAttackGathering:Class;
				
		public function TiVoiceCollector()
		{
		}
		
		public static function fnPlaySwapCube():void
		{
			if(m_SoundSwapCube == null)
			{
				m_SoundSwapCube = new soundCubeChange();
			}
			if(m_SoundSwapCube)
			{
				m_SoundSwapCube.play(0,0,new SoundTransform(1));
			}
		}
		public static function fnPlayCubeBreak():void
		{
			if(m_SoundCubeBreak == null)
			{
				m_SoundCubeBreak = new soundCubeBreak(); 
			}
			if(m_SoundCubeBreak)
			{
				m_SoundCubeBreak.play(0,0,new SoundTransform(1));
			}
		}
		
		public static function fnPlayAttack():void
		{
			if(m_SoundAttack == null)
			{
				m_SoundAttack = new soundAttack(); 
			}
			if(m_SoundAttack)
			{
				m_SoundAttack.play(0,0,new SoundTransform(1));
			}
		}
		
		public static function fnPlayDar():void
		{
			if(m_SoundDar == null)
			{
				m_SoundDar = new soundDar(); 
			}
			if(m_SoundDar)
			{
				m_SoundDar.play(0,0,new SoundTransform(1));
			}
		}
		
		public static function fnPlayOpening():void
		{
			if(m_Soundopening)
			{
				m_Soundopening.play(0,0,new SoundTransform(1));
			}
		}
		
		public static function fnStopPlayOpening():void
		{
			if(m_Soundopening)
			{
				m_Soundopening.play(m_Soundopening.length);
			}
		}
		
		public static function fnPlayonepoint09():void
		{
			if(m_Soundonepoint09)
			{
				m_Soundonepoint09.play(0,0,new SoundTransform(1));
			}
		}
		
		public static function fnPlayDie():void
		{
			if(m_SoundDie== null)
			{
				m_SoundDie = new soundDie(); 
			}
			if(m_SoundDie)
			{
				m_SoundDie.play(0,0,new SoundTransform(1));
			}
		}
		
		public static function fnPlayDragonAttack():void
		{
			if(m_SoundDragonAttack== null)
			{
				m_SoundDragonAttack = new soundDragonAttack(); 
			}
			if(m_SoundDragonAttack)
			{
				m_SoundDragonAttack.play(0,0,new SoundTransform(1));
			}
		}
		
		public static function fnPlayDragonShow():void
		{
			if(m_SoundDragonShow== null)
			{
				m_SoundDragonShow = new soundDragonShow(); 
			}
			if(m_SoundDragonShow)
			{
				m_SoundDragonShow.play(0,0,new SoundTransform(1));
			}
		}
		public static function fnPlayDragonAttackGathering():void
		{
			if(m_SoundDragonAttackGathering== null)
			{
				m_SoundDragonAttackGathering = new soundDragonAttackGathering(); 
			}
			if(m_SoundDragonAttackGathering)
			{
				m_SoundDragonAttackGathering.play(0,0,new SoundTransform(1));
			}
		}
	}
}