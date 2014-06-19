package game.cube
{
	import base.TiGreenCube;
	
	import resources.GetAllResourcesHandler;
	import resources.GetTextureHandler;
	
	import starling.display.Image;
	
	public class GreenCube extends TiGreenCube
	{
		public function GreenCube()
		{
			super();
			fnInit();
		}
		private var image:Image

		private function fnInit():void
		{
			// image = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strCUBE_GREEN));
			 image = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("cube_green"));
			this.addChild(image);
		}
		
		override public function fnPlayBreakAni():void
		{
			image.visible = false;
			super.fnPlayBreakAni();
		}
	}
}