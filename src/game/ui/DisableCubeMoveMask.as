package game.ui
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class DisableCubeMoveMask extends starling.display.Sprite
	{
		public function DisableCubeMoveMask()
		{
			fnCreateMask();
		}
		
		private function fnCreateMask():void
		{
			var shape:flash.display.Sprite = new flash.display.Sprite();
			var color:uint = 0x000000;
			var radius:uint = 0;
			var width:int = 280
			var height:int = 240	
			shape.graphics.beginFill(color);
			shape.graphics.drawRect(0,0,width,height);
			shape.graphics.endFill();
			var bmd:BitmapData = new BitmapData(width, height, true, 0x00000000);
			bmd.draw(shape);
			var tex:Texture = Texture.fromBitmapData(bmd);
			var img:Image = new Image(tex);
			img.x = 0;
			img.y = 0;
			img.alpha = 0.5
			addChild(img);
		}
	}
}