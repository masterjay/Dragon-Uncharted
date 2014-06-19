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
	
	import event.TiGameEvent;
	
	import starling.display.Sprite;
	
	public class TiSoundBase extends Sprite
	{
		public function TiSoundBase()
		{
			super();
		}
		
		private var m_soundCollection:Array
		private var m_soundLoader:Array
		private var m_SoundChannel:SoundChannel
		private var m_sound:Sound;
		private var m_bIsPlaying:Boolean = false;
		private var m_nPosition:int;
		private var m_nSelectedSound:int=0;
		private var m_bMute:Boolean=false;
		private var m_bLoop:Boolean
		private var m_bRandom:Boolean
		private var m_bdownloadComplete:Boolean=false;
		
		protected function fnInitSoundName(ar:Array):void
		{
			m_soundCollection=new Array();
			for(var i:int = 0 ; i < ar.length;i++)
			{
				m_soundCollection.push({url:ar[i]});
			}
			m_soundLoader=new Array();
			fnSoundDownLoad()
		}
		
		public function fnSoundDownLoad(e:Event=null):void
		{
			if(m_bdownloadComplete && m_bIsPlaying==false)
			{
				fnDownloadComplete();
				return
			}
			m_sound=new Sound();
			if(!m_soundCollection)
			{
				return;
			}
			var request:URLRequest= new URLRequest(m_soundCollection[m_nSelectedSound].url);
			m_sound.load(request);
			m_sound.addEventListener( IOErrorEvent.IO_ERROR, handleIOErr );
			m_sound.addEventListener(Event.COMPLETE,fnDownloadSoundComplete)
		}
		private function handleIOErr( event: IOErrorEvent ): void
		{
			//trace("sound IO error:"+ event.currentTarget)
			fnBtnSoundNext();
		}
		
		private function fnDownloadSoundComplete(e:Event):void
		{
			//var key:String= m_soundCollection[m_nSelectedSound].name
			//var url:String=	m_soundCollection[m_nSelectedSound].url;
			m_soundLoader.push(e.currentTarget);
			if(m_nSelectedSound<m_soundCollection.length-1)
			{
				m_nSelectedSound++
					fnSoundDownLoad();
			}
			else
			{
				m_bdownloadComplete = true
				var ev:TiGameEvent = new TiGameEvent(TiGameEvent.SOUND_DOWNLOAD_COMPLETE);	
					dispatchEvent(ev);
			//	fnDownloadComplete();
			}
			
		}
		
		private function fnDownloadComplete():void
		{
			m_nSelectedSound=0;
			fnBtnSoundPlay();
		}
		public function fnBtnSoundPlay(e:MouseEvent=null):void
		{
			if(m_SoundChannel)
			{
				m_SoundChannel.stop();
				m_SoundChannel=null
			}
			
			m_sound=null;
			m_sound=new Sound();
			
			/* var request:URLRequest = new URLRequest(m_soundCollection[m_nSelectedSound].url);
			m_sound.load(request);
			m_sound.addEventListener( IOErrorEvent.IO_ERROR, handleIOErr ); */
			m_sound=m_soundLoader[m_nSelectedSound]
			
			if(m_nPosition!=0)
			{
				m_SoundChannel = m_sound.play(m_nPosition);
			}
			else
			{
				m_SoundChannel=m_sound.play();
				//	mcSoundControlPanel.Txt_MusicName.text=m_soundCollection[m_nSelectedSound].name;
				m_SoundChannel.addEventListener(Event.SOUND_COMPLETE, fnSoundEnd); 
				
			}
			if(m_bMute==true)
			{
				m_SoundChannel.soundTransform=new SoundTransform(0)
			}
			else
			{
				m_SoundChannel.soundTransform=new SoundTransform(1)
			}
			
			m_bIsPlaying=true;
			
		}
		
		private  function fnSoundEnd(event:Event):void 
		{ 
			if(m_bLoop)
			{
				fnBtnSoundPlay();
			}
			else if(m_bRandom)
			{
				m_nSelectedSound=Math.round(Math.random()*(m_soundCollection.length-1));
				m_nPosition=0
				fnBtnSoundPlay();
			}
			else
			{
				fnStopMusic();
				//fnBtnSoundNext();
			}
			
		}
		private function fnBtnSoundNext(e:MouseEvent=null):void
		{
			if(m_nSelectedSound==m_soundCollection.length-1)
			{
				m_nSelectedSound=0;
			}
			else
			{
				m_nSelectedSound++;
			}
			m_nPosition=0
			fnBtnSoundPlay();
		}
		private function fnBGMHandler(e:MouseEvent):void
		{
			if(m_SoundChannel)
			{
				
				if(m_bMute==true)
				{
					return;
				}
				m_SoundChannel.soundTransform=new SoundTransform(1)
				
				
			}
		}
		
		public function fnStopMusic():void
		{
			if(m_SoundChannel)
			{
				m_SoundChannel.stop();
				m_SoundChannel=null
				m_bIsPlaying = false;
			}
		}
	}
}