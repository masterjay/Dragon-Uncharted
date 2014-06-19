package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.system.System;
	
	import event.TiGameEvent;
	
	import handler.server.UUIDHandler;
	
	import net.hires.debug.Stats;
	
	import resources.GetAllResourcesHandler;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Stage;
	import starling.events.ResizeEvent;
	import starling.textures.Texture; 

	//1136 720  960 /540
	[SWF(frameRate="60" , width="500", height="800", backgroundColor="0x000000")]
	public class Main extends Sprite
	{
		private var stats:Stats 
		private var m_starling:Starling
		private var m_preloader:GamePreloader
		public function Main()
		{
			super();

			fnPreloader();
		//	fnStartStarling();
		}
		
		
		private function fnPreloader():void
		{

			m_preloader= new GamePreloader();
			 m_preloader.addEventListener(Event.COMPLETE,fnStartStarling);
			this.addChild(m_preloader);
		}
		
		private function fnStartStarling(e:Event= null):void
		{
			m_preloader.width = stage.stageWidth;
			m_preloader.height = stage.stageHeight;
		
		
			stats = new Stats();
			this.addChild(stats);
			stage.align = StageAlign.TOP;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			m_starling = new Starling(Game,stage); 
			m_starling.antiAliasing = 1;
			m_starling.start();
			//stage.addEventListener(Event.RESIZE,onResize);
			Starling.current.stage.addEventListener(TiGameEvent.INIT_COMPLETE,fnInitCompleteHandler);
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, fnActiveApplication );
			
			NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, fnDectiveApplication); 
		}
		private function fnActiveApplication(e:Event):void
		{
			trace("starling start")
			m_starling.start();
			System.resume();
		}
		
		private function fnDectiveApplication(e:Event):void
		{
			trace("starling stop")
			m_starling.stop(true);
			//SoundMixer.stopAll()
				System.pause()
		}
		
		private function onResize(e:Event=null):void
		{
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = stage.stageWidth
			viewPortRectangle.height = stage.stageHeight;
		//	viewPortRectangle.width = 500
		//	viewPortRectangle.height = 600;
			Starling.current.viewPort = viewPortRectangle
		//	Starling.current.viewPort.x=100;
		//	m_starling.stage.stageWidth = stage.stageWidth;
		//	m_starling.stage.stageHeight = stage.stageHeight;
			m_starling.stage.stageWidth = 500;
			m_starling.stage.stageHeight = 800;
			trace("stageWidth "+ stage.stageWidth)
			trace("stageHeight " + stage.stageHeight)
			trace("m_starling.stage.stageWidth "+ m_starling.stage.stageWidth)
			trace("m_starling.stage.stageHeight "+ m_starling.stage.stageHeight)
		}
		
		private function fnInitCompleteHandler(e:TiGameEvent):void
		{
			onResize();
			this.removeChild(m_preloader);
		}
			
	}
}