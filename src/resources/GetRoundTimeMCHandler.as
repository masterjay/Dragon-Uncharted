package resources
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class GetRoundTimeMCHandler extends Sprite
	{
		public function GetRoundTimeMCHandler()
		{
			super();
		}
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		[Embed(source="../resources/assets/roundtime/roundtime.png")]
		public static const TextureRoundTime:Class;
		[Embed(source="../resources/assets/roundtime/roundtime.xml",mimeType="application/octet-stream")]
		public static const XmlRoundTime:Class;
		public static var strTextureRoundTime:String = "TextureRoundTime"
		
		public static var TextureAtlasRoundTime:TextureAtlas
		
		public static function getAtlas():TextureAtlas
		{		
			if(TextureAtlasRoundTime == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureRoundTime)
				var xml:XML = XML(new XmlRoundTime());
				TextureAtlasRoundTime = new TextureAtlas(texture,xml)
			}
			return TextureAtlasRoundTime;
		}
		
		
		private static function fnGetMovieClipTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new GetRoundTimeMCHandler[name]();
				gameTextures[name] = starling.textures.Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		
		
	}
}