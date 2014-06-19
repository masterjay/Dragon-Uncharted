package game.cube
{
	import base.TiBlueCube;
	import base.TiCube;
	
	import event.TiCubeEvent;
	
	import resources.GetAllResourcesHandler;
	import resources.GetSoliderMCHandler;
	import resources.GetTextureHandler;
	
	import starling.display.Image;
	
	public class BlueCube extends TiBlueCube
	{

		public function BlueCube()
		{
			super();
			fnInit();
		}
		private var image:Image
		private function fnInit():void
		{
			// image = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strCUBE_BLUE));
			 image = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("cube_blue"));
			this.addChild(image);
		}
		
		override public function fnPlayBreakAni():void
		{
			image.visible = false;
			super.fnPlayBreakAni();
		}
	}
}