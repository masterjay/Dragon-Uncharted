package resources
{
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class GetTextureHandler extends starling.display.Sprite
	{
		public function GetTextureHandler()
		{
			super();
		}
				
		/*[Embed(source="../resources/assets/logo_x.png")]		
		private static const GAME_LOGO:Class;
		public static var strGAME_LOGO:String = "GAME_LOGO";
		
		[Embed(source="../resources/assets/button_start.png")]		
		private static const BUTTON_START:Class;
		public static var strBUTTON_START:String = "BUTTON_START";
			
		[Embed(source="../resources/assets/cubeStage.png")]
		private static const  CUBE_STAGE_BACKGROUND:Class;
		public static var strCUBE_STAGE_BACKGROUND:String = "CUBE_STAGE_BACKGROUND";
			
		[Embed(source="../resources/assets/stage_base.png")]
		private static const  CUBE_STAGE_BASE:Class;
		public static var strCUBE_STAGE_BASE:String = "CUBE_STAGE_BASE";
		
		[Embed(source="../resources/assets/cube/cube_blue.png")]
		private static const  CUBE_BLUE:Class;
		public static var strCUBE_BLUE:String = "CUBE_BLUE";
			
		[Embed(source="../resources/assets/cube/cube_green.png")]
		private static const  CUBE_GREEN:Class;
		public static var strCUBE_GREEN:String = "CUBE_GREEN";
			
		[Embed(source="../resources/assets/cube/cube_pink.png")]
		private static const  CUBE_PINK:Class;
		public static var strCUBE_PINK:String = "CUBE_PINK";
			
		[Embed(source="../resources/assets/cube/cube_red.png")]
		private static const  CUBE_RED:Class;
		public static var strCUBE_RED:String = "CUBE_RED";
			
		[Embed(source="../resources/assets/cube/cube_yellow.png")]
		private static const  CUBE_YELLOW:Class;
		public static var strCUBE_YELLOW:String = "CUBE_YELLOW";
			
		[Embed(source="../resources/assets/countdownbase.png")]
		private static const  COUNT_DOWN_BASE:Class;
		public static var strCOUNT_DOWN_BASE:String = "COUNT_DOWN_BASE";
		
		[Embed(source="../resources/assets/life/life_base.png")]
		private static const  LIFE_BASE:Class;
		public static var strLIFE_BASE_BASE:String = "LIFE_BASE";
		
		
		[Embed(source="../resources/assets/victoryAndLose/game_over_try_again.png")]
		private static const GAME_OVER_TRY_AGAIN:Class;
		public static var strGAME_OVER_TRY_AGAIN:String = "GAME_OVER_TRY_AGAIN";
		
		
		[Embed(source="../resources/assets/victoryAndLose/gameover.png")]
		private static const  GAME_OVER:Class;
		public static var strGAME_OVER:String = "GAME_OVER";
		
		
		[Embed(source="../resources/assets/victoryAndLose/victory_try_again.png")]
		private static const  VICTORY_TRY_AGAIN:Class;
		public static var strVICTORY_TRY_AGAIN:String = "VICTORY_TRY_AGAIN";
		
		
		[Embed(source="../resources/assets/victoryAndLose/victory.png")]
		private static const  VICTORY:Class;
		public static var strVICTORY:String = "VICTORY";
		*/
		private static var gameTextures:Dictionary = new Dictionary();

		
		public static function fnGetTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new GetTextureHandler[name]();
				gameTextures[name] = starling.textures.Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
	}
}