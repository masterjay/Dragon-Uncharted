package resources
{
	import starling.display.Sprite;
	
	public class GetFontHandler extends Sprite
	{
		public function GetFontHandler()
		{
			super();
		}
		
		[Embed(source="../resources/font/badabb__/badabb__.ttf", fontFamily="myFont" , embedAsCFF="false")]		
		public static const myFont:Class;
		
		
		
	}
}