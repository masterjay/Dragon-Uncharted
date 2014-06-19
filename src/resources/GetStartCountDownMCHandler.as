package resources
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class GetStartCountDownMCHandler extends Sprite
	{
		public function GetStartCountDownMCHandler()
		{
			super();
		}
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		
		[Embed(source="../resources/assets/startCountDown.png")]
		public static const TextureStartCountDown:Class
		[Embed(source="../resources/assets/startCountDown.xml",mimeType="application/octet-stream")]
		public static const XmlStartCountDown:Class
		public static var strTexturestartCountDownAttack:String = "TextureStartCountDown"

		public static var TextureAtlasStartCountDown:TextureAtlas

		public static function getAtlasStartCountDown():TextureAtlas
		{		
			if(TextureAtlasStartCountDown == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTexturestartCountDownAttack)
				var xml:XML = XML(new XmlStartCountDown());
				TextureAtlasStartCountDown = new TextureAtlas(texture,xml)
			}
		return TextureAtlasStartCountDown;
		}
		
		
		
		
		
		private static function fnGetMovieClipTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new GetStartCountDownMCHandler[name]();
				gameTextures[name] = starling.textures.Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		
		
	}
}