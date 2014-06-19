package game.cube
{
	import base.TiCube;
	import base.TiRedCube;
	
	import resources.GetAllResourcesHandler;
	import resources.GetTextureHandler;
	
	import starling.display.Image;
	
	public class RedCube extends TiRedCube
	{
		public function RedCube()
		{
			super();
			fnInit();
		}
		private var image:Image

		private function fnInit():void
		{
			// image = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strCUBE_RED));
			 image = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("cube_red"));
			this.addChild(image);
		}
		
		override public function fnPlayBreakAni():void
		{
			image.visible = false;
			super.fnPlayBreakAni();
		}
		
		
	}
}