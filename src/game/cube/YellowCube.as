package game.cube
{
	import base.TiYellowCube;
	
	import resources.GetAllResourcesHandler;
	import resources.GetTextureHandler;
	
	import starling.display.Image;
	
	public class YellowCube extends TiYellowCube
	{
		public function YellowCube()
		{
			super();
			fnInit();
		}
		private var image:Image

		private function fnInit():void
		{
		// image = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strCUBE_YELLOW));
		 image = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("cube_yellow"));
			this.addChild(image);
		}
		
		override public function fnPlayBreakAni():void
		{
			image.visible = false;
			super.fnPlayBreakAni();
		}
	}
}