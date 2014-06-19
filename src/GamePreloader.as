package
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import starling.display.Sprite;

	public class GamePreloader extends flash.display.Sprite
	{
		public function GamePreloader()
		{
			init();
		}
		
		private function init():void
		{
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest("../resources/assets/swf/loading.swf");
			this.addChild(loader);

			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaded);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);

			loader.load(request);
			
		}
		
		
		private function onLoaded(e:Event):void
		{
			trace("load sucess")
			var mc:MovieClip = e.currentTarget.content as MovieClip;
			this.addChild(mc);
			var ev:Event = new Event(Event.COMPLETE);
			dispatchEvent(ev);
		}
		
		private function onError(e:Event):void
		{
			trace("load fail")
						
		}
		private function onProgress(e:Event):void
		{
			trace("load progress")
		}
	}
}