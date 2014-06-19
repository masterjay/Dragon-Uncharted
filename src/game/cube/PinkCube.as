package game.cube
{
	import base.TiPinkCube;
	
	import resources.GetAllResourcesHandler;
	import resources.GetTextureHandler;
	
	import starling.display.Image;
	
	public class PinkCube extends TiPinkCube
	{
		public function PinkCube()
		{
			super();
			fnInit();
		}
		private var image:Image

		private function fnInit():void
		{
			// image = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strCUBE_PINK));
			 image = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("cube_pink"));
			this.addChild(image);
		}
		
		override public function fnPlayBreakAni():void
		{
			image.visible = false;
			super.fnPlayBreakAni();
		}
	}
}